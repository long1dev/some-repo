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
  // 1. define a variable that changes
  // 2. used the variable in the build method to create UI
  // 3. modify the value in setState

  Alignment value = Alignment.bottomLeft;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('GAD'),
      ),
      body: Align(
        alignment: value,
        child: ElevatedButton(
          child: const Text('Move me!'),
          onPressed: () {
            setState(() {
              value = Alignment.bottomRight;
            });
          },
        ),
      ),
    );
  }
}
