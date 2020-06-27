import 'package:flutter/widgets.dart';
import 'package:flutter/services.dart';

import 'package:shared_preferences/shared_preferences.dart';

import './src/app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  SharedPreferences prefs = await SharedPreferences.getInstance();

  int language = prefs.getInt('language') ?? 0;
  String userId = prefs.getString('userId') ?? null;

  runApp(WeTheHeroesApp(userId, language));
}
