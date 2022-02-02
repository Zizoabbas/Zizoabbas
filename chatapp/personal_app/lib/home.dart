import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';

import 'package:personal_app/chatpage.dart';
import 'package:personal_app/profile.dart';

class Home extends StatelessWidget {
  String myid;
  Home({
    Key? key,
    required this.myid,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final userscollection =
        FirebaseFirestore.instance.collection("items").snapshots();
    final userscollection2 =
        FirebaseFirestore.instance.collection("items").doc(myid).snapshots();

    return StreamBuilder<DocumentSnapshot>(
        stream: userscollection2,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: Text("some thing went wrong "));
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: Text("loading "));
          }
          final myname = snapshot.data!.get("name");
          final myimage = snapshot.data!.get("image");

          return Scaffold(
            backgroundColor: Colors.red,
            body: SafeArea(
              child: StreamBuilder<QuerySnapshot>(
                  stream: userscollection,
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return const Center(
                          child: Text("some thing went wrong "));
                    }
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: Text("loading "));
                    }
                    final members = snapshot.data!.docs;

                    return SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Divider(height: 20),
                          const Text(
                            "Chat App",
                            style: const TextStyle(fontSize: 30),
                          ),
                          const Divider(
                            height: 20,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(1.0),
                            child: Container(
                              height: 80,
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                physics: const BouncingScrollPhysics(),
                                shrinkWrap: true,
                                itemBuilder: (BuildContext context, int index) {
                                  return InkWell(
                                      child: Padding(
                                          padding: const EdgeInsets.all(1.0),
                                          child: Container(
                                            height: 80,
                                            width: 80,
                                            child: CircleAvatar(
                                              child:
                                                  Text(members[index]["name"]),
                                              backgroundImage: NetworkImage(
                                                  members[index]["image"]),
                                              radius: 20,
                                            ),
                                          )),
                                      onTap: () {
                                        myid == members[index].id
                                            ? Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        Profile(
                                                          senderimage:
                                                              members[index]
                                                                  ["image"],
                                                          sendername:
                                                              members[index]
                                                                  ["name"],
                                                          senderid:
                                                              members[index].id,
                                                        )))
                                            : Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        Chatpage(
                                                            myid: myid,
                                                            sendername: myname,
                                                            senderid: myid,
                                                            indexid:
                                                                members[index]
                                                                    .id,
                                                            userid:
                                                                members[index]
                                                                    .id,
                                                            name: members[index]
                                                                ["name"])));
                                      });
                                },
                                itemCount: members.length,
                              ),
                            ),
                          ),
                          const Divider(height: 20),
                          Container(
                            height: 700,
                            width: 500,
                            decoration: const BoxDecoration(
                              color: Colors.black38,
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(30),
                                topRight: Radius.circular(30),
                              ),
                            ),
                          )
                        ],
                      ),
                    );
                  }),
            ),
          );
        });
  }
}
