import 'package:flutter/material.dart';

import '../../utils/texts.dart';
import '../../utils/constants.dart';

class SignUp extends StatefulWidget {
  final Function(String, String, String, BuildContext) signup;
  SignUp(this.signup, {Key key}) : super(key: key);

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final name = TextEditingController(),
      email = TextEditingController(),
      senha = TextEditingController();

  final emailNode = FocusNode(), passNode = FocusNode();

  bool get isValid =>
      emailValidator.hasMatch(email.text) &&
      senha.text.length >= 6 &&
      senha.text.length <= 20 &&
      name.text.length >= 3 &&
      name.text.length <= 25;

  bool passInvisible = true;

  void signup(context) async {
    final bool result =
        await widget.signup(name.text, email.text, senha.text, context);
    if (result) {
      Navigator.of(context).pop();
    }
  }

  @override
  void initState() {
    super.initState();
    name.addListener(() => setState(() {}));
    email.addListener(() => setState(() {}));
    senha.addListener(() => setState(() {}));
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, c) {
        final h = c.constrainHeight() / 16;
        final w = c.constrainWidth() / 9;
        return Scaffold(
          floatingActionButton: FloatingActionButton(
            onPressed: isValid ? () => signup(context) : null,
            backgroundColor:
                isValid ? Theme.of(context).primaryColor : Colors.grey,
            child: Icon(
              Icons.add,
              color: Colors.white,
            ),
          ),
          body: Container(
            height: 16 * h,
            width: 9 * w,
            child: Stack(
              children: [
                //Visibility
                Positioned(
                  bottom: 0.25 * w,
                  left: 0.25 * w,
                  height: h,
                  width: h,
                  child: IconButton(
                    icon: Icon(
                      passInvisible ? Icons.visibility : Icons.visibility_off,
                      color: Theme.of(context).primaryColor,
                    ),
                    onPressed: () =>
                        setState(() => passInvisible = !passInvisible),
                  ),
                ),
                //Get Back
                Positioned(
                  top: MediaQuery.of(context).viewPadding.top + 0.25 * w,
                  left: 0.25 * w,
                  height: h,
                  width: h,
                  child: IconButton(
                    icon: Icon(
                      Icons.navigate_before,
                      color: Theme.of(context).primaryColor,
                    ),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                ),
                //Title
                Positioned(
                  top: MediaQuery.of(context).viewPadding.top + 0.25 * w,
                  left: 1.5 * w,
                  height: h,
                  right: 0.25 * w,
                  child: FittedBox(
                    child: Text(
                      Texts.createaccount,
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Theme.of(context).primaryColor),
                    ),
                  ),
                ),
                //Nome
                Positioned(
                  left: 3 * w,
                  right: 0.5 * w,
                  top: 2.5 * h,
                  height: h,
                  child: TextField(
                    controller: name,
                    autofocus: true,
                    textAlignVertical: TextAlignVertical.center,
                    cursorColor: Theme.of(context).primaryColor,
                    textAlign: TextAlign.center,
                    textInputAction: TextInputAction.next,
                    onSubmitted: (_) =>
                        FocusScope.of(context).requestFocus(emailNode),
                    style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontSize: h * 0.5,
                    ),
                    decoration: InputDecoration(
                      hintText: '${Texts.name} (3 - 25)',
                      contentPadding: EdgeInsets.zero,
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                //Email
                Positioned(
                  left: 3 * w,
                  right: 0.5 * w,
                  top: 4 * h,
                  height: h,
                  child: TextField(
                    focusNode: emailNode,
                    controller: email,
                    textAlignVertical: TextAlignVertical.center,
                    keyboardType: TextInputType.emailAddress,
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
                      contentPadding: EdgeInsets.zero,
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                //Senha
                Positioned(
                  left: 3 * w,
                  right: 0.5 * w,
                  top: 5.5 * h,
                  height: h,
                  child: TextField(
                    focusNode: passNode,
                    controller: senha,
                    textAlignVertical: TextAlignVertical.center,
                    cursorColor: Theme.of(context).primaryColor,
                    textAlign: TextAlign.center,
                    textInputAction: TextInputAction.go,
                    obscureText: passInvisible,
                    onSubmitted: (_) => passInvisible ? signup(context) : null,
                    style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontSize: h * 0.5,
                    ),
                    decoration: InputDecoration(
                      hintText: '${Texts.password} (6 - 20)',
                      contentPadding: EdgeInsets.zero,
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                //Nome TEXT
                Positioned(
                  top: 2.5 * h,
                  left: 0.5 * w,
                  width: 2.5 * w,
                  height: h,
                  child: FittedBox(
                    alignment: Alignment.centerLeft,
                    child: Text('${Texts.name}:   '),
                  ),
                ),
                //Email TEXT
                Positioned(
                  top: 4 * h,
                  left: 0.5 * w,
                  width: 2.5 * w,
                  height: h,
                  child: FittedBox(
                    alignment: Alignment.centerLeft,
                    child: Text('${Texts.email}:   '),
                  ),
                ),
                //Senha TEXT
                Positioned(
                  top: 5.5 * h,
                  left: 0.5 * w,
                  width: 2.5 * w,
                  height: h,
                  child: FittedBox(
                    alignment: Alignment.centerLeft,
                    child: Text('${Texts.password}:   '),
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
