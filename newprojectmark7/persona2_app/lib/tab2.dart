import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';
import 'package:flutter_application_1/players.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/players.dart';
import 'package:flutter_application_1/team.dart';
import 'package:flutter_application_1/team2.dart';

class TabTwo extends StatefulWidget {
  TabTwo({Key? key}) : super(key: key);

  @override
  _TabTwoState createState() => _TabTwoState();
}

class _TabTwoState extends State<TabTwo> {
  @override
  Widget build(BuildContext context) {
    team2 = team.where((Element) => Element.isdone == true).toList();

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
                  title: Text(team2[index].name),
                  trailing: Text(
                      DateFormat("dd/MM hh:mm").format(team[index].endtime!)),
                  subtitle: Text(team[index]
                      .starttime!
                      .difference(team2[index].endtime!)
                      .toString()),
                ),
              );
            },
            itemCount: team2.length,
          ),
        ]),
      ),
    );
  }
}
