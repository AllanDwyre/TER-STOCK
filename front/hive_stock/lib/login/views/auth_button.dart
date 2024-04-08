import 'package:flutter/material.dart';
import 'package:hive_stock/utils/widgets/buttons.dart';

class AuthButton extends StatelessWidget {
  const AuthButton({super.key, this.onPressed, required this.isInProgress});
  final bool isInProgress;
  final VoidCallback? onPressed;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: isInProgress
          ? const CircularProgressIndicator()
          : PrimaryButton(
              onPressed: onPressed,
              text: 'Continue',
            ),
    );
  }
}
