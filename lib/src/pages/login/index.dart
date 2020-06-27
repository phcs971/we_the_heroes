import 'package:flutter/material.dart';

import '../../utils/texts.dart';

class Login extends StatelessWidget {
  final Function(String, String) login_handler;

  Login(this.login_handler);

  final email = TextEditingController(), password = TextEditingController();
  final passNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, c) {
        final h = c.constrainHeight() / 16;
        final w = c.constrainWidth() / 9;
        return Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: Theme.of(context).primaryColor,
          body: Container(
            height: 16 * h,
            width: 9 * w,
            child: Stack(
              children: [
                //Logo
                Positioned(
                  top: h,
                  height: 2.5 * h,
                  left: 0 * w,
                  right: 0 * w,
                  child: Image.asset(
                    'assets/images/logo_white.png',
                    alignment: Alignment.center,
                    fit: BoxFit.contain,
                  ),
                ),
                //Email
                Positioned(
                  top: 4 * h,
                  height: 1.25 * h,
                  left: w,
                  right: w,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(0.25 * h),
                    child: Container(
                      color: Colors.white,
                      alignment: Alignment.center,
                      child: TextField(
                        controller: email,
                        textAlignVertical: TextAlignVertical.center,
                        cursorColor: Theme.of(context).primaryColor,
                        textAlign: TextAlign.center,
                        textInputAction: TextInputAction.next,
                        onSubmitted: (_) =>
                            FocusScope.of(context).requestFocus(passNode),
                        style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontSize: h * 0.5,
                        ),
                        decoration: InputDecoration(
                          hintText: Texts.email,
                          border: InputBorder.none,
                          prefixIcon: Icon(Icons.email, size: h * 0.75),
                          suffixIcon: Container(width: h * 0.75),
                        ),
                      ),
                    ),
                  ),
                ),
                //Password
                Positioned(
                  top: 5.75 * h,
                  height: 1.25 * h,
                  left: w,
                  right: w,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(0.25 * h),
                    child: Container(
                      color: Colors.white,
                      alignment: Alignment.center,
                      child: TextField(
                        focusNode: passNode,
                        textAlignVertical: TextAlignVertical.center,
                        controller: password,
                        obscureText: true,
                        cursorColor: Theme.of(context).primaryColor,
                        onSubmitted: (_) {
                          FocusScope.of(context).unfocus();
                          login_handler(email.text, password.text);
                        },
                        textAlign: TextAlign.center,
                        textInputAction: TextInputAction.go,
                        style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontSize: h * 0.5,
                        ),
                        decoration: InputDecoration(
                          hintText: Texts.password,
                          border: InputBorder.none,
                          prefixIcon: Icon(Icons.lock, size: h * 0.75),
                          suffixIcon: Container(width: h * 0.75),
                        ),
                      ),
                    ),
                  ),
                ),
                //Login Button
                Positioned(
                  top: 7.75 * h,
                  height: h,
                  left: 3 * w,
                  right: 3 * w,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(h / 2),
                    child: RaisedButton(
                      onPressed: () => login_handler(email.text, password.text),
                      child: Padding(
                        padding: EdgeInsets.all(h / 16),
                        child: FittedBox(
                          child: Text(
                            Texts.logar,
                            style: TextStyle(color: Colors.white, fontSize: h),
                          ),
                        ),
                      ),
                      color: Theme.of(context).accentColor,
                    ),
                  ),
                ),
                //Bottom Background
                Positioned(
                  top: 9.75 * h,
                  left: 0,
                  right: 0,
                  bottom: 0,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(color: Colors.black, blurRadius: h / 16),
                      ],
                    ),
                  ),
                ),
                //or
                Positioned(
                  top: 9.25 * h,
                  left: 4.5 * w - 0.5 * h,
                  right: 4.5 * w - 0.5 * h,
                  height: h,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(h / 2),
                      boxShadow: [
                        BoxShadow(color: Colors.black, blurRadius: h / 8),
                      ],
                    ),
                    alignment: Alignment.center,
                    child: FittedBox(
                      child: Text(
                        Texts.or,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
                //Sign in with
                Positioned(
                  top: 10.75 * h,
                  left: 2.5 * w,
                  right: 2.5 * w,
                  height: h * 0.5,
                  child: FittedBox(
                    child: Text(
                      Texts.signinwith,
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Theme.of(context).primaryColor),
                    ),
                  ),
                ),
                //Login Methods
                Positioned(
                  top: 11.75 * h,
                  left: w,
                  right: w,
                  height: 1.5 * h,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(0.75 * h),
                        child: InkWell(
                          onTap: () {},
                          child: Container(
                            height: 1.5 * h,
                            width: 1.5 * h,
                            child: Image.asset('assets/images/google.png'),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                //Change Password
                Positioned(
                  top: 13.5 * h,
                  left: w,
                  right: w,
                  height: h,
                  child: FlatButton(
                    padding: EdgeInsets.all(h / 8),
                    onPressed: () {},
                    child: FittedBox(
                      child: Text(
                        Texts.changepass,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontSize: h / 2.5,
                        ),
                      ),
                    ),
                  ),
                ),
                //Create Account
                Positioned(
                  top: 14.75 * h,
                  left: w,
                  right: w,
                  height: h,
                  child: FlatButton(
                    padding: EdgeInsets.all(h / 8),
                    onPressed: () {},
                    child: FittedBox(
                      child: Text(
                        Texts.createaccount,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontSize: h / 2.5,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
