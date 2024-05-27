import 'package:flutter/material.dart';
import 'package:hive_stock/utils/widgets/buttons.dart';

class StatefullButton extends StatelessWidget {
  const StatefullButton(
      {super.key, this.onPressed, this.text, required this.isInProgress});
  final bool isInProgress;
  final VoidCallback? onPressed;
  final String? text;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: isInProgress
          ? const CircularProgressIndicator()
          : PrimaryButton(
              onPressed: onPressed,
              text: text ?? 'Continue',
            ),
    );
  }
}
