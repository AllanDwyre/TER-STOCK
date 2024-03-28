import 'package:flutter/material.dart';

class CustomProgressBar extends StatefulWidget {
  final int currentStep;
  final int stepNumber;

  const CustomProgressBar({
    Key? key,
    required this.currentStep,
    required this.stepNumber,
  }) : super(key: key);

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
            child: Container(
              height: 5,
              decoration: BoxDecoration(
                color: i == widget.currentStep
                    ? colorTheme.primary
                    : colorTheme.primaryContainer,
                borderRadius: const BorderRadius.all(Radius.circular(5)),
              ),
            ),
          ),
      ],
    );
  }
}
