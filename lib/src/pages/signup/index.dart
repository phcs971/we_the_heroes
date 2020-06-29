import 'package:flutter/material.dart';

import '../../utils/texts.dart';
import '../../utils/constants.dart';

class SignUp extends StatefulWidget {
  final Function(String, String, String, BuildContext) signup;
  final Function(BuildContext) googleSignup;
  SignUp(this.signup, this.googleSignup, {Key key}) : super(key: key);

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  int task = 0;
  int totalTasks = 4;

  final PageController pageController = PageController();

  final emailCtrl = TextEditingController();
  final passCtrl = TextEditingController();
  final passConfCtrl = TextEditingController();
  final nameCtrl = TextEditingController();

  void removeKeyboard(BuildContext context) {
    FocusScopeNode currentFocus = FocusScope.of(context);
    if (!currentFocus.hasPrimaryFocus) currentFocus.unfocus();
  }

  void _nextPage() {
    removeKeyboard(context);
    setState(() => task++);
    pageController.animateToPage(task,
        duration: animationDuration, curve: Curves.easeInOut);
  }

  void _prevPage() {
    removeKeyboard(context);
    setState(() => task--);
    pageController.animateToPage(task,
        duration: animationDuration, curve: Curves.easeInOut);
  }

  bool validate() {
    switch (task) {
      case 0:
        return emailValidator.hasMatch(emailCtrl.text);
        break;
      case 1:
        return nameCtrl.text.length > 2;
        break;
      case 2:
        return passValidator.hasMatch(passCtrl.text);
        break;
      case 3:
        return passCtrl.text == passConfCtrl.text;
        break;
      case 4:
        return true;
        break;
      default:
        return false;
    }
  }

  @override
  void initState() {
    super.initState();
    emailCtrl.addListener(() => setState(() {}));
    passCtrl.addListener(() => setState(() {}));
    passConfCtrl.addListener(() => setState(() {}));
    nameCtrl.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    super.dispose();
    emailCtrl.dispose();
    passCtrl.dispose();
    passConfCtrl.dispose();
    nameCtrl.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, c) {
        final h = c.constrainHeight() / 16;
        final w = c.constrainWidth() / 9;

        bool isValid = validate();

        return Scaffold(
          body: Container(
            height: 16 * h,
            width: 9 * w,
            child: Stack(
              children: <Widget>[
                //TopPadding
                Container(
                  height: MediaQuery.of(context).padding.top,
                  width: 9 * w,
                  color: Theme.of(context).primaryColor,
                ),
                //Progress Bar
                AnimatedPositioned(
                  top: MediaQuery.of(context).padding.top,
                  height: 6,
                  left: 0,
                  width: 0.5 * w + 8.5 * w * (task / totalTasks),
                  duration: Duration(milliseconds: 300),
                  child: AnimatedContainer(
                    duration: Duration(milliseconds: 300),
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      borderRadius: BorderRadius.only(
                        bottomRight:
                            Radius.circular(task == totalTasks ? 0 : 6),
                      ),
                    ),
                  ),
                ),
                //GetBack
                Positioned(
                  top: 0.75 * h,
                  height: h,
                  left: 0.25 * w,
                  width: h,
                  child: IconButton(
                    icon: Icon(
                      Icons.navigate_before,
                      color: Theme.of(context).primaryColor,
                      size: h,
                    ),
                    onPressed: () {
                      if (task == 0)
                        Navigator.of(context).pop();
                      else
                        _prevPage();
                    },
                  ),
                ),
                //Already...
                Positioned(
                  top: h,
                  height: h / 2,
                  right: 0.25 * w,
                  width: 5 * w,
                  child: Container(
                    alignment: Alignment.topRight,
                    child: FlatButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text(
                        Texts.haveAccount,
                        textAlign: TextAlign.end,
                        style: TextStyle(
                          decoration: TextDecoration.underline,
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                    ),
                  ),
                ),
                //Google+
                Positioned(
                  bottom: 4,
                  height: 56,
                  width: 56,
                  left: 112,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(28),
                    child: InkWell(
                      onTap: () => widget.googleSignup(context).then(
                            (v) => Navigator.of(context).pop(),
                          ),
                      child: Container(
                        height: 56,
                        width: 56,
                        child: Image.asset('assets/images/google.png'),
                      ),
                    ),
                  ),
                ),
                //Sign with
                Positioned(
                  bottom: 4,
                  height: 56,
                  width: 100,
                  left: 12,
                  child: Container(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      Texts.signinwith,
                      textAlign: TextAlign.start,
                      style: TextStyle(color: Theme.of(context).primaryColor),
                    ),
                  ),
                ),
                //Tasks
                Positioned(
                  top: 2.5 * h,
                  bottom: 60,
                  left: w,
                  width: 7 * w,
                  child: PageView(
                    physics: NeverScrollableScrollPhysics(),
                    children: [
                      //Email
                      _TaskBuilder(
                        h: h,
                        controller: emailCtrl,
                        label: Texts.email,
                        title: Texts.signUpPart1,
                        keyType: TextInputType.emailAddress,
                      ),
                      //Name
                      _TaskBuilder(
                        h: h,
                        controller: nameCtrl,
                        label: Texts.name,
                        title: Texts.signUpPart2,
                      ),
                      //Password
                      _TaskBuilder(
                        h: h,
                        controller: passCtrl,
                        label: Texts.password,
                        title: Texts.signUpPart3,
                        helper: Texts.passHelper,
                        keyType: TextInputType.visiblePassword,
                        isPass: true,
                      ),
                      //Cofirm Password
                      _TaskBuilder(
                        h: h,
                        controller: passConfCtrl,
                        label: Texts.confirmPassword,
                        title: Texts.signUpPart4,
                        keyType: TextInputType.visiblePassword,
                        isPass: true,
                      ),
                      //Finish
                      Container(
                        width: 7 * w,
                        height: 4 * h,
                        child: FittedBox(
                          alignment: Alignment.topLeft,
                          child: Text(
                            Texts.signUpPart5,
                            style: TextStyle(
                              color: Theme.of(context).primaryColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                    controller: pageController,
                  ),
                )
              ],
            ),
          ),
          floatingActionButton: FloatingActionButton(
            backgroundColor:
                isValid ? Theme.of(context).primaryColor : Colors.grey,
            onPressed: isValid
                ? () {
                    if (task == totalTasks)
                      widget
                          .signup(nameCtrl.text, emailCtrl.text, passCtrl.text,
                              context)
                          .then((_) => Navigator.of(context).pop());
                    else
                      _nextPage();
                  }
                : null,
            // : null,
            child: Icon(
              task == totalTasks ? Icons.add : Icons.navigate_next,
              color: Colors.white,
              size: h,
            ),
          ),
        );
      },
    );
  }
}

class _TaskBuilder extends StatefulWidget {
  final double h;
  final bool isPass;
  final String title;
  final String label;
  final String helper;
  final TextInputType keyType;
  final TextEditingController controller;

  _TaskBuilder({
    this.h,
    this.title,
    this.label,
    this.helper,
    this.controller,
    this.isPass = false,
    this.keyType = TextInputType.text,
  });

  @override
  __TaskBuilderState createState() => __TaskBuilderState();
}

class __TaskBuilderState extends State<_TaskBuilder> {
  bool showPass = false;

  FocusNode focusNode = FocusNode();

  bool firstBuild = true;
  bool secondBuild = false;

  onFirstBuild() => setState(() {
        firstBuild = false;
        secondBuild = true;
      });

  onSecondBuild() async {
    setState(() {
      secondBuild = false;
    });
    Future.delayed(Duration(milliseconds: 100))
        .then((_) => FocusScope.of(context).requestFocus(focusNode));
  }

  @override
  Widget build(BuildContext context) {
    if (firstBuild) onFirstBuild();

    if (secondBuild) onSecondBuild();

    return LayoutBuilder(
      builder: (context, c) {
        final h = widget.h;
        final w = c.constrainWidth() / 8;
        return Column(
          children: <Widget>[
            //TITLE
            Container(
              width: 8 * w,
              height: 2 * h,
              child: FittedBox(
                alignment: Alignment.topLeft,
                child: Text(
                  widget.title,
                  style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            //TextField
            Container(
              width: 8 * w,
              height: c.constrainHeight() - 2 * h,
              child: TextField(
                focusNode: focusNode,
                enabled: true,
                keyboardType: widget.keyType,
                autocorrect: !widget.isPass,
                autofocus: true,
                obscureText: !showPass && widget.isPass,
                controller: widget.controller,
                cursorColor: Theme.of(context).primaryColor,
                style: TextStyle(color: Theme.of(context).primaryColor),
                decoration: InputDecoration(
                  helperText: widget.helper,
                  labelText: widget.label,
                  suffix: widget.isPass
                      ? IconButton(
                          padding: EdgeInsets.zero,
                          onPressed: () => setState(() => showPass = !showPass),
                          icon: Icon(
                            showPass ? Icons.visibility_off : Icons.visibility,
                            color: Theme.of(context).primaryColor,
                          ),
                        )
                      : Container(
                          width: 0.1,
                          height: 0.1,
                        ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
