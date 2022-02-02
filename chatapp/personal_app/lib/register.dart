import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart' as firebase_core;
import 'package:personal_app/adduser.dart';

class Register extends StatefulWidget {
  Register({Key? key}) : super(key: key);

  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final createuser = FirebaseFirestore.instance.collection("items");
  String? text1;
  String? text2;

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Divider(height: 20),
              Divider(height: 20),
              TextFormField(
                onChanged: (value) => text1 = value,
                // ignore: unnecessary_new
                decoration: InputDecoration(
                  labelText: "Email",
                  fillColor: Colors.red,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25.0),
                    borderSide: BorderSide(),
                  ),
                ),
                validator: (val) {
                  if (val!.isEmpty) {
                    return "Email cannot be empty";
                  } else {
                    return null;
                  }
                },
                keyboardType: TextInputType.emailAddress,
                style: TextStyle(
                  fontFamily: "Poppins",
                ),
              ),
              Divider(height: 20),
              TextFormField(
                onChanged: (value) => text2 = value,
                decoration: InputDecoration(
                  labelText: "Password",
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25.0),
                    borderSide: BorderSide(),
                  ),
                ),
                validator: (val) {
                  if (val!.isEmpty) {
                    return "password cannot be empty";
                  } else {
                    return null;
                  }
                },
                keyboardType: TextInputType.number,
                style: TextStyle(
                  fontFamily: "Poppins",
                ),
              ),
              const Divider(height: 20),
              ElevatedButton(
                  onPressed: () async {
                    if (text1 == null && text2 == null) {
                      return;
                    } else {
                      try {
                        await FirebaseAuth.instance
                            .createUserWithEmailAndPassword(
                                email: text1.toString(),
                                password: text2.toString());
                      } on firebase_core.FirebaseException {
                        return;
                      }
                      String userid = FirebaseAuth.instance.currentUser!.uid;
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Adduser(user: userid)));
                    }

                    setState(() {});
                  },
                  child: const Text("next"))
            ],
          ),
        ),
      ),
    );
  }
}
