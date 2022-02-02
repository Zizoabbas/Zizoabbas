import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Chatpage extends StatelessWidget {
  String indexid;
  String myid;
  String userid;
  String name;
  String senderid;
  String sendername;

  Chatpage({
    Key? key,
    required this.indexid,
    required this.myid,
    required this.userid,
    required this.name,
    required this.senderid,
    required this.sendername,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // String? text1;
    TextEditingController text = TextEditingController();

    final messagesender =
        FirebaseFirestore.instance.collection("messages/$indexid$myid/chats");
    final messagesender2 =
        FirebaseFirestore.instance.collection("messages/$myid$indexid/chats");

    final usersmessages = FirebaseFirestore.instance
        .collection("messages/$indexid$myid/chats")
        .orderBy("createdat", descending: false)
        .snapshots();

    return Scaffold(
      appBar: AppBar(
        title: Text(name),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Container(
                height: 600,
                width: 600,
                color: Colors.amber,
                child: StreamBuilder<QuerySnapshot>(
                    stream: usersmessages,
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return const Center(
                            child: Text("some thing went wrong "));
                      }
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: Text("loading "));
                      }
                      final messages = snapshot.data!.docs;

                      return ListView.builder(
                        physics: BouncingScrollPhysics(),
                        shrinkWrap: true,
                        itemBuilder: (BuildContext context, int index) {
                          final senderid = messages[index]["id"];
                          final mess = messages[index]["message"];
                          final sender = messages[index]["sender"];

                          return Container(
                            color: indexid != senderid
                                ? Colors.blue
                                : Colors.orange,
                            child: ListTile(
                              title: Text(mess),
                              leading: CircleAvatar(
                                child: Text(sender),
                                radius: 20,
                              ),
                            ),
                          );
                        },
                        itemCount: messages.length,
                      );
                    }),
              ),
            ),
            Divider(
              height: 40,
            ),
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    autofocus: false,
                    controller: text,
                    // onChanged: (value) => text1 = value,
                    decoration: InputDecoration(
                      // labelText: "phone numaber",
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25.0),
                        borderSide: const BorderSide(),
                      ),
                    ),
                    validator: (val) {
                      if (val!.isEmpty) {
                        return "";
                      } else {
                        return null;
                      }
                    },
                    keyboardType: TextInputType.text,
                    style: const TextStyle(
                      fontFamily: "Poppins",
                    ),
                  ),
                ),
                IconButton(
                    onPressed: () {
                      FocusScope.of(context).unfocus();
                      messagesender.add({
                        "createdat": TimeOfDay.now().toString(),
                        "message": text.text,
                        "sender": sendername,
                        "id": senderid,
                        "sentto": name
                      });
                      messagesender2.add({
                        "createdat": TimeOfDay.now().toString(),
                        "message": text.text,
                        "sender": sendername,
                        "id": senderid,
                        "sentto": name
                      });
                    },
                    icon: Icon(Icons.arrow_forward_sharp)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
