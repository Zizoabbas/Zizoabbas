import 'package:flutter/material.dart';
import 'package:flutter_application_1/tab1.dart';
import 'package:flutter_application_1/tab2.dart';
import 'package:flutter_application_1/tab3.dart';

class Homepage extends StatefulWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  int currentpage = 0;
  final List<BottomNavigationBarItem> items = [
    BottomNavigationBarItem(icon: Icon(Icons.gamepad), label: "add task"),
    BottomNavigationBarItem(icon: Icon(Icons.gamepad), label: "done"),
    BottomNavigationBarItem(icon: Icon(Icons.gamepad), label: "not done"),
  ];

  @override
  Widget build(BuildContext context) {
    PageController _controller = PageController(
      initialPage: currentpage,
    );
    void ontapicon(int index) => _controller.animateToPage(index,
        duration: const Duration(milliseconds: 20), curve: Curves.easeIn);
    return Scaffold(
      body: PageView(
        controller: _controller,
        onPageChanged: (value) {
          setState(() {
            currentpage = value;
          });
        },
        children: [
          TabOne(),
          TabTwo(),
          TabThree(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentpage,
        backgroundColor: Colors.brown,
        selectedItemColor: Colors.yellow,
        unselectedItemColor: Colors.white,
        onTap: ontapicon,
        items: items,
      ),
    );
  }
}
