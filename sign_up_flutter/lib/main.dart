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
        title: const Text('Sign up page')
        ),
        body: Form(
          key: _formKey,
          child: ListView(
            children: <Widget> [
              const Text('Welcome Message', style: TextStyle(
                  fontSize: 40,
                  color: Colors.black,
                ),
                textAlign: TextAlign.center,
                
              ),
              const Icon(Icons.bathroom_outlined, size: 100, color: Colors.deepPurpleAccent,),
              Padding(
                padding: const EdgeInsets.all(8),
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
              Padding(
                padding: const EdgeInsets.all(8),
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
              Padding(
                padding: const EdgeInsets.all(8),
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
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8),
                child: DropdownButton (
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
              ),
              Padding(
                padding: const EdgeInsets.all(8),
                child: ElevatedButton(
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
                ),
              )
            ],
          )
        )
    );
  }
}
