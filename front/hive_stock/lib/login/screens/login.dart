import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Padding(
        padding:  EdgeInsets.symmetric(horizontal: 30.0, vertical: 80.0),
        // child: CustomAppBar(),
      ),
    );
  }
}

class NewWidget extends StatelessWidget {
  const NewWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // const CustomAppBar(),
        const SizedBox(height: 20),
        Text(
          'Welcome back!\nPlease enter your name.',
          style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: Theme.of(context).colorScheme.secondary),
        ),
        const SizedBox(height: 20),
        // TextField for entering name
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
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
            foregroundColor: const Color(0xFF02677D),
            padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          ),
        ),
      ],
    );
  }
}
