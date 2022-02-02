import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart' as firebase_core;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:personal_app/home.dart';
import 'package:personal_app/register.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    String? text1;
    String? text2;
    User? user = FirebaseAuth.instance.currentUser;

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Divider(height: 50),
            TextFormField(
              onChanged: (value) => text1 = value,
              // ignore: unnecessary_new
              decoration: new InputDecoration(
                labelText: "Email",
                fillColor: Colors.red,
                border: new OutlineInputBorder(
                  borderRadius: new BorderRadius.circular(25.0),
                  borderSide: new BorderSide(),
                ),
              ),
              validator: (val) {
                if (val!.isEmpty) {
                  return "neck name cannot be empty";
                } else {
                  return null;
                }
              },
              keyboardType: TextInputType.text,
              style: new TextStyle(
                fontFamily: "Poppins",
              ),
            ),
            Divider(height: 20),
            TextFormField(
              onChanged: (value) => text2 = value,
              decoration: new InputDecoration(
                labelText: "Password",
                fillColor: Colors.white,
                border: new OutlineInputBorder(
                  borderRadius: new BorderRadius.circular(25.0),
                  borderSide: new BorderSide(),
                ),
              ),
              validator: (val) {
                if (val!.isEmpty) {
                  return "phone number cannot be empty";
                } else {
                  return null;
                }
              },
              keyboardType: TextInputType.number,
              style: TextStyle(
                fontFamily: "Poppins",
              ),
            ),
            Divider(height: 20),
            ElevatedButton(
                onPressed: () async {
                  setState(() {});
                  if (text2 == null && text1 == null) {
                    return;
                  } else {
                    try {
                      await FirebaseAuth.instance.signInWithEmailAndPassword(
                          email: text1.toString(), password: text2.toString());
                      setState(() {});
                    } on firebase_core.FirebaseException catch (e) {
                      return;
                    }
                  }

                  if (user == null) {
                    return;
                  } else {
                    setState(() {
                      String? userid = FirebaseAuth.instance.currentUser!.uid;
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Home(myid: userid)));
                    });
                  }
                },
                child: Text("login")),
            Divider(height: 20),
            ElevatedButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Register()));
                },
                child: Text("register"))
          ],
        ),
      ),
    );
  }
}
