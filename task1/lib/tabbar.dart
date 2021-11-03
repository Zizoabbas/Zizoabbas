import 'package:flutter/material.dart';
import 'package:flutter_application_1/tab1.dart';
import 'package:flutter_application_1/tab2.dart';
import 'package:flutter_application_1/tab3.dart';

class Zizo extends StatelessWidget {
  const Zizo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          bottom: TabBar(
            indicatorWeight: 5,
            labelPadding: EdgeInsets.all(10),
            tabs: [
              Text("todo", style: TextStyle(fontSize: 20)),
              Text("tab2", style: TextStyle(fontSize: 20)),
              Text("tab3", style: TextStyle(fontSize: 20)),
            ],
          ),
          title: Center(child: Text("zizo")),
        ),
        body: TabBarView(
          children: [
            Tabone(),
            Tabone2(),
            Tabone3(),
          ],
        ),
      ),
    );
  }
}
