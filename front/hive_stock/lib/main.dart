import 'package:flutter/material.dart';
import 'app.dart';

void main() => runApp(const App());

class Test extends StatelessWidget {
  const Test({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: "hihi",
      home: Scaffold(
        body: Center(
          child: Text("lol"),
        ),
      ),
    );
  }
}
