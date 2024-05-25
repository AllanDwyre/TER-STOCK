import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

// https://github.com/sooxt98/google_nav_bar/blob/master/example/lib/main_advance.dart

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({super.key, required this.initialTab, this.onTabChange});
  final int initialTab;
  final Function(int)? onTabChange;
  @override
  Widget build(BuildContext context) {
    // TextTheme textTheme = Theme.of(context).textTheme;
    ColorScheme colorTheme = Theme.of(context).colorScheme;

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
          color: colorTheme.primary,
          borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(15), topRight: Radius.circular(15))),
      child: GNav(
        selectedIndex: initialTab,
        onTabChange: onTabChange,
        backgroundColor: colorTheme.primary,
        color: colorTheme.onPrimary,
        activeColor: colorTheme.onPrimary,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        padding: const EdgeInsets.all(20),
        gap: 8,
        tabs: const [
          GButton(
            icon: Icons.home,
            text: "Home",
          ),
          GButton(
            icon: Icons.inventory,
            text: "Inventory",
          ),
          GButton(
            icon: Icons.account_box_rounded,
            text: "Orders",
          ),
          GButton(
            icon: Icons.list,
            text: "Management",
          ),
        ],
      ),
    );
  }
}
