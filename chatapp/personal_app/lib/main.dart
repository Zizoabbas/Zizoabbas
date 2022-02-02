import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:personal_app/home.dart';
import 'package:personal_app/login.dart';
import 'package:personal_app/register.dart';

void main(List<String> args) async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "appbardemo",
      theme: ThemeData(
        primarySwatch: Colors.grey,
      ),
      home: Splashscreen(),
    );
  }
}

class Splashscreen extends StatelessWidget {
  const Splashscreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      splash: Column(
        children: [
          Center(
            child: CircleAvatar(
                radius: 100, backgroundImage: AssetImage("assets/zzz.png")),
          )
        ],
      ),
      nextScreen: Login(),
      splashIconSize: 200,
      duration: 4000,
      backgroundColor: Colors.amber,
    );
  }
}
