import 'package:flutter/material.dart';

import 'package:flutter_application_1/players.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/players.dart';
import 'package:flutter_application_1/team.dart';
import 'package:flutter_application_1/team2.dart';
import 'package:flutter_application_1/team3.dart';

class TabThree extends StatefulWidget {
  TabThree({Key? key}) : super(key: key);

  @override
  _TabTwoState createState() => _TabTwoState();
}

class _TabTwoState extends State<TabThree> {
  @override
  Widget build(BuildContext context) {
    team3 = team.where((Element) => Element.isdone == false).toList();
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(children: [
          ListView.builder(
            physics: ScrollPhysics(
                parent: null), // to be able to scroll between list items
            shrinkWrap:
                true, //for the column to not conflict with list view builder
            itemBuilder: (BuildContext context, int index) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListTile(
                  title: Text(team3[index].name),
                ),
              );
            },
            itemCount: team3.length,
          ),
        ]),
      ),
    );
  }
}
