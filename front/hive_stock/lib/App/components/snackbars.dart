import 'package:flutter/material.dart';

enum SnackbarType { info, warning, error, success }

class Snackbar extends StatelessWidget {
  Snackbar(
      {super.key,
      required this.type,
      required this.description,
      this.title,
      this.showIcon});

  final String? title;
  final bool? showIcon;

  final SnackbarType type;
  final String description;

  final Map<SnackbarType, List<Color>> colorTheme = {
    SnackbarType.info: [Colors.blue, Colors.lightBlue],
    SnackbarType.warning: [Colors.blue, Colors.lightBlue],
    SnackbarType.error: [Colors.blue, Colors.lightBlue],
    SnackbarType.success: [Colors.blue, Colors.lightBlue],
  };

  final Map<SnackbarType, IconData> iconFromType = {
    SnackbarType.info: Icons.info,
    SnackbarType.warning: Icons.error,
    SnackbarType.error: Icons.error,
    SnackbarType.success: Icons.check_circle,
  };

  Color getColorFromType(BuildContext context, bool forText) {
    return colorTheme[type]![forText ? 0 : 1];
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: getColorFromType(context, false),
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      child: Row(
        children: [
          Icon(iconFromType[type]),
          Column(
            children: [if (title != null) Text(title!), Text(description)],
          )
        ],
      ),
    );
  }
}
