import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'HiveStock',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
  title: Row(
    mainAxisAlignment: MainAxisAlignment.center, // Centrer les enfants horizontalement
    children: [
      Expanded(
        child: CustomProgressBar(currentIndex: 0),
      ),
    ],
  ),
),

      body: Column(
        children: [
          const SizedBox(height: 20),
          const Text(
            'Welcome back!',
            style: TextStyle(fontSize: 24),
          ),
          const SizedBox(height: 20),
          const Text(
            'Please enter your name.',
            style: TextStyle(fontSize: 18),
          ),
          const SizedBox(height: 20),
          // TextField for entering name
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Your Name',
              ),
            ),
          ),
          const SizedBox(height: 20),
          // Continue button
          ElevatedButton.icon(
            onPressed: () {
              // Action when the button is pressed
            },
            icon: const Icon(Icons.arrow_forward, color: Colors.white),
            label: const Text(
              'Continue',
              style: TextStyle(color: Colors.white),
            ),
            style: ElevatedButton.styleFrom(
              primary: const Color(0xFF02677D),
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            ),
          ),
        ],
      ),
    );
  }
}

class CustomProgressBar extends StatelessWidget {
  final int currentIndex;

  const CustomProgressBar({
    Key? key,
    required this.currentIndex,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        for (int i = 0; i < 5; i++)
          _ProgressBarItem(
            isActive: i == currentIndex,
            isLast: i == 4,
          ),
      ],
    );
  }
}

class _ProgressBarItem extends StatelessWidget {
  final bool isActive;
  final bool isLast;

  const _ProgressBarItem({
    Key? key,
    required this.isActive,
    required this.isLast,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 20,
          height: 5,
          decoration: BoxDecoration(
            color: isActive ? const Color(0xFF02677D) : const Color(0xFFC5C5C5),
            borderRadius: BorderRadius.horizontal(
              left: Radius.circular(isLast ? 0 : 2),
              right: Radius.circular(isLast ? 2 : 0),
            ),
          ),
        ),
        if (!isLast) const SizedBox(width: 4),
      ],
    );
  }
}
