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
    return SizedBox(
        height: size.width / 2 - kDefaultPadding,
        width: size.width / 2 - kDefaultPadding,
        child: Padding(
          padding: const EdgeInsets.all(6),
          child: Container(
            decoration: BoxDecoration(
              color: colorTheme.secondaryContainer,
              borderRadius: const BorderRadius.all(Radius.circular(8.0)),
            ),
            child: Container(
              margin: const EdgeInsets.all(kDefaultPadding / 2),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Expanded(
                    child: Center(
                      child: Text(
                        title,
                        style:
                            textTheme.titleLarge?.copyWith(color: titleColor),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Center(
                      child: Text(
                        data ?? "-",
                        style: textTheme.titleLarge
                            ?.copyWith(color: colorTheme.primary),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
