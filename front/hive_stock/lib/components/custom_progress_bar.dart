import 'package:flutter/material.dart';

class CustomProgressBar extends StatelessWidget {
  final int currentIndex;

  const CustomProgressBar({
    Key? key,
    required this.currentIndex,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
          width: 50,
          height: 5,
          decoration:  BoxDecoration(
            color: isActive ? const Color(0xFF02677D) : const Color(0xFFC5C5C5),
            borderRadius: const BorderRadius.all(Radius.circular(5)),
          ),
        ),
        if (!isLast) const SizedBox(width: 4),
      ],
    );
  }
}
