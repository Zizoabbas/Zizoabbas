import 'package:flutter/material.dart';
import 'package:personal_app/scaffold.dart';

void main(List<String> args) {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "appbardemo",
      theme: ThemeData(
        primarySwatch: Colors.brown,
      ),
      home: Homepage(),
    );
  }
}
