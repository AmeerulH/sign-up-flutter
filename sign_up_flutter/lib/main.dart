import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:sign_up_flutter/home.dart';
import 'package:localstore/localstore.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(home: MyHomePage(title: 'Hhello'));
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  // ignore: prefer_typing_uninitialized_variables
  var dropdownValue;
  final genderTypes = ['Male', 'Female', 'Others'];
  String Name = '';
  String Email = '';
  String Password = '';
  final _db = Localstore.instance;
  final _items = <String, User>{};
  StreamSubscription<Map<String, dynamic>>? _subscription;

  @override
  void initState() {
    /*
    _db.collection('todos').get().then((value) {
      setState(() {
        value?.entries.forEach((element) {
          final item = Todo.fromMap(element.value);
          _items.putIfAbsent(item.id, () => item);
        });
      });
    });
    */
    //connect to the database
    _subscription = _db.collection('users').stream.listen((event) {
      setState(() {
        final item = User.fromMap(event);
        _items.putIfAbsent(item.id, () => item);
        // final _emails = _items.forEach((key, value) {})
      });
    });
    if (kIsWeb) _db.collection('users').stream.asBroadcastStream();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // backgroundColor: (Colors.cyanAccent),
        appBar: AppBar(
          title: const Text('Sign up page'),
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
        body: Form(
            key: _formKey,
            child: ListView(
              children: <Widget>[
                const Text(
                  'Sign Up!',
                  style: TextStyle(
                    fontSize: 40,
                    color: Colors.black,
                    fontWeight: FontWeight.w700,
                  ),
                  textAlign: TextAlign.center,
                ),
                const Icon(
                  Icons.real_estate_agent_outlined,
                  size: 200,
                  color: Colors.cyan,
                ),
                Container(
                  padding: const EdgeInsets.all(10),
                  child: TextFormField(
                    decoration: const InputDecoration(
                      hintText: 'Name',
                      border: OutlineInputBorder(),
                      suffixIcon: Icon(
                        Icons.error,
                      ),
                    ),
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your name';
                      }
                      return null;
                    },
                    onChanged: (String? value) {
                      setState(() {
                        Name = value!;
                      });
                    },
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(10),
                  child: TextFormField(
                    decoration: const InputDecoration(
                      hintText: 'Email',
                      border: OutlineInputBorder(),
                      suffixIcon: Icon(
                        Icons.error,
                      ),
                    ),
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your email';
                      } else if (value.isEmpty ||
                          !RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                              .hasMatch(value)) {
                        return 'Enter a valid email!';
                      } else if (_items.containsValue(value)) {
                        return 'Email has already been used';
                      }
                      return null;
                    },
                    onChanged: (String? value) {
                      setState(() {
                        Email = value!;
                      });
                    },
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(10),
                  child: TextFormField(
                    decoration: const InputDecoration(
                      hintText: 'Password',
                      border: OutlineInputBorder(),
                      suffixIcon: Icon(
                        Icons.error,
                      ),
                    ),
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your password';
                      }
                      return null;
                    },
                    onChanged: (String? value) {
                      setState(() {
                        Password = value!;
                      });
                    },
                    obscureText: true,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(10),
                  child: DropdownButtonFormField(
                    validator: (value) =>
                        value == null ? 'Please Select Your Gender' : null,
                    isExpanded: true,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                    ),
                    value: dropdownValue,
                    icon: const Icon(Icons.arrow_downward),
                    iconSize: 16,
                    elevation: 16,
                    style: const TextStyle(color: Colors.deepPurple),
                    hint: const Text('Select Your Gender'),
                    items: genderTypes.map((String value) {
                      return DropdownMenuItem(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    onChanged: (newValue) {
                      setState(() {
                        dropdownValue = newValue!;
                      });
                    },
                  ),
                ),
                Container(
                    padding: const EdgeInsets.all(20),
                    child: ElevatedButton(
                      child: const Text('Submit'),
                      // style: ElevatedButton.styleFrom(
                      //     primary: _formKey.currentState?.validate() ?? false
                      //         ? Colors.blueAccent
                      //         : Colors.blueGrey),
                      onPressed: _formKey.currentState?.validate() ?? false
                          ? () {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Successfully Signed Up!'),
                                ),
                              );
                              final id = Localstore.instance
                                  .collection('users')
                                  .doc()
                                  .id;
                              final item = User(
                                id: id,
                                name: Name,
                                email: Email,
                                password: Password,
                              );
                              item.save();
                              _items.putIfAbsent(item.id, () => item);
                              _items.forEach((key, value) {
                                // ignore: avoid_print
                                print(
                                    'ID: ${value.id}, Name: ${value.name}, Email: ${value.email}, Password: ${value.password}');
                              });
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const NewPage(title: 'hello')),
                              );
                            }
                          : null,
                    ))
              ],
            )));
  }
}

/// Data Users
class User {
  final String id;
  String name;
  String email;
  String password;

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.password,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'password': password,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
        id: map['id'],
        name: map['name'],
        email: map['email'],
        password: map['password']);
  }
}

extension ExtTodo on User {
  Future save() async {
    final _db = Localstore.instance;
    return _db.collection('users').doc(id).set(toMap());
  }

  Future delete() async {
    final _db = Localstore.instance;
    return _db.collection('users').doc(id).delete();
  }
}
