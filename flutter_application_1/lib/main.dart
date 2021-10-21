// ignore_for_file: prefer_const_constructors, duplicate_ignore

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

void main() {
  runApp(const Zizo());
}

class Zizo extends StatelessWidget {
  const Zizo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "zizo",
      theme: ThemeData(
        primarySwatch: Colors.cyan,
      ),
      home: const Home(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(""),
      ),
      body: Padding(
        padding: EdgeInsets.all(10),
        child: Card(
          color: Colors.grey,
          elevation: 20,
          clipBehavior: Clip.antiAlias,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
          child: SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CircleAvatar(
                  backgroundImage: AssetImage("images/hhh.jpg"),
                  radius: 100,
                ),
                const SizedBox(
                  width: 2,
                ),
                Text(
                  "ziad abbas",
                  style: TextStyle(
                    fontSize: 50,
                    color: Colors.blueGrey,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  width: 2,
                ),
                Text(
                  "Flutter developer",
                  style: TextStyle(
                    fontSize: 40,
                    color: Colors.blueGrey,
                    fontFamily: "Schyler",
                  ),
                ),
                InkWell(
                  child: Container(
                    height: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(100),
                        bottomRight: Radius.circular(10),
                      ),
                      gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          // ignore: prefer_const_literals_to_create_immutables
                          colors: [
                            Colors.grey,
                            Colors.white,
                          ]),
                      // ignore: prefer_const_literals_to_create_immutables
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black,
                          blurRadius: 10,
                          offset: Offset(5, 5),
                        ),
                      ],
                    ),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        // ignore: prefer_const_literals_to_create_immutables
                        children: [
                          Icon(
                            MdiIcons.facebook,
                            color: Colors.blue,
                          ),
                          Text(
                            "Facebook",
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontFamily: "Schyler",
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  onTap: () {
                    launch("https://www.facebook.com/");
                  },
                ),
                InkWell(
                  child: Container(
                    height: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(100),
                        bottomRight: Radius.circular(10),
                      ),
                      gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          // ignore: prefer_const_literals_to_create_immutables
                          colors: [
                            Colors.grey,
                            Colors.white,
                          ]),
                      // ignore: prefer_const_literals_to_create_immutables
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black,
                          blurRadius: 10,
                          offset: Offset(5, 5),
                        ),
                      ],
                    ),
                    child: Center(
                      child: Column(
                        // ignore: prefer_const_literals_to_create_immutables
                        children: [
                          Icon(
                            MdiIcons.phone,
                            color: Colors.green,
                          ),
                          Text(
                            "Call ziad",
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontFamily: "Schyler",
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  onTap: () {
                    launch("tel:01155224266");
                  },
                ),
                InkWell(
                  child: Container(
                    height: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(100),
                        bottomRight: Radius.circular(10),
                      ),
                      gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          // ignore: prefer_const_literals_to_create_immutables
                          colors: [
                            Colors.grey,
                            Colors.white,
                          ]),
                      // ignore: prefer_const_literals_to_create_immutables
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black,
                          blurRadius: 10,
                          offset: Offset(5, 5),
                        ),
                      ],
                    ),
                    child: Center(
                      child: Column(
                        // ignore: prefer_const_literals_to_create_immutables
                        children: [
                          Icon(MdiIcons.gmail, color: Colors.red),
                          Text(
                            "Sent Email",
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontFamily: "Schyler",
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  onTap: () {
                    launch("mailto:zizoabbas567@gmail.com");
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
