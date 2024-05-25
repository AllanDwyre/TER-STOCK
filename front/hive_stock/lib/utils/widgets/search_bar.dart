import 'package:flutter/material.dart';

class CustomSearchBar extends StatelessWidget {
  const CustomSearchBar({
    super.key,
    required this.myLabelText,
    required this.myOnChanged,
  });

  final String? myLabelText;
  final Function(String)? myOnChanged;

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    // ColorScheme colorTheme = Theme.of(context).colorScheme;
    return Container(
      height: 40,
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: TextField(
        onChanged: myOnChanged,
        textAlignVertical: TextAlignVertical.center,
        decoration: InputDecoration(
          isCollapsed: true,
          floatingLabelBehavior: FloatingLabelBehavior.never,
          labelStyle: textTheme.labelSmall,
          labelText: myLabelText,
          border: const OutlineInputBorder(),
          prefixIcon: const Icon(Icons.search),
        ),
      ),
    );
  }
}
