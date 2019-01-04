import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_redux/flutter_redux.dart';

import '../reducer/StoreData.dart';

class AppLayout extends StatelessWidget {
  AppLayout({
    Key key,
    this.child,
  }) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    var _scaffoldKey = new GlobalKey<ScaffoldState>();

    return Scaffold(
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
              child: StoreConnector<StoreData, String>(
                converter: (store) => store.state.title,
                builder: (context, title) {
                  return Text(title, style: TextStyle(
                    color: Colors.white,
                  ));
                },
              ),
              decoration: BoxDecoration(
                color: Colors.grey[800],
              ),
            ),
            StoreConnector<StoreData, VoidCallback>(
              converter: (store) {
                return () => store.dispatch(Actions.SetTitle);
              },
              builder: (context, callback) {
                return ListTile(
                  title: Text('Item 1'),
                  onTap: () {
                    callback();
                  },
                );
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
    );
  }
}
