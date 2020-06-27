import 'package:firebase_core/firebase_core.dart';

const fbOptions = FirebaseOptions(
  databaseURL: 'https://we-the-heroes.firebaseio.com/',
  apiKey: 'AIzaSyCs6hADcCFORAgc4E-KdF0l3Wo992ZHWKA',
  googleAppID: '1:48602672133:android:6b3fdb865dcd3e716a806c',
);

final RegExp emailValidator = RegExp(
    r"^([a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]{2,})@([a-zA-Z0-9]{2,})\.([a-zA-Z]{2,})");
