import 'package:flutter/material.dart';

import 'package:firebase_database/firebase_database.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../templates/profile.dart';
import '../../templates/case.dart';
import '../../utils/texts.dart';
import '../../routes.dart';

class CasePage extends StatefulWidget {
  final Profile profile;
  final FirebaseDatabase database;
  final Function(Profile) updateProfile;
  CasePage(this.profile, this.database, this.updateProfile, {Key key})
      : super(key: key);

  @override
  _CasePageState createState() => _CasePageState();
}

class _CasePageState extends State<CasePage> {
  bool isFirstBuild = true;
  String caseId;

  Case _case;
  Profile _owner;

  onFirstBuild(String cid) {
    setState(() {
      caseId = cid;
      isFirstBuild = false;
    });
  }

  onValue(event) async {
    var map;
    try {
      map = event.snapshot.value;
    } catch (err) {
      event = await event;
      map = (await event).value;
    }

    if (map != null && (_case == null || !_case.equalTo(map))) {
      _case = Case.fromMap(map, caseId);
      if (_owner == null) {
        _owner = Profile.fromMap(
            (await widget.database
                    .reference()
                    .child('users')
                    .child(_case.ownerId)
                    .once())
                .value,
            _case.ownerId);
      }
      WidgetsBinding.instance.addPostFrameCallback((_) => setState(() {}));
    }
  }

  Widget getAction(context, h, w) {
    if (widget.profile.id == _case.ownerId) {
      return Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            RaisedButton(
              color: Theme.of(context).accentColor,
              child: Text(Texts.update),
              onPressed: () => Navigator.of(context)
                  .pushNamed(Routes.newCaseRoute, arguments: _case)
                  .then((value) {
                if (value != null) {
                  widget.database
                      .reference()
                      .child('cases/${_case.id}')
                      .set((value as Case).toMap());
                }
              }),
            ),
            RaisedButton(
              color: Theme.of(context).primaryColor,
              child: Text(
                Texts.delete,
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              onPressed: () => Navigator.of(context).pop(false),
            ),
          ],
        ),
      );
    }
    switch (_case.status) {
      case CaseStatus.TO_DO:
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 1.5 * h,
              width: 4 * w,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(h * 0.75),
                child: RaisedButton(
                  color: Theme.of(context).primaryColor,
                  onPressed: () {
                    widget.database
                        .reference()
                        .child('cases/$caseId')
                        .update({"status": 1, "heroId": widget.profile.id});
                  },
                  child: FittedBox(
                    child: Text(
                      Texts.acceptCase,
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: h,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            IconButton(
              color: Theme.of(context).primaryColor,
              icon: Icon(Icons.mail),
              onPressed: () async {
                final subject = "We The Heroes: ${_case.title}";
                final url = 'mailto:${_owner.email}?subject=$subject';
                if (await canLaunch(url)) await launch(url);
              },
            ),
          ],
        );
      case CaseStatus.IN_PROGRESS:
        if (widget.profile.id == _case.heroId) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 1.5 * h,
                width: 4 * w,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(h * 0.75),
                  child: RaisedButton(
                    color: Theme.of(context).primaryColor,
                    onPressed: () {
                      widget.database
                          .reference()
                          .child('cases/$caseId')
                          .update({"status": 2});
                      widget.database
                          .reference()
                          .child('users/${widget.profile.id}')
                          .update({"hp": widget.profile.hp + _case.hp});
                      var p = widget.profile;
                      p.hp += _case.hp;
                      widget.updateProfile(p);
                    },
                    child: FittedBox(
                      child: Text(
                        Texts.finishCase,
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: h,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              IconButton(
                color: Theme.of(context).primaryColor,
                icon: Icon(Icons.mail),
                onPressed: () async {
                  final subject = "We The Heroes: ${_case.title}";
                  final url = 'mailto:${_owner.email}?subject=$subject';
                  if (await canLaunch(url)) await launch(url);
                },
              ),
            ],
          );
        }
        break;
      case CaseStatus.COMPLETED:
        return Center(
          child: Container(
            height: 2 * h,
            width: 8 * w,
            child: FittedBox(
              child: Text(
                '${Texts.casecompleted}!',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Theme.of(context).primaryColor,
                  fontWeight: FontWeight.bold,
                  fontSize: h,
                ),
              ),
            ),
          ),
        );
        break;
      default:
        return Container();
    }
    var result = "${Texts.noAction}!";
    if (_case.heroId != null && _case.heroId != widget.profile.id) {
      result += "\n${Texts.someoneelse}!";
    }
    return Center(
      child: Container(
        height: 2 * h,
        width: 8 * w,
        child: FittedBox(
          child: Text(
            result,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Theme.of(context).primaryColor,
              fontWeight: FontWeight.bold,
              fontSize: h,
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (isFirstBuild) onFirstBuild(ModalRoute.of(context).settings.arguments);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          tooltip: Texts.back,
          onPressed: () => Navigator.of(context).pop(),
          icon: Icon(Icons.navigate_before),
        ),
        title: Text(Texts.caseWord),
        centerTitle: true,
      ),
      body: LayoutBuilder(
        builder: (context, c) {
          final h = c.constrainHeight() / 16;
          final w = c.constrainWidth() / 9;
          return caseId == null
              ? Center(child: CircularProgressIndicator())
              : StreamBuilder(
                  stream: widget.database
                      .reference()
                      .child('cases/$caseId')
                      .onValue,
                  initialData:
                      widget.database.reference().child('cases/$caseId').once(),
                  builder: (BuildContext context, AsyncSnapshot<Object> snap) {
                    if (snap.hasData) onValue(snap.data);
                    return _case == null || _owner == null
                        ? Center(child: CircularProgressIndicator())
                        : Container(
                            height: 16 * h,
                            width: 9 * w,
                            child: Stack(
                              children: [
                                //Owner
                                Positioned(
                                  top: 0.25 * h,
                                  left: 0.25 * w,
                                  right: 0.25 * w,
                                  height: h,
                                  child: FittedBox(
                                    child: Text(
                                      '${_owner.name} ${Texts.needshelp} ${_case.hp} ${Texts.hp}!',
                                      style: TextStyle(
                                        color: Theme.of(context).primaryColor,
                                      ),
                                    ),
                                  ),
                                ),
                                //Title
                                Positioned(
                                  top: 1.5 * h,
                                  left: 0.25 * w,
                                  right: 0.25 * w,
                                  height: h,
                                  child: FittedBox(
                                    alignment: Alignment.center,
                                    child: Text(
                                      _case.title,
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                                //Owner
                                Positioned(
                                  top: 2.75 * h,
                                  left: 0.25 * w,
                                  right: 0.25 * w,
                                  height: 10 * h,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: Theme.of(context).primaryColor,
                                        width: 2,
                                      ),
                                      borderRadius:
                                          BorderRadius.circular(h / 2),
                                    ),
                                    child: ClipRRect(
                                      borderRadius:
                                          BorderRadius.circular(h / 2),
                                      child: Scrollbar(
                                        child: SingleChildScrollView(
                                          padding: EdgeInsets.all(h / 2),
                                          child: Text(
                                            _case.description,
                                            textAlign: TextAlign.justify,
                                            maxLines: null,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                //Owner
                                Positioned(
                                  top: 13 * h,
                                  left: 0.25 * w,
                                  right: 0.25 * w,
                                  height: 2.75 * h,
                                  child: Builder(
                                      builder: (c) => SingleChildScrollView(
                                            physics:
                                                NeverScrollableScrollPhysics(),
                                            child: getAction(c, h, w),
                                          )),
                                ),
                              ],
                            ),
                          );
                  },
                );
        },
      ),
    );
  }
}
