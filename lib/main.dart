import 'package:attendance/login.dart';
import 'package:flutter/material.dart';



void main() async {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    return MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            primarySwatch: Colors.blue, primaryColor: Colors.blue[900]),
        home:Login());
  }
}
