export './pages/home/index.dart';
export './pages/login/index.dart';
export './pages/signup/index.dart';
export './pages/newCase/index.dart';
export './pages/case/index.dart';
export './pages/myCases/index.dart';
export './pages/currentCases/index.dart';
export './pages/caseHistory/index.dart';
export './pages/options/index.dart';

class Routes {
  Routes._();

  static const String homeRoute = '/';
  static const String signupRoute = '/login/new';
  static const String caseRoute = '/case';
  static const String myCasesRoute = '/case/self';
  static const String currentCasesRoute = '/case/current';
  static const String caseHistoryRoute = '/case/history';
  static const String newCaseRoute = '/case/new';
  static const String optionsRoute = '/options';
}
