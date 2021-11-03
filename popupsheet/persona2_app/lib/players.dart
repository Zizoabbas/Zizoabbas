import 'package:flutter/material.dart';

class players {
  String name;
  String age;
  bool isdone;
  DateTime? starttime;
  DateTime? endtime;

  players(
      {required this.age,
      required this.name,
      this.isdone = false,
      this.starttime,
      this.endtime});
}
