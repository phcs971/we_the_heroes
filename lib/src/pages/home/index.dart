import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  final Function logout;
  const Home(this.logout, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, c) {
      final h = c.constrainHeight() / 16;
      final w = c.constrainWidth() / 9;
      return Scaffold(
        backgroundColor: Colors.blue,
        body: Container(
          height: h,
          width: 3 * w,
          alignment: Alignment.center,
          child: RaisedButton(
            child: Text("logout"),
            onPressed: logout,
          ),
        ),
      );
    });
  }
}
