import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

AppBar customAppBar(BuildContext context, {actions}) {
  ColorScheme colorTheme = Theme.of(context).colorScheme;
  List<Widget>? actions;

  return AppBar(
    backgroundColor: colorTheme.onPrimary,
    elevation: 0,
    leading: IconButton(
      icon: SvgPicture.asset("assets/icons/hivestock_logo.svg"),
      onPressed: () {},
    ),
    title: const Text("Hivestock"),
    actions: actions,
  );
}
