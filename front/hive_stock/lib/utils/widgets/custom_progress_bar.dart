import 'package:flutter/material.dart';

class CustomProgressBar extends StatefulWidget {
  final int currentStep;
  final int stepNumber;

  const CustomProgressBar({
    super.key,
    required this.currentStep,
    required this.stepNumber,
  });

  @override
  State<CustomProgressBar> createState() => _CustomProgressBarState();
}

class _CustomProgressBarState extends State<CustomProgressBar> {
  @override
  Widget build(BuildContext context) {
    final ColorScheme colorTheme = Theme.of(context).colorScheme;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        for (int i = 0; i < widget.stepNumber; i++)
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
              child: Container(
                height: 5,
                decoration: BoxDecoration(
                  color: i <= widget.currentStep
                      ? colorTheme.primary
                      : colorTheme.primaryContainer,
                  borderRadius: const BorderRadius.all(Radius.circular(5)),
                ),
              ),
            ),
          ),
      ],
    );
  }
}
