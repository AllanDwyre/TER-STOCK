import 'package:flutter/material.dart';
import 'package:hive_stock/utils/constants/constants.dart';

enum SnackbarType { info, warning, error, success }

class CustomSnackbar extends StatelessWidget {
  CustomSnackbar(
      {super.key,
      required this.type,
      required this.description,
      this.title,
      this.showIcon});

  final String? title;
  final bool? showIcon;

  final SnackbarType type;
  final String description;

  final Map<SnackbarType, IconData> iconFromType = {
    SnackbarType.info: Icons.info,
    SnackbarType.warning: Icons.error,
    SnackbarType.error: Icons.error,
    SnackbarType.success: Icons.check_circle,
  };

  Color getColorFromType(BuildContext context, bool forText) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    final CustomColors colorExtension =
        Theme.of(context).extension<CustomColors>()!;

    Map<SnackbarType, List<Color>> color = {
      SnackbarType.info: [
        colorScheme.onPrimaryContainer,
        colorScheme.primaryContainer
      ],
      SnackbarType.warning: [
        colorExtension.onWarningContainer!,
        colorExtension.warningContainer!
      ],
      SnackbarType.error: [
        colorScheme.onErrorContainer,
        colorScheme.errorContainer
      ],
      SnackbarType.success: [
        colorExtension.onSuccessContainer!,
        colorExtension.successContainer!
      ],
    };
    return color[type]![forText ? 0 : 1];
  }

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: getColorFromType(context, false),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (showIcon ?? true)
            Icon(
              iconFromType[type],
              color: getColorFromType(context, true),
              size: 20,
            ),
          if (showIcon ?? true)
            const SizedBox(
              width: 10,
            ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (title != null)
                  Text(
                    title!,
                    style: textTheme.titleSmall!
                        .copyWith(color: getColorFromType(context, true)),
                  ),
                Text(
                  description,
                  style: textTheme.bodySmall!
                      .copyWith(color: getColorFromType(context, true)),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
