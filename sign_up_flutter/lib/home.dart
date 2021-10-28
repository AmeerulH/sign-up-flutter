import 'package:flutter/material.dart';

import 'main.dart';

User test =
    {'id': 0, 'name': '', 'email': '1@gmail.com', 'password': '1234'} as User;

void main() {
  runApp(HomePage(user: test));
}

class HomePage extends StatelessWidget {
  final User user;

  const HomePage({Key? key, required this.user}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
            appBar: AppBar(
              title: Text('user.name'),
              flexibleSpace: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                      colors: [
                        Color(0xFF3366FF),
                        Color(0xFF00CCFF),
                      ],
                      begin: FractionalOffset(0.0, 0.0),
                      end: FractionalOffset(1.0, 0.0),
                      stops: [0.0, 1.0],
                      tileMode: TileMode.clamp),
                ),
              ),
            ),
            body: Center(
                child: Column(
              children: const [
                Text(
                  'Hello Deriv!',
                  style: TextStyle(
                    fontSize: 40,
                    color: Colors.black,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ))));
  }
}
