import 'package:flutter/material.dart';
import 'package:hive_stock/utils/constants/padding.dart';

class CardStat extends StatelessWidget {
  const CardStat({
    super.key,
    required this.title,
    required this.titleColor,
    required this.data,
  });

  final String title;
  final Color titleColor;
  final String? data;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    TextTheme textTheme = Theme.of(context).textTheme;
    ColorScheme colorTheme = Theme.of(context).colorScheme;
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(6),
        height: (size.width / 2 - kDefaultPadding) * 0.65,
        margin: const EdgeInsets.all(5),
        decoration: BoxDecoration(
          color: colorTheme.secondaryContainer,
          borderRadius: const BorderRadius.all(Radius.circular(8.0)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(
              child: Center(
                child: Text(
                  title,
                  style: textTheme.titleLarge?.copyWith(color: titleColor),
                ),
              ),
            ),
            Expanded(
              child: Center(
                child: Text(
                  data ?? "-",
                  style:
                      textTheme.titleLarge?.copyWith(color: colorTheme.primary),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CardStatDuo extends StatelessWidget {
  const CardStatDuo({
    super.key,
    required this.title,
    required this.titleColor,
    required this.data,
    required this.data1,
    required this.label,
    required this.label1,
  });

  final String title;
  final Color titleColor;
  final String? data;
  final String? data1;
  final String? label;
  final String? label1;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    TextTheme textTheme = Theme.of(context).textTheme;
    ColorScheme colorTheme = Theme.of(context).colorScheme;
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(6),
        height: (size.width / 2 - kDefaultPadding) * 0.65,
        margin: const EdgeInsets.all(5),
        decoration: BoxDecoration(
          color: colorTheme.secondaryContainer,
          borderRadius: const BorderRadius.all(Radius.circular(8.0)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(
              child: Center(
                child: Text(
                  title,
                  style: textTheme.titleLarge?.copyWith(color: titleColor),
                ),
              ),
            ),
            Expanded(
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      textAlign: TextAlign.center,
                      "$data\n$label",
                      style: textTheme.bodyMedium
                          ?.copyWith(color: colorTheme.primary),
                    ),
                    Text(
                      textAlign: TextAlign.center,
                      "$data\n$label1",
                      style: textTheme.bodyMedium
                          ?.copyWith(color: colorTheme.primary),
                    ),
                  ]),
            ),
          ],
        ),
      ),
    );
  }
}
