import 'package:flutter/material.dart';

class Tabone extends StatefulWidget {
  const Tabone({Key? key}) : super(key: key);

  @override
  _taboneState createState() => _taboneState();
}

class _taboneState extends State<Tabone> {
  int currentpage = 0;
  var checkbox1 = false;
  var checkbox2 = false;
  var checkbox3 = false;
  var checkbos4 = false;

  @override
  final List<BottomNavigationBarItem> items = [
    BottomNavigationBarItem(icon: Icon(Icons.list_sharp), label: "todos"),
    BottomNavigationBarItem(icon: Icon(Icons.list_outlined), label: "done"),
    BottomNavigationBarItem(icon: Icon(Icons.line_style_sharp), label: " next"),
  ];
  Widget build(BuildContext context) {
    PageController _controller = PageController(
      initialPage: currentpage,
    );
    void ontapicon(int index) => _controller.animateToPage(index,
        duration: const Duration(milliseconds: 20), curve: Curves.easeIn);
    return Scaffold(
      backgroundColor: Colors.brown,
      body: PageView(
        controller: _controller,
        onPageChanged: (value) {
          setState(() {
            currentpage = value;
          });
        },
        children: [
          SingleChildScrollView(
            padding: EdgeInsets.all(5),
            child: Column(
              children: [
                ListTile(
                  leading: Checkbox(
                    value: (checkbos4),
                    onChanged: (value) {
                      setState(() {
                        checkbox1 = checkbox2 = checkbox3 = checkbos4 = value!;
                      });
                    },
                  ),
                  title: Text("Select All"),
                ),
                Divider(
                  color: Colors.black,
                ),
                ListTile(
                  leading: Checkbox(
                    activeColor: Colors.amber,
                    checkColor: Colors.black,
                    value: checkbox1,
                    onChanged: (value) {
                      setState(() {
                        checkbox1 = value!;
                      });
                    },
                  ),
                  title: Text(
                    "task1",
                    style: TextStyle(
                        decoration: checkbox1 == true
                            ? TextDecoration.lineThrough
                            : null),
                  ),
                ),
                ListTile(
                  leading: Checkbox(
                    activeColor: Colors.amber,
                    checkColor: Colors.black,
                    value: checkbox2,
                    onChanged: (value) {
                      setState(() {
                        checkbox2 = value!;
                      });
                    },
                  ),
                  title: Text(
                    "task2",
                    style: TextStyle(
                        decoration: checkbox2 == true
                            ? TextDecoration.lineThrough
                            : null),
                  ),
                ),
                ListTile(
                  leading: Checkbox(
                    activeColor: Colors.amber,
                    checkColor: Colors.black,
                    value: checkbox3,
                    onChanged: (value) {
                      setState(() {
                        checkbox3 = value!;
                      });
                    },
                  ),
                  title: Text("task3"),
                ),
              ],
            ),
          ),
          Center(
            child: Text("hi"),
          ),
          Center(
            child: Text("hi"),
          ),
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
