import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:market_app/logic/blocs/auth_bloc/auth_bloc.dart';
import 'package:market_app/presentation/screens/add_product_screen.dart';
import 'package:market_app/presentation/screens/auth_screen.dart';
import 'package:market_app/presentation/screens/home_screen.dart';
import 'package:market_app/presentation/screens/orders_screen.dart';
import 'package:market_app/presentation/screens/user_products_screen.dart';

// class AppDrawer extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Drawer(
//       child: Column(
//         children: [
//           AppBar(
//             title: Text('Hello Friend !'),
//             automaticallyImplyLeading: false,
//           ),
//           Divider(),
//           ListTile(
//             leading: Icon(Icons.store),
//             title: Text('Home'),
//             onTap: () {
//               Navigator.pushReplacementNamed(context, '/');
//             },
//           ),
//           Divider(),
//           ListTile(
//             leading: Icon(Icons.payment),
//             title: Text('Orders'),
//             onTap: () {
//               Navigator.of(context).pushNamed(
//                   BlocProvider.of<AuthBloc>(context).state is Authunticated
//                       ? "/order_screen"
//                       : "/auth_screen");
//               // Navigator.of(context).pushReplacement(MaterialPageRoute(
//               //     builder: (context) =>
//               //         BlocProvider.of<AuthBloc>(context).state is Authunticated
//               //             ? const OrdersScreen()
//               //             : AuthScreen()));
//             },
//           ),
//           Divider(),
//           ListTile(
//             leading: Icon(Icons.edit),
//             title: Text('Manage Your Products'),
//             onTap: () {
//               Navigator.of(context).pushNamed("/orders_screen");

//               // Navigator.of(context).pushReplacementNamed(
//               //   BlocProvider.of<AuthBloc>(context).state is Authunticated
//               //       ? "/orders_screen"routeName
//               //       : "/auth_screen",
//               // Navigator.of(context).pushReplacement(
//               //   MaterialPageRoute(
//               //     builder: (context) =>
//               //         BlocProvider.of<AuthBloc>(context).state is Authunticated
//               //             ? UserProductsScreen()
//               //             : AuthScreen(),
//               //   ),
//               // );
//             },
//           ),
//           Divider(),
//           if (BlocProvider.of<AuthBloc>(context).state is Authunticated)
//             ListTile(
//               leading: Icon(Icons.exit_to_app),
//               title: Text('Log Out'),
//               onTap: () {
//                 if (BlocProvider.of<AuthBloc>(context).state is Authunticated) {
//                   BlocProvider.of<AuthBloc>(context).state is Unauthunticated;
//                   Navigator.of(context).pushNamed("/auth_screen");
//                 }
//               },
//             ),
//         ],
//       ),
//     );
//   }
// }
List<players> team = [
  players(name: "Home"),
  players(name: "Orders"),
  players(name: "Manage items"),
];

// ignore: camel_case_types
class players {
  String name;

  players({
    required this.name,
  });
}

void selecteditems(BuildContext context, int index) {
  switch (index) {
    case 0:
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => HomeScreen()));
      break;
    case 1:
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  BlocProvider.of<AuthBloc>(context).state is Authunticated
                      ? OrdersScreen()
                      : AuthScreen()));

      break;
    case 2:
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  BlocProvider.of<AuthBloc>(context).state is Authunticated
                      ? AddProductScreen()
                      : AuthScreen()));

      break;
  }
}
// ignore_for_file: camel_case_types

class AppDrawer extends StatefulWidget {
  const AppDrawer({Key? key}) : super(key: key);

  @override
  _AppDrawerState createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: Colors.grey,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView(
            children: [
              Text(
                "Welcome",
                style: TextStyle(
                  fontSize: 25,
                  color: Colors.black,
                  fontWeight: FontWeight.w600,
                  fontFamily: "Schyler",
                  decorationThickness: 1,
                  decorationColor: Colors.blue,
                  decorationStyle: TextDecorationStyle.wavy,
                  letterSpacing: 3,
                  wordSpacing: 16,
                  shadows: [
                    Shadow(
                      color: Colors.black,
                      blurRadius: 5,
                      offset: Offset(1, 1),
                    ),
                  ],
                ),
              ),
              Divider(
                height: 50,
              ),
              ListView.builder(
                physics: ScrollPhysics(parent: null),
                shrinkWrap: true,
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListTile(
                      // trailing: Icon(Icons.ac_unit),
                      title: InkWell(
                        child: Container(
                          height: 60,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(100),
                                bottomRight: Radius.circular(100),
                                topLeft: Radius.circular(100),
                                topRight: Radius.circular(100)),
                            gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [
                                  Colors.grey,
                                  Colors.white,
                                ]),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black,
                                blurRadius: 10,
                                offset: Offset(5, 5),
                              ),
                            ],
                          ),
                          child: Center(
                            child: Text(
                              team[index].name,
                              style: TextStyle(
                                  fontSize: 20, fontStyle: FontStyle.normal),
                            ),
                          ),
                        ),
                        onTap: () => selecteditems(context, index),
                      ),
                    ),
                  );
                },
                itemCount: team.length,
              ),
              const SizedBox(
                height: 50,
              ),
              Divider(
                height: 20,
              ),
              if (BlocProvider.of<AuthBloc>(context).state is Authunticated)
                ListTile(
                  leading: Icon(Icons.exit_to_app),
                  title: Text('Log Out'),
                  onTap: () {
                    if (BlocProvider.of<AuthBloc>(context).state
                        is Authunticated) {
                      BlocProvider.of<AuthBloc>(context).state
                          is Unauthunticated;
                      Navigator.of(context).pushNamed("/auth_screen");
                    }
                  },
                ),
            ],
          ),
        ),
      ),
    );
  }
}
