import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Profile extends StatelessWidget {
  String senderid;
  String sendername;
  String senderimage;

  Profile({
    Key? key,
    required this.senderid,
    required this.sendername,
    required this.senderimage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String? text1;

    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
          child: Column(
        children: [
          Divider(height: 40),
          Center(
            child: CircleAvatar(
              radius: 150,
              backgroundImage: NetworkImage(senderimage),
            ),
          ),
          Divider(height: 20),
          Center(child: Text(sendername))
        ],
      )),
    );
  }
}
