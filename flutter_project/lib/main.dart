import 'package:flutter/material.dart';

import 'classes/home_page.dart';
//import 'package:flutter_project/classes/home_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
    );
  }
}
