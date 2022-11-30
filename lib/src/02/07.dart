import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int generalValue = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('GAD'),
      ),
      body: Column(
        children: <Widget>[
          Radio(
            value: 0,
            groupValue: generalValue,
            onChanged: (int? newValue) {
              setState(() {
                generalValue = newValue!;
              });
            },
          ),
          Radio(
            value: 1,
            groupValue: generalValue,
            onChanged: (int? newValue) {
              setState(() {
                generalValue = newValue!;
              });
            },
          ),
          Radio(
            value: 2,
            groupValue: generalValue,
            onChanged: (int? newValue) {
              setState(() {
                generalValue = newValue!;
              });
            },
          ),
        ],
      ),
    );
  }
}
