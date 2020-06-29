import 'package:flutter/material.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';

import 'package:shared_preferences/shared_preferences.dart';

import './routes.dart';
import './services/auth.dart';
import './utils/texts.dart';
import './utils/constants.dart';
import './templates/profile.dart';

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

  DatabaseReference usersRef;

  Profile profile;

  final Auth authHandler = new Auth();

  Future<void> init() async {
    app = await FirebaseApp.configure(
      name: 'we-the-heroes',
      options: fbOptions,
    );
    database = FirebaseDatabase(app: app);
    usersRef = database.reference().child('users');
  }

  Future<void> login(uid) async {
    setState(() {
      userId = uid;
    });
    var snap = await usersRef.child(uid).once();
    while (snap.value == null) {
      snap = await usersRef.child(uid).once();
    }
    updateProfile(Profile.fromMap(snap.value, uid));
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('userId', uid);
  }

  Future<void> createAccount(Profile profile) async =>
      await usersRef.update(profile.toMap());

  Future<void> loginEmail(email, password, context) async {
    final result =
        await authHandler.loginEmail(email, password).catchError((e) {
      onError(e, context);
      return null;
    });
    if (result != null) {
      var snap = await usersRef.child(result.uid).once();
      if (snap.value == null) {
        createAccount(Profile(hp: 0, name: result.displayName, id: result.uid));
      }
      login(result.uid);
    }
  }

  Future<void> loginGoogle(context) async {
    final result = await authHandler.loginGoogle().catchError((e) {
      onError(e, context);
      return null;
    });
    if (result != null) {
      var snap = await usersRef.child(result.uid).once();
      if (snap.value == null) {
        createAccount(Profile(
          hp: 0,
          name: result.displayName,
          id: result.uid,
          email: result.email,
        ));
      }
      login(result.uid);
    }
  }

  Future<bool> signUp(nome, email, password, context) async {
    final result =
        await authHandler.signUpEmail(email, password).catchError((e) {
      onError(e, context);
      return null;
    });
    if (result != null) {
      await createAccount(Profile(
        id: result.uid,
        hp: 0,
        email: email,
        name: nome,
      ));
      await login(result.uid);
      return true;
    } else {
      return false;
    }
  }

  Future<void> logout() async {
    authHandler.logout();
    setState(() => userId = null);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('userId', null);
  }

  void onError(error, context) {
    String message;
    try {
      if (error.message != null) {
        message = error.message;
      } else {
        throw 'No Message';
      }
    } catch (_) {
      try {
        if (error.details != null) {
          message = error.details;
        } else {
          throw 'No Details';
        }
      } catch (_) {
        try {
          if (error.code != null) {
            message = error.code;
          } else {
            throw 'No code';
          }
        } catch (_) {
          message = error.toString();
        }
      }
    }
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(Texts.error),
        content: Text(message),
        actions: [
          FlatButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text(
              'OK',
              style: TextStyle(
                color: Theme.of(context).accentColor,
              ),
            ),
          )
        ],
      ),
    );
  }

  void updateProfile(Profile p) => setState(() => profile = p);

  void updateLang(l) async {
    if (l != Texts.getLang()) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setInt('language', l);
      setState(() => Texts.changeLang(l));
    }
  }

  @override
  void initState() {
    super.initState();
    init().then((_) {
      if (userId != null) login(userId);
    });
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
        backgroundColor: Colors.white, // #FFF
      ),
      routes: {
        Routes.homeRoute: (ctx) => userId == null
            ? Login(loginEmail, loginGoogle)
            : profile == null
                ? Scaffold(body: Center(child: CircularProgressIndicator()))
                : Home(logout, database, profile),
        Routes.signupRoute: (ctx) => SignUp(signUp, loginGoogle),
        Routes.newCaseRoute: (ctx) => NewCase(profile.id),
        Routes.caseRoute: (ctx) => CasePage(profile, database, updateProfile),
        Routes.myCasesRoute: (ctx) => MyCases(logout, database, profile),
        Routes.currentCasesRoute: (ctx) =>
            CurrentCases(logout, database, profile),
        Routes.caseHistoryRoute: (ctx) =>
            CaseHistory(logout, database, profile),
        Routes.optionsRoute: (ctx) =>
            Options(logout, database, profile, updateProfile, updateLang),
      },
      initialRoute: Routes.homeRoute,
    );
  }
}
