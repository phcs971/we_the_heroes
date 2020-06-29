import 'package:flutter/material.dart';

import '../templates/profile.dart';
import '../utils/texts.dart';
import '../routes.dart';

class MenuDrawer extends StatelessWidget {
  final Function() logout;
  final Profile profile;
  const MenuDrawer(this.logout, this.profile, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height / 16;
    final width = MediaQuery.of(context).size.width * 0.75;

    final pages = [
      {'title': Texts.home, 'route': Routes.homeRoute},
      {'title': Texts.myCases, 'route': Routes.myCasesRoute},
      {'title': Texts.acts, 'route': Routes.currentCasesRoute},
      {'title': Texts.caseHistoy, 'route': Routes.caseHistoryRoute},
      {'title': Texts.options, 'route': Routes.optionsRoute},
    ];

    return Container(
      width: width,
      height: 16 * h,
      child: Drawer(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              padding: EdgeInsets.only(
                top: MediaQuery.of(context).padding.top + 0.5 * h,
                bottom: 0.5 * h,
              ),
              height: 4.5 * h,
              width: width,
              color: Theme.of(context).primaryColor,
              child: Image.asset('assets/images/logo_white.png'),
            ),
            SizedBox(height: 0.25 * h),
            Text(
              profile.name,
              style: TextStyle(
                color: Theme.of(context).primaryColor,
                fontSize: h / 2,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              '${profile.hp} hp',
              style: TextStyle(
                color: Theme.of(context).primaryColor,
                fontSize: h / 2,
              ),
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: pages
                    .map((p) => Tooltip(
                          message: p['title'],
                          child: ListTile(
                            onTap: () => Navigator.of(context)
                                .pushReplacementNamed(p['route']),
                            title: Text(
                              p['title'].toUpperCase(),
                              style: TextStyle(
                                color: Theme.of(context).primaryColor,
                                fontSize: h / 2,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            trailing: Icon(
                              Icons.navigate_next,
                              size: h * 0.75,
                              color: Theme.of(context).primaryColor,
                            ),
                          ),
                        ))
                    .toList(),
              ),
            ),
            Container(
              height: h,
              child: FlatButton(
                onPressed: () => showDialog(
                  context: context,
                  child: AlertDialog(
                    title: Text(
                      Texts.surelogout,
                      style: TextStyle(color: Theme.of(context).primaryColor),
                    ),
                    actions: [
                      FlatButton(
                        child: Text(
                          Texts.no,
                          style: TextStyle(
                            color: Theme.of(context).accentColor,
                          ),
                        ),
                        onPressed: () => Navigator.of(context).pop(),
                      ),
                      FlatButton(
                        child: Text(
                          Texts.yes,
                          style: TextStyle(
                            color: Theme.of(context).accentColor,
                          ),
                        ),
                        onPressed: () {
                          Navigator.of(context)
                            ..pop()
                            ..pop()
                            ..pushReplacementNamed(Routes.homeRoute);
                          logout();
                        },
                      ),
                    ],
                  ),
                ),
                child: Text(
                  Texts.logout,
                  style: TextStyle(color: Theme.of(context).primaryColor),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
