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
  bool isselectedT = false;
  bool isselectedd = false;
  TimeOfDay currentTime = TimeOfDay.now();
  DateTime currentdate = DateTime.now();

  Future<void> _selecttime(BuildContext context) async {
    final TimeOfDay? picktime = await showTimePicker(
      context: context,
      initialTime: currentTime,
      initialEntryMode: TimePickerEntryMode.input,
      helpText: "pick time",
      confirmText: "done",
      cancelText: "later",
    );
    if (picktime != null && picktime != currentTime) {
      setState(() {
        currentTime = picktime;
        isselectedT = true;
      });
    }
  }

  Future<void> _selectdate(BuildContext context) async {
    final DateTime? pickdate = await showDatePicker(
      context: context,
      initialDate: currentdate,
      initialEntryMode: DatePickerEntryMode.input,
      firstDate: DateTime(2021, 1, 1),
      lastDate: DateTime(2030, 1, 1),
      helpText: "pick time",
      confirmText: "done",
      cancelText: "later",
    );
    if (pickdate != null && pickdate != currentdate) {
      setState(() {
        currentdate = pickdate;
        isselectedd = true;
      });
    }
  }

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
                    isScrollControlled: true,
                    builder: (context) {
                      return SingleChildScrollView(
                        child: Container(
                          padding: EdgeInsets.only(
                              bottom: MediaQuery.of(context).viewInsets.bottom),
                          child: Column(
                            children: [
                              TextField(controller: control1),
                              TextField(controller: control2),
                              Card(
                                child: ListTile(
                                  leading: Icon(Icons.ac_unit),
                                  title: isselectedT
                                      ? Text(
                                          "${currentTime.format(context).toString()}")
                                      : const Text("selectur time"),
                                  onTap: () {
                                    _selecttime(context);
                                  },
                                ),
                              ),
                              Card(
                                child: ListTile(
                                  leading: Icon(Icons.access_alarm_outlined),
                                  title: isselectedd
                                      ? Text(
                                          "${currentdate.day}/${currentdate.month}/${currentdate.year}")
                                      : Text("select u r date"),
                                  onTap: () {
                                    _selectdate(context);
                                  },
                                ),
                              ),
                              ElevatedButton(
                                  onPressed: () {
                                    var text = control1;
                                    // var text2 = control2;
                                    setState(() {
                                      team.add(players(
                                        name: text.text,
                                        dudate:
                                            ("${currentTime.format(context).toString()},${currentdate.day}/${currentdate.month}/${currentdate.year}"),
                                        starttime: DateTime.now(),
                                      ));
                                      Navigator.pop(context);
                                    });
                                  },
                                  child: Text("add"))
                            ],
                          ),
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
                  trailing: Text(
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
                  title: Text(
                    team[index].name,
                    style: TextStyle(
                        decoration: team[index].isdone
                            ? TextDecoration.lineThrough
                            : null),
                  ),
                  subtitle: Text(team[index].dudate),
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

// Future<void> _selecttime(BuildContext context) async {
//   TimeOfDay currentTime = TimeOfDay.now();
//   // bool isselectedT = false;
//   final TimeOfDay? picktime = await showTimePicker(
//     context: context,
//     initialTime: currentTime,
//     initialEntryMode: TimePickerEntryMode.dial,
//     helpText: "pick time",
//     confirmText: "done",
//     cancelText: "later",
//   );
//   if (picktime != null && picktime != currentTime) {
//     setstate() {
//       currentTime = picktime;
//       isselectedT = true;
//     }
//   }
// }

// Future<void> _selectdate(BuildContext context) async {
//   DateTime currentdate = DateTime.now();
//   // bool isselectedd = false;
//   final DateTime? pickdate = await showDatePicker(
//     context: context,
//     initialDate: currentdate,
//     firstDate: DateTime(2021, 1, 1),
//     lastDate: DateTime(2030, 1, 1),
//     helpText: "pick time",
//     confirmText: "done",
//     cancelText: "later",
//   );
//   if (pickdate != null && pickdate != currentdate) {
//     setstate() {
//       currentdate = pickdate;
//       isselectedd = true;
//     }
//   }
// }
