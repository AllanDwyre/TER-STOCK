import 'package:flutter/material.dart';

class MySearchBar extends StatelessWidget {
  const MySearchBar({
    super.key,
    required this.myLabelStyle,
    required this.myLabelText,
    required this.myOnChanged,
    required this.myHeight
  });

  final TextStyle? myLabelStyle;
  final String? myLabelText;
  final Function(String)? myOnChanged;
  final double myHeight;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: myHeight,
      padding: const EdgeInsets.all(30),
      child: TextField(
        onChanged: myOnChanged,
        decoration: InputDecoration(
          labelStyle: myLabelStyle,
          labelText: myLabelText,
          border: const OutlineInputBorder(),
          prefixIcon: const Icon(Icons.search),
        ),
      ),
    );
  }
}