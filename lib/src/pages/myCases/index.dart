import 'package:flutter/material.dart';

import 'package:firebase_database/firebase_database.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../routes.dart';
import '../../utils/texts.dart';
import '../../templates/case.dart';
import '../../templates/profile.dart';
import '../../components/menu.dart';

class MyCases extends StatefulWidget {
  final Function() logout;
  final FirebaseDatabase database;
  final Profile profile;
  const MyCases(this.logout, this.database, this.profile, {Key key})
      : super(key: key);

  @override
  _MyCasesState createState() => _MyCasesState();
}

class _MyCasesState extends State<MyCases> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final refreshController = RefreshController(initialRefresh: false);
  List<Case> cases;

  void _onRefresh() async {
    await updateCases();
    refreshController.refreshCompleted();
  }

  Future<void> updateCases() async {
    var snap = await widget.database
        .reference()
        .child('cases')
        .orderByChild('ownerId')
        .equalTo(widget.profile.id)
        .once();
    if (snap.value != null) {
      var result = <Case>[];
      final keys = (snap.value as Map).keys.toList();
      for (var k in keys) {
        var map = snap.value[k];
        result.add(Case.fromMap(map, k));
      }
      setState(() => cases = result);
    } else {
      setState(() {
        if (cases == null) {
          cases = [];
        }
      });
    }
  }

  @override
  void initState() {
    super.initState();
    updateCases();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, c) {
        final h = c.constrainHeight() / 16;
        final w = c.constrainWidth() / 9;
        return Scaffold(
          key: scaffoldKey,
          drawer: MenuDrawer(widget.logout, widget.profile),
          appBar: AppBar(
            leading: IconButton(
              icon: Icon(Icons.menu),
              onPressed: () => scaffoldKey.currentState.openDrawer(),
              tooltip: Texts.openMenu,
            ),
            title: Text(Texts.myCases),
            centerTitle: true,
          ),
          floatingActionButton: FloatingActionButton(
            tooltip: Texts.createCase,
            onPressed: () => Navigator.of(context)
                .pushNamed(Routes.newCaseRoute)
                .then((value) {
              if (value != null) {
                widget.database
                    .reference()
                    .child('cases')
                    .push()
                    .set((value as Case).toMap());
                updateCases();
              }
            }),
            backgroundColor: Theme.of(context).primaryColor,
            child: Icon(
              Icons.add,
              color: Colors.white,
            ),
          ),
          body: cases == null
              ? Center(child: CircularProgressIndicator())
              : Scrollbar(
                  child: SmartRefresher(
                    controller: refreshController,
                    onRefresh: _onRefresh,
                    header: WaterDropHeader(
                      complete: Icon(Icons.check, color: Colors.grey),
                    ),
                    child: cases.isEmpty
                        ? SingleChildScrollView(
                            physics: NeverScrollableScrollPhysics(),
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: 1.5 * w,
                                vertical: 2.5 * h,
                              ),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    Texts.noSelfCases,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: Theme.of(context).primaryColor,
                                      fontSize: h / 1.5,
                                    ),
                                  ),
                                  Container(
                                    height: 4 * h,
                                    child: Image.asset(
                                      'assets/images/zzz.png',
                                      color: Theme.of(context).primaryColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          )
                        : ListView.separated(
                            physics: BouncingScrollPhysics(),
                            padding: EdgeInsets.symmetric(vertical: h / 2),
                            itemBuilder: (context, index) {
                              final c = cases[index];
                              Future<String> getTitle() async {
                                if (c.heroId != null) {
                                  var snap = await widget.database
                                      .reference()
                                      .child('users/${c.heroId}/name')
                                      .once();
                                  var parts = [
                                    '',
                                    '${Texts.inProgressby} ${snap.value}',
                                    '${Texts.finishedby} ${snap.value}'
                                  ];
                                  return "${c.title} - ${parts[c.status.index]}";
                                } else {
                                  return c.title;
                                }
                              }

                              return Container(
                                width: 8 * w,
                                child: ListTile(
                                  onTap: () => Navigator.of(context)
                                      .pushNamed(Routes.caseRoute,
                                          arguments: c.id)
                                      .then((v) async {
                                    if (v.runtimeType == bool && !v) {
                                      await widget.database
                                          .reference()
                                          .child('cases/${c.id}')
                                          .remove();
                                    }
                                    updateCases();
                                  }),
                                  leading: CircleAvatar(
                                    radius: h / 2,
                                    backgroundColor:
                                        Theme.of(context).accentColor,
                                    child: FittedBox(
                                      child: Text(
                                        c.hp.toString(),
                                        style: TextStyle(
                                          color: Theme.of(context).primaryColor,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                  title: FutureBuilder<String>(
                                    builder: (context, snapshot) {
                                      if (snapshot.data != null) {
                                        return Text(
                                          snapshot.data,
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 2,
                                        );
                                      }
                                      return FittedBox(child: Text(c.title));
                                    },
                                    future: getTitle(),
                                  ),
                                  subtitle: Text(
                                    c.description,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    textAlign: TextAlign.justify,
                                  ),
                                  trailing: Icon(
                                    Icons.navigate_next,
                                    color: Theme.of(context).primaryColor,
                                  ),
                                ),
                              );
                            },
                            separatorBuilder: (_, __) => Divider(),
                            itemCount: cases.length,
                          ),
                  ),
                ),
        );
      },
    );
  }
}
