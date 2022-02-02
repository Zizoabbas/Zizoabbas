import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:personal_app/home.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:firebase_core/firebase_core.dart' as firebase_core;

class Adduser extends StatelessWidget {
  String? user;
  Adduser({
    Key? key,
    required this.user,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final firebase_storage.FirebaseStorage _storage =
        firebase_storage.FirebaseStorage.instance;
    final createuser = FirebaseFirestore.instance.collection("items");
    String? text1;
    String? text2;
    XFile? image;
    String? urlz;
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Expanded(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Stack(children: [
                  Container(
                    height: 300,
                    width: 300,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(300),
                        bottomRight: Radius.circular(300),
                        topLeft: Radius.circular(300),
                        topRight: Radius.circular(300),
                      ),
                      gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.grey,
                            Colors.white,
                          ]),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black,
                          blurRadius: 10,
                          offset: Offset(5, 5),
                        ),
                      ],
                    ),
                    child: image == null
                        ? Center(
                            child: Text("select photo"),
                          )
                        : Center(
                            child: CircleAvatar(
                              radius: 20,
                              backgroundImage: NetworkImage(urlz!.toString()),
                            ),
                          ),
                  ),
                  InkWell(
                      child: Container(
                        height: 80,
                        width: 80,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(80),
                            bottomRight: Radius.circular(80),
                            topLeft: Radius.circular(80),
                            topRight: Radius.circular(80),
                          ),
                          gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                Colors.grey,
                                Colors.white,
                              ]),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black,
                              blurRadius: 10,
                              offset: Offset(5, 5),
                            ),
                          ],
                        ),
                        child: Center(
                          child: Icon(Icons.camera_alt),
                        ),
                      ),
                      onTap: () async {
                        try {
                          final image = await ImagePicker()
                              .pickImage(source: ImageSource.camera);
                          if (image == null) return;
                          final imagepath = File(image.path);
                          final imagename = File(image.name);
                          File file = File(image.path);
                          try {
                            await _storage.ref("file/$imagename").putFile(file);
                            // ignore: empty_catches
                          } on firebase_core.FirebaseException catch (e) {}
                          final downloadurl = await _storage
                              .ref("file/$imagename")
                              .getDownloadURL();
                          final url = downloadurl.toString();
                          urlz = url;
                        } on PlatformException catch (e) {
                          print("faild to pick image :$e");
                        }
                      }),
                ]),
                Divider(height: 20),
                TextFormField(
                  onChanged: (value) => text1 = value,
                  // ignore: unnecessary_new
                  decoration: new InputDecoration(
                    labelText: "nick name",
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
                    labelText: "phone numaber",
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
                    onPressed: () {
                      if (text1 == null && text2 == null) {
                        return;
                      } else {
                        createuser.doc('$user').set({
                          "name": text1,
                          "id": text2,
                          "image": urlz.toString()
                        });
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Home(myid: user!)));
                      }
                    },
                    child: Text("finish"))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
