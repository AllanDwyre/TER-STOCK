import 'package:flutter/material.dart';

class CustomTabBar extends StatelessWidget {
  const CustomTabBar({
    super.key,
    required this.tabController,
    required this.tabs,
    this.onTap,
  });

  final TabController tabController;
  final List<Tab> tabs;
  final Function(int)? onTap;
  @override
  Widget build(BuildContext context) {
    ColorScheme colorTheme = Theme.of(context).colorScheme;
    return TabBar(
      controller: tabController,
      labelPadding: const EdgeInsets.symmetric(horizontal: 5),
      labelColor: colorTheme.primary,
      unselectedLabelColor: colorTheme.secondary,
      dividerColor: Colors.transparent,
      onTap: onTap,
      indicator: UnderlineTabIndicator(
          borderSide: BorderSide(color: colorTheme.primary, width: 1)),
      tabs: tabs,
    );
  }
}
