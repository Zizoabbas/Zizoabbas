import 'package:flutter/material.dart';

class players {
  String name;
  String dudate;
  bool isdone;
  DateTime? starttime;
  DateTime? endtime;

  players(
      {required this.dudate,
      required this.name,
      this.isdone = false,
      this.starttime,
      this.endtime});
}
