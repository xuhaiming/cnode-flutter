import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

import './pages/RootPage.dart';
import './reducer/StoreData.dart';

void main() {
  final store = new Store<StoreData>(
    reducer,
    initialState: StoreData(title: 'initial'),
  );
  runApp(CNodeApp(store: store));
}

class CNodeApp extends StatelessWidget {
  final Store<StoreData> store;

  CNodeApp({
    Key key,
    this.store,
  });

  @override
  Widget build(BuildContext context) {
    return StoreProvider<StoreData>(
      store: store,
      child: MaterialApp(
        title: 'CNode',
        theme: ThemeData(
          brightness: Brightness.light,
          primaryColor: Colors.grey[900],
          accentColor: Colors.cyan[600],
        ),
        home: RootPage(),
      ),
    );
  }
}
