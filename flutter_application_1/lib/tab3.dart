import 'package:flutter/material.dart';

class Tabone3 extends StatefulWidget {
  const Tabone3({Key? key}) : super(key: key);

  @override
  _taboneState createState() => _taboneState();
}

class _taboneState extends State<Tabone3> {
  int currentpage = 1;
  @override
  final List<BottomNavigationBarItem> items = [
    BottomNavigationBarItem(icon: Icon(Icons.gamepad), label: "page1"),
    BottomNavigationBarItem(icon: Icon(Icons.gamepad), label: "page2"),
    BottomNavigationBarItem(icon: Icon(Icons.gamepad), label: "page3"),
  ];
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
          Center(child: Text("bottom1")),
          Center(child: Text("bottom2")),
          Center(child: Text("bottom3")),
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
