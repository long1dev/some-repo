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
  List<bool?> values = <bool?>[false, null, false];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('GAD'),
      ),
      body: Column(
        children: <Widget>[
          for (int i = 0; i < 4; i++)
            Checkbox(
              value: values[i],
              onChanged: (bool? newValue) {
                setState(() {
                  values[i] = newValue;
                });
              },
            ),
          if (values.isNotEmpty) const Text('No values yet') else Text('There are values'),
        ],
      ),
    );
  }
}
