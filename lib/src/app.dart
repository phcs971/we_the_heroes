import 'package:flutter/material.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';

import 'package:shared_preferences/shared_preferences.dart';

import './routes.dart';
import './services/auth.dart';
import './utils/texts.dart';
import './utils/constants.dart';

class WeTheHeroesApp extends StatefulWidget {
  final String userId;
  final int language;

  WeTheHeroesApp(this.userId, this.language);

  @override
  _WeTheHeroesAppState createState() =>
      _WeTheHeroesAppState(this.userId, this.language);
}

class _WeTheHeroesAppState extends State<WeTheHeroesApp> {
  String userId;
  int language;

  _WeTheHeroesAppState(this.userId, this.language);

  FirebaseApp app;
  FirebaseDatabase database;

  final Auth authHandler = new Auth();

  void init() async {
    app = await FirebaseApp.configure(
      name: 'we-the-heroes',
      options: fbOptions,
    );
  }

  void login(uid) async {
    setState(() {
      userId = uid;
    });
    var snap = await database.reference().child('users').child(uid).once();
    while (snap.value == null) {
      snap = await database.reference().child('users').child(uid).once();
    }
    // TODO: updateProfile(Profile.fromMap(snap.value, uid));
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('userId', uid);
  }

  void loginEmail(email, password) {
    authHandler.loginEmail(email, password);
  }

  updateLang(l) async {
    if (l != Texts.getLang()) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setInt('language', l);
      setState(() => Texts.changeLang(l));
    }
  }

  @override
  void initState() {
    super.initState();
    init();
    database = FirebaseDatabase(app: app);
    if (userId != null) login(userId);
    updateLang(language);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'We The Heroes',
      theme: ThemeData(
        primaryColor: Color(0xFFA21302), // #A21302
        accentColor: Color(0xFFC9A700), // #C9A700
      ),
      routes: {
        Routes.homeRoute: (ctx) => userId == null
            ? Login((String email, String password) => print(password))
            : Home(),
        Routes.signupRoute: (ctx) => Container(),
      },
      initialRoute: Routes.homeRoute,
    );
  }
}
