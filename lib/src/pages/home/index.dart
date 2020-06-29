import 'dart:io';

import 'package:flutter/material.dart';

import 'package:firebase_database/firebase_database.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../components/menu.dart';
import '../../templates/case.dart';
import '../../templates/profile.dart';
import '../../utils/texts.dart';
import '../../routes.dart';

class Home extends StatefulWidget {
  final Function() logout;
  final FirebaseDatabase database;
  final Profile profile;
  const Home(this.logout, this.database, this.profile, {Key key})
      : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  RefreshController refreshController =
      RefreshController(initialRefresh: false);

  final searcher = TextEditingController();

  List<Case> cases;

  List<Case> get filteredCases => cases
      .where((c) =>
          RegExp(searcher.text.toLowerCase()).hasMatch(c.title.toLowerCase()))
      .toList();

  void _onRefresh() async {
    await updateCases();
    refreshController.refreshCompleted();
  }

  Future<void> updateCases() async {
    var snap = await widget.database
        .reference()
        .child('cases')
        .orderByChild('locale')
        .equalTo(Platform.localeName)
        .once();
    print(snap.value);
    if (snap.value != null) {
      var result = <Case>[];
      final keys = (snap.value as Map).keys.toList();
      for (var k in keys) {
        var map = snap.value[k];
        if (map['ownerId'] != widget.profile.id && map['status'] == 0) {
          print(map);
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

  Future<void> init() async {
    await updateCases();
  }

  @override
  void initState() {
    super.initState();
    searcher.addListener(() => setState(() {}));
    init();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, c) {
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
          title: Text(Texts.home),
          centerTitle: true,
          actions: [
            IconButton(
              icon: Icon(Icons.description),
              onPressed: () => Navigator.of(context)
                  .pushReplacementNamed(Routes.currentCasesRoute),
              tooltip: Texts.acts,
            )
          ],
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
            }
          }),
          backgroundColor: Theme.of(context).primaryColor,
          child: Icon(
            Icons.add,
            color: Colors.white,
          ),
        ),
        body: Container(
          height: 16 * h,
          width: 9 * w,
          child: cases == null
              ? Center(child: CircularProgressIndicator())
              : cases.isEmpty
                  ? SmartRefresher(
                      header: WaterDropHeader(
                        complete: Icon(Icons.check, color: Colors.grey),
                      ),
                      controller: refreshController,
                      onRefresh: _onRefresh,
                      child: SingleChildScrollView(
                        physics: NeverScrollableScrollPhysics(),
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: 1.5 * w,
                            vertical: 2.5 * h,
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                Texts.noCases,
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
                      ),
                    )
                  : Stack(
                      children: [
                        //Search
                        Positioned(
                          top: 0.5 * h,
                          height: 1.25 * h,
                          left: 0.5 * w,
                          right: 0.5 * w,
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Theme.of(context).primaryColor,
                                width: 2,
                              ),
                              borderRadius: BorderRadius.circular(h / 2),
                            ),
                            child: TextField(
                              controller: searcher,
                              autofocus: false,
                              textAlignVertical: TextAlignVertical.center,
                              cursorColor: Theme.of(context).primaryColor,
                              textAlign: TextAlign.start,
                              textInputAction: TextInputAction.search,
                              onSubmitted: (_) =>
                                  FocusScope.of(context).unfocus(),
                              style: TextStyle(
                                color: Theme.of(context).primaryColor,
                                fontSize: h * 0.5,
                              ),
                              decoration: InputDecoration(
                                hintText: Texts.search,
                                border: InputBorder.none,
                                prefixIcon: Icon(Icons.search, size: h * 0.75),
                              ),
                            ),
                          ),
                        ),
                        //Cases
                        Positioned(
                          top: 2.25 * h,
                          bottom: 0.5 * h,
                          left: 0.5 * w,
                          right: 0.5 * w,
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Theme.of(context).primaryColor,
                                width: 2,
                              ),
                              borderRadius: BorderRadius.circular(h / 2),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(h / 2),
                              child: SmartRefresher(
                                header: WaterDropHeader(
                                  complete:
                                      Icon(Icons.check, color: Colors.grey),
                                ),
                                controller: refreshController,
                                onRefresh: _onRefresh,
                                child: ListView.separated(
                                  physics: BouncingScrollPhysics(),
                                  padding:
                                      EdgeInsets.symmetric(vertical: h / 2),
                                  itemBuilder: (context, index) {
                                    final c = filteredCases[index];
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
                                                color: Theme.of(context)
                                                    .primaryColor,
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
                                  itemCount: filteredCases.length,
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
        ),
      );
    });
  }
}
