import 'package:flutter/material.dart';

import 'package:firebase_database/firebase_database.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../routes.dart';
import '../../utils/texts.dart';
import '../../templates/case.dart';
import '../../templates/profile.dart';
import '../../components/menu.dart';

class CaseHistory extends StatefulWidget {
  final Function() logout;
  final FirebaseDatabase database;
  final Profile profile;
  CaseHistory(this.logout, this.database, this.profile, {Key key})
      : super(key: key);

  @override
  _CaseHistoryState createState() => _CaseHistoryState();
}

class _CaseHistoryState extends State<CaseHistory> {
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
        .orderByChild('heroId')
        .equalTo(widget.profile.id)
        .once();
    if (snap.value != null) {
      var result = <Case>[];
      final keys = (snap.value as Map).keys.toList();
      for (var k in keys) {
        var map = snap.value[k];
        if (map['status'] == 2) {
          result.add(Case.fromMap(map, k));
        }
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
            title: Text(Texts.caseHistoy),
            centerTitle: true,
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
                                    Texts.noAct,
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
                              return Container(
                                width: 8 * w,
                                child: ListTile(
                                  onTap: () => Navigator.of(context)
                                      .pushNamed(Routes.caseRoute,
                                          arguments: c.id)
                                      .then((_) => updateCases()),
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
                                  title: Text(c.title),
                                  subtitle: Text(
                                    c.description,
                                    maxLines: 2,
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
