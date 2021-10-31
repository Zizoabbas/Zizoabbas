// ignore_for_file: prefer_equal_for_default_values

import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_application_1/players.dart';
import 'package:flutter_application_1/team.dart';
import 'package:flutter_application_1/Additems';

import 'package:intl/date_symbol_data_custom.dart';
import 'package:intl/intl.dart';

class TabOne extends StatefulWidget {
  const TabOne({Key? key}) : super(key: key);

  @override
  _TabOneState createState() => _TabOneState();
}

class _TabOneState extends State<TabOne> {
  @override
  Widget build(BuildContext context) {
    TextEditingController control1 = TextEditingController();
    TextEditingController control2 = TextEditingController();
    TextEditingController control3 = TextEditingController();

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(children: [
          SizedBox(
            height: 30,
          ),
          ElevatedButton(
              onPressed: () {
                showModalBottomSheet(
                    context: context,
                    builder: (context) {
                      return Container(
                        child: Column(
                          children: [
                            TextField(controller: control1),
                            TextField(controller: control2),
                            ElevatedButton(
                                onPressed: () {
                                  var text = control1;
                                  var text2 = control2;
                                  setState(() {
                                    team.add(players(
                                      name: text.text,
                                      age: text2.text,
                                      starttime: DateTime.now(),
                                    ));
                                    Navigator.pop(context);
                                  });
                                },
                                child: Text("add"))
                          ],
                        ),
                      );
                    });
              },
              child: Text("add")),
          ListView.builder(
            physics: ScrollPhysics(
                parent: null), // to be able to scroll between list items
            shrinkWrap:
                true, //for the column to not conflict with list view builder
            itemBuilder: (BuildContext context, int index) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListTile(
                  trailing: Text(team[index].age),
                  title: Text(
                    team[index].name,
                    style: TextStyle(
                        decoration: team[index].isdone
                            ? TextDecoration.lineThrough
                            : null),
                  ),
                  subtitle: Text(
                      DateFormat("dd/MM hh:mm").format(team[index].starttime!)),
                  tileColor: Colors.amber,
                  leading: Checkbox(
                      value: team[index].isdone,
                      onChanged: (value) {
                        setState(() {
                          team[index].isdone = value!;
                          if (team[index].isdone) {
                            team[index].endtime = DateTime.now();
                          }
                        });
                      }),
                ),
              );
            },
            itemCount: team.length,
          ),
        ]),
      ),
    );
  }
}
