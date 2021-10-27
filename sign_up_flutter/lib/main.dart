import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: MyHomePage (title: 'Hhello')
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
   String dropdownValue = 'Male';
   String Name = '';
   String Email = '';
   String Password = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     appBar: AppBar(
          title: const Text('Sign Up!')
        ),
        body: Form(
          key: _formKey,
          child: Column(
            children: <Widget> [
              const Text('Welcome Message'),
              TextFormField(
                decoration: const InputDecoration(
                hintText: 'Name',
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
              TextFormField(
                decoration: const InputDecoration(
                hintText: 'Email',
              ),
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your email';
                  }
                  return null;
                },
                onChanged: (String? value) {
                  setState(() {
                    Email = value!;
                  });
                },
              ),
              TextFormField(
                decoration: const InputDecoration(
                hintText: 'Password',
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
              ),
              DropdownButton (
                value: dropdownValue,
                icon: const Icon(Icons.arrow_downward),
                iconSize: 16,
                elevation: 16,
                style: const TextStyle(color: Colors.deepPurple),
                underline: Container(
                  height: 2,
                  color: Colors.deepPurpleAccent,
                ),
                onChanged: (String? newValue) {
                  setState(() {
                    dropdownValue = newValue!;
                  });
                },
                items: <String>['Male', 'Female', 'Others', 'Free']
                  .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
              ),
              ElevatedButton(
                child: const Text('Submit'),
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('$Name, $Email, $Password, $dropdownValue'),
                        action: SnackBarAction(
                          label: 'Action',
                          onPressed: () {
                            // Code to execute.
                          },
                        ),
                      ),
                    );
                  }
                },
              )
            ],
          )
        )
    );
  }
}
