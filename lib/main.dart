import 'package:flutter/material.dart';
import './common/AppLayout.dart';
import './pages/RootPage.dart';


void main() {
  runApp(CNodeApp());
}

class CNodeApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AppLayout(
      child: RootPage(),
    );
  }
}
