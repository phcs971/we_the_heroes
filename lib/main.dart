import 'dart:io';
import 'package:flutter/widgets.dart';
import 'package:flutter/services.dart';

import 'package:shared_preferences/shared_preferences.dart';

import './src/app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  int suggestedLanguage;

  switch (Platform.localeName.split('_')[0]) {
    case 'pt':
      suggestedLanguage = 1;
      break;
    case 'en':
      suggestedLanguage = 0;
      break;
    default:
      suggestedLanguage = 0;
  }

  SharedPreferences prefs = await SharedPreferences.getInstance();

  int language = prefs.getInt('language') ?? suggestedLanguage;
  String userId = prefs.getString('userId') ?? null;

  runApp(WeTheHeroesApp(userId, language));
}
