import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../utils/texts.dart';
import '../../templates/case.dart';

class NewCase extends StatefulWidget {
  final String userId;
  const NewCase(this.userId, {Key key}) : super(key: key);

  @override
  _NewCaseState createState() => _NewCaseState();
}

class _NewCaseState extends State<NewCase> {
  bool isFirstBuild = true;
  bool isEditing = false;

  final title = TextEditingController(),
      hp = TextEditingController(),
      description = TextEditingController();

  final hpNode = FocusNode(), descNode = FocusNode();

  bool get isValid =>
      title.text.isNotEmpty &&
      hp.text.isNotEmpty &&
      description.text.isNotEmpty;
  Case prevCase;
  onFirstBuild(Case c) {
    setState(() {
      if (c != null) {
        prevCase = c;
        title.text = c.title;
        hp.text = c.hp.toString();
        description.text = c.description;
        isEditing = true;
      }
      isFirstBuild = false;
    });
  }

  @override
  void initState() {
    super.initState();
    title.addListener(() => setState(() {}));
    hp.addListener(() => setState(() {}));
    description.addListener(() => setState(() {}));
  }

  @override
  Widget build(BuildContext context) {
    if (isFirstBuild) onFirstBuild(ModalRoute.of(context).settings.arguments);
    return LayoutBuilder(
      builder: (context, c) {
        final h = c.constrainHeight() / 16;
        final w = c.constrainWidth() / 9;
        return Scaffold(
          appBar: AppBar(
            leading: IconButton(
              tooltip: Texts.back,
              onPressed: () => Navigator.of(context).pop(),
              icon: Icon(Icons.navigate_before),
            ),
            centerTitle: true,
            title: Text(isEditing ? Texts.editCase : Texts.createCase),
            actions: [
              IconButton(
                icon: Icon(Icons.save),
                onPressed: isValid
                    ? () => Navigator.of(context).pop(isEditing
                        ? Case(
                            description: description.text,
                            hp: int.parse(hp.text),
                            title: title.text,
                            heroId: prevCase.heroId,
                            id: prevCase.id,
                            locale: prevCase.locale,
                            ownerId: prevCase.ownerId,
                            status: prevCase.status,
                          )
                        : Case(
                            description: description.text,
                            hp: int.parse(hp.text),
                            title: title.text,
                            locale: Platform.localeName,
                            ownerId: widget.userId,
                            status: CaseStatus.TO_DO,
                          ))
                    : null,
                tooltip: Texts.save,
              ),
            ],
          ),
          body: Container(
            height: 16 * h,
            width: 9 * w,
            child: Stack(
              children: [
                //Title
                Positioned(
                  top: 0.25 * h,
                  left: 0.25 * w,
                  right: 3 * w,
                  height: 1.25 * h,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: h / 4),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Theme.of(context).primaryColor,
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(h / 2),
                    ),
                    child: TextField(
                      controller: title,
                      textAlignVertical: TextAlignVertical.center,
                      cursorColor: Theme.of(context).primaryColor,
                      textAlign: TextAlign.start,
                      textInputAction: TextInputAction.next,
                      onSubmitted: (_) =>
                          FocusScope.of(context).requestFocus(hpNode),
                      style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontSize: h * 0.5,
                      ),
                      decoration: InputDecoration(
                        hintText: Texts.title,
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ),
                //hp
                Positioned(
                  top: 0.25 * h,
                  width: 2.5 * w,
                  right: 0.25 * w,
                  height: 1.25 * h,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: h / 4),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Theme.of(context).primaryColor,
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(h / 2),
                    ),
                    child: TextField(
                      focusNode: hpNode,
                      controller: hp,
                      inputFormatters: [
                        WhitelistingTextInputFormatter(RegExp("[0-9]")),
                      ],
                      textAlignVertical: TextAlignVertical.center,
                      keyboardType: TextInputType.number,
                      cursorColor: Theme.of(context).primaryColor,
                      textAlign: TextAlign.center,
                      textInputAction: TextInputAction.next,
                      onSubmitted: (_) =>
                          FocusScope.of(context).requestFocus(descNode),
                      style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontSize: h * 0.5,
                      ),
                      decoration: InputDecoration(
                        hintText: Texts.hp,
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ),
                //Descirption
                Positioned(
                  top: 1.75 * h,
                  left: 0.25 * w,
                  right: 0.25 * w,
                  bottom: 0.25 * h,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: h / 4),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Theme.of(context).primaryColor,
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(h / 2),
                    ),
                    child: TextFormField(
                      controller: description,
                      focusNode: descNode,
                      keyboardType: TextInputType.multiline,
                      maxLines: null,
                      cursorColor: Theme.of(context).primaryColor,
                      textAlign: TextAlign.justify,
                      textInputAction: TextInputAction.newline,
                      style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontSize: h * 0.5,
                      ),
                      decoration: InputDecoration(
                        hintText: Texts.desc,
                        border: InputBorder.none,
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
