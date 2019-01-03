import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AppLayout extends StatelessWidget {
  AppLayout({
    Key key,
    this.child,
  }) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    var _scaffoldKey = new GlobalKey<ScaffoldState>();

    return MaterialApp(
      title: 'CNode',
      theme: ThemeData(
        brightness: Brightness.light,
        primaryColor: Colors.grey[900],
        accentColor: Colors.cyan[600],
      ),
      home: Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          title: Container(
            child: Stack(
              children: <Widget>[
                Positioned(
                  child: SvgPicture.asset(
                    'assets/cnodejs_light.svg',
                    alignment: Alignment.topLeft,
                    width: 130,
                  ),
                  top: 8,
                ),
              ],
            ),
          ),
          automaticallyImplyLeading: false,
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.menu),
              onPressed: () {
                _scaffoldKey.currentState.openDrawer();
              },
            ),
          ],
        ),
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              DrawerHeader(
                child: Text('Drawer Header', style: TextStyle(
                  color: Colors.white,
                )),
                decoration: BoxDecoration(
                  color: Colors.grey[800],
                ),
              ),
              ListTile(
                title: Text('Item 1'),
                onTap: () {
                },
              ),
              ListTile(
                title: Text('Item 2'),
                onTap: () {
                },
              ),
            ],
          ),
        ),
        body: child,
      ),
    );
  }
}
