import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(home: NewPage(title: 'hello'));
  }
}

class NewPage extends StatefulWidget {
  const NewPage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<NewPage> createState() => _NewPage();
}

class _NewPage extends State<NewPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('Home')),
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
        )));
  }
}
