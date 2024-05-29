import 'package:flutter/material.dart';

class CustomTableRow extends StatelessWidget {
  const CustomTableRow({
    super.key,
    required this.title,
    required this.value,
  });
  final String title;
  final String value;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    TextTheme textTheme = Theme.of(context).textTheme;
    ColorScheme colorTheme = Theme.of(context).colorScheme;
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
      width: size.width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            title,
            maxLines: 1,
            softWrap: false,
            style: textTheme.titleSmall?.copyWith(color: colorTheme.secondary),
          ),
          Text(
            value,
            style: textTheme.titleSmall?.copyWith(color: colorTheme.secondary),
          ),
        ],
      ),
    );
  }
}
