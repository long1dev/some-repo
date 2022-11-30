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
  Color _color = Colors.blue;
  Alignment _alignment = Alignment.topLeft;
  int _scale = 2;

  @override
  Widget build(BuildContext context) {
    TextButton(
      style: const ButtonStyle(
        backgroundColor: MaterialStatePropertyAll<Color>(Colors.grey),
      ),
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const MultiplayerTikTakToe()),
        );
      },
      child: const Text("Multiplayer"),
    );
    TextButton(
      style: TextButton.styleFrom(
        backgroundColor: Colors.grey,
      ),
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const MultiplayerTikTakToe()),
        );
      },
      child: const Text("Multiplayer"),
    );

    return Scaffold(
      appBar: AppBar(
        title: Text('Scrollable App'),
      ),
      body: Center(
        child: GestureDetector(
          onTap: () {
            setState(() {
              if (_color == Colors.blue) {
                _color = Colors.red;
                _alignment = Alignment.topLeft;
                _scale = 1;
              } else {
                _color = Colors.blue;
                _alignment = Alignment.center;
                _scale = 2;
              }
            });
          },
          child: Builder(
            builder: (BuildContext context) {
              return AnimatedAlign(
                alignment: _alignment,
                duration: const Duration(seconds: 2),
                child: AnimatedContainer(
                  width: 200.0 * _scale,
                  height: 200.0 * _scale,
                  color: _color,
                  duration: const Duration(seconds: 1),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
