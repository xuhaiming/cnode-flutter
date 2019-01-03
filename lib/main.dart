import 'package:flutter/material.dart';
import './pages/RootPage.dart';

void main() {
  runApp(CNodeApp());
}

class CNodeApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CNode',
      theme: ThemeData(
        brightness: Brightness.light,
        primaryColor: Colors.grey[900],
        accentColor: Colors.cyan[600],
      ),
      home: RootPage(),
    );
  }
}
