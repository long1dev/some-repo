import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Adrian'),
          actions: <Widget>[
            IconButton(
              icon: const Icon(
                Icons.add_alarm,
              ),
              onPressed: () {
                print('Add alarm');
              },
            ),
            IconButton(
              icon: const Icon(
                Icons.add_alert,
              ),
              onPressed: () {
                if (kDebugMode) {
                  print('Add alert');
                }
              },
            )
          ],
        ),
        drawer: const Drawer(),
        body: Column(
          children: <Widget>[
            const Center(
              child: Text('David'),
            ),
            TextButton(
              child: const Text('Sarmale'),
              onPressed: () {
                print('Ai manacat o sarma');
              },
            ),
            ElevatedButton(
              child: const Text('+1'),
              onPressed: () {
                //
              },
            ),
          ],
        ),
        floatingActionButton: Builder(
          builder: (BuildContext context) {
            return FloatingActionButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return const AboutDialog();
                  },
                );
              },
            );
          },
        ),
      ),
    );
  }
}
