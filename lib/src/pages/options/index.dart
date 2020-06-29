import 'package:flutter/material.dart';

import 'package:firebase_database/firebase_database.dart';
import 'package:we_the_heroes/src/routes.dart';

import '../../services/auth.dart';
import '../../utils/texts.dart';
import '../../components/menu.dart';
import '../../templates/profile.dart';

class Options extends StatefulWidget {
  final Function() logout;
  final FirebaseDatabase database;
  final Profile profile;
  final Function(Profile) updateProfile;
  final Function(int) updateLang;

  Options(this.logout, this.database, this.profile, this.updateProfile,
      this.updateLang);

  @override
  _OptionsState createState() => _OptionsState();
}

class _OptionsState extends State<Options> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  TextEditingController name = TextEditingController();

  onSave() {
    widget.database
        .reference()
        .child('users/${widget.profile.id}')
        .update({'name': name.text});
    var p = widget.profile;
    p.name = name.text;
    widget.updateProfile(p);
  }

  deleteCases() async {
    Map cases = (await widget.database
            .reference()
            .child('cases')
            .orderByChild('ownerId')
            .equalTo(widget.profile.id)
            .once())
        .value;
    if (cases != null) {
      for (var k in cases.keys.toList()) {
        await widget.database.reference().child('cases/$k').remove();
      }
    }
  }

  resetAccount() async {
    await deleteCases();
    await widget.database
        .reference()
        .child('users/${widget.profile.id}')
        .update({'hp': 0});
    var p = widget.profile;
    p.hp = 0;
    widget.updateProfile(p);
  }

  deleteAccount() async {
    await deleteCases();
    await resetAccount();
    await Auth().removeAccount();
    widget.logout();
    Navigator.of(context).pushReplacementNamed(Routes.homeRoute);
  }

  @override
  void initState() {
    super.initState();
    name.text = widget.profile.name;
    name.addListener(() => setState(() {}));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      key: scaffoldKey,
      drawer: MenuDrawer(widget.logout, widget.profile),
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.menu),
          onPressed: () => scaffoldKey.currentState.openDrawer(),
          tooltip: Texts.openMenu,
        ),
        title: Text(Texts.options),
        centerTitle: true,
      ),
      body: LayoutBuilder(
        builder: (context, c) {
          final h = c.constrainHeight() / 16;
          final w = c.constrainWidth() / 9;
          return Container(
            height: 16 * h,
            width: 9 * w,
            child: Stack(
              children: [
                //Danger Zone
                Positioned(
                  bottom: 0,
                  height: 8 * h,
                  left: 0.5 * w,
                  right: 0.5 * w,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(h),
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          Texts.dangerZOne,
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: h * 0.75,
                          ),
                        ),
                        Container(
                          height: 1.5 * h,
                          width: 5 * w,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(h / 2),
                            child: RaisedButton(
                              onPressed: () => showDialog(
                                context: context,
                                child: AlertDialog(
                                  title: Text(
                                    Texts.cannotUndo,
                                    style: TextStyle(
                                      color: Theme.of(context).primaryColor,
                                    ),
                                  ),
                                  actions: [
                                    FlatButton(
                                      onPressed: () =>
                                          Navigator.of(context).pop(),
                                      child: Text(
                                        Texts.no,
                                        style: TextStyle(
                                          color: Theme.of(context).accentColor,
                                        ),
                                      ),
                                    ),
                                    FlatButton(
                                      onPressed: () =>
                                          Navigator.of(context).pop(true),
                                      child: Text(
                                        Texts.yes,
                                        style: TextStyle(
                                          color: Theme.of(context).accentColor,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ).then((value) {
                                if (value != null && value) {
                                  deleteCases();
                                }
                              }),
                              child: FittedBox(
                                child: Text(
                                  Texts.deleteCases,
                                  style: TextStyle(
                                    color: Theme.of(context).primaryColor,
                                    fontSize: h / 2,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Container(
                          height: 1.5 * h,
                          width: 5 * w,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(h / 2),
                            child: RaisedButton(
                              onPressed: () => showDialog(
                                context: context,
                                child: AlertDialog(
                                  title: Text(
                                    Texts.cannotUndo,
                                    style: TextStyle(
                                      color: Theme.of(context).primaryColor,
                                    ),
                                  ),
                                  actions: [
                                    FlatButton(
                                      onPressed: () =>
                                          Navigator.of(context).pop(),
                                      child: Text(
                                        Texts.no,
                                        style: TextStyle(
                                          color: Theme.of(context).accentColor,
                                        ),
                                      ),
                                    ),
                                    FlatButton(
                                      onPressed: () =>
                                          Navigator.of(context).pop(true),
                                      child: Text(
                                        Texts.yes,
                                        style: TextStyle(
                                          color: Theme.of(context).accentColor,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ).then((value) {
                                if (value != null && value) {
                                  resetAccount();
                                }
                              }),
                              child: FittedBox(
                                child: Text(
                                  Texts.resetAccount,
                                  style: TextStyle(
                                    color: Theme.of(context).primaryColor,
                                    fontSize: h / 2,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Container(
                          height: 1.5 * h,
                          width: 5 * w,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(h / 2),
                            child: RaisedButton(
                              onPressed: () => showDialog(
                                context: context,
                                child: AlertDialog(
                                  title: Text(
                                    Texts.cannotUndo,
                                    style: TextStyle(
                                      color: Theme.of(context).primaryColor,
                                    ),
                                  ),
                                  actions: [
                                    FlatButton(
                                      onPressed: () =>
                                          Navigator.of(context).pop(),
                                      child: Text(
                                        Texts.no,
                                        style: TextStyle(
                                          color: Theme.of(context).accentColor,
                                        ),
                                      ),
                                    ),
                                    FlatButton(
                                      onPressed: () =>
                                          Navigator.of(context).pop(true),
                                      child: Text(
                                        Texts.yes,
                                        style: TextStyle(
                                          color: Theme.of(context).accentColor,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ).then((value) {
                                if (value != null && value) {
                                  deleteAccount();
                                }
                              }),
                              child: FittedBox(
                                child: Text(
                                  Texts.deleteAccount,
                                  style: TextStyle(
                                    color: Theme.of(context).primaryColor,
                                    fontSize: h / 2,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                //Save button
                Positioned(
                  top: 0.5 * h,
                  height: h,
                  width: w,
                  right: 0.5 * w,
                  child: IconButton(
                    color: Theme.of(context).primaryColor,
                    icon: Icon(Icons.save),
                    onPressed: name.text.length >= 3 &&
                            name.text.length <= 25 &&
                            name.text != widget.profile.name
                        ? onSave
                        : null,
                    tooltip: Texts.saveonly,
                  ),
                ),
                //Name
                Positioned(
                  top: 0.5 * h,
                  left: 2 * w,
                  right: 2 * w,
                  height: h,
                  child: FittedBox(child: Text(Texts.changename)),
                ),
                //Name Field
                Positioned(
                  top: 1.75 * h,
                  height: 1.25 * h,
                  left: 0.5 * w,
                  right: 0.5 * w,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: h / 4),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Theme.of(context).primaryColor,
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(h / 2),
                    ),
                    child: TextField(
                      controller: name,
                      textAlignVertical: TextAlignVertical.center,
                      cursorColor: Theme.of(context).primaryColor,
                      textAlign: TextAlign.center,
                      textInputAction: TextInputAction.next,
                      onSubmitted: (_) => onSave(),
                      style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontSize: h * 0.5,
                      ),
                      decoration: InputDecoration(
                        hintText: Texts.title,
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ),
                //Language
                Positioned(
                  top: 3.5 * h,
                  left: 1.5 * w,
                  right: 1.5 * w,
                  height: h,
                  child: FittedBox(child: Text("${Texts.applang}:")),
                ),
                //Language Drop
                Positioned(
                  top: 4.75 * h,
                  height: 1.25 * h,
                  left: 0.5 * w,
                  right: 0.5 * w,
                  child: DropdownButton<int>(
                    value: Texts.getLang(),
                    isExpanded: true,
                    items: [
                      DropdownMenuItem(
                        value: 0,
                        child: Center(
                          child: Text('English'),
                        ),
                      ),
                      DropdownMenuItem(
                        value: 1,
                        child: Center(
                          child: Text('Português'),
                        ),
                      ),
                    ],
                    hint: Center(child: Text(Texts.applang)),
                    onChanged: widget.updateLang,
                  ),
                ),
                //Reset Pass
                Positioned(
                  top: 6.5 * h,
                  height: 1 * h,
                  left: 0.5 * w,
                  right: 0.5 * w,
                  child: FlatButton(
                    onPressed: () {
                      final color = Theme.of(context).accentColor;
                      Auth()
                          .redefinePassword(widget.profile.email)
                          .then((_) => scaffoldKey.currentState.showSnackBar(
                                SnackBar(
                                  content: Text(
                                    Texts.emailsent,
                                    style: TextStyle(color: color),
                                  ),
                                ),
                              ))
                          .catchError(
                              (_) => scaffoldKey.currentState.showSnackBar(
                                    SnackBar(
                                      content: Text(
                                        Texts.userNotFound,
                                        style: TextStyle(color: color),
                                      ),
                                    ),
                                  ));
                    },
                    child: FittedBox(
                      child: Text(
                        Texts.changepass,
                        style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontSize: h / 2,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
