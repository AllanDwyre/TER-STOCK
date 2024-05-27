import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hive_stock/utils/constants/constants.dart';
import 'package:hive_stock/utils/widgets/custom_appbar.dart';
import 'package:hive_stock/home/home.dart';
import 'package:hive_stock/management/views/management_page.dart';
import 'package:hive_stock/order/views/orders_page.dart';
import 'package:hive_stock/product/views/inventory_page.dart';

abstract class Menu {
  List<Widget>? appBarActions(BuildContext context);
  Widget? floatingButton(BuildContext context);
}

class NavigationMenu extends StatefulWidget {
  const NavigationMenu({super.key});

  static Route<void> route() =>
      MaterialPageRoute<void>(builder: (_) => const NavigationMenu());

  @override
  State<NavigationMenu> createState() => _NavigationMenuState();
}

class _NavigationMenuState extends State<NavigationMenu> {
  late int selectedIndex;

  List<Menu> destinations = const [
    HomePage(),
    InventoryPage(),
    OrdersPage(),
    ManagementPage()
  ];

  @override
  void initState() {
    selectedIndex = 0;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      floatingActionButton: destinations[selectedIndex].floatingButton(context),
      appBar: customAppBar(context,
          actions: destinations[selectedIndex].appBarActions(context)),
      bottomNavigationBar: NavigationBar(
        selectedIndex: selectedIndex,
        onDestinationSelected: onDestinationSelected,
        destinations: [
          NavigationDestination(
              icon: SvgPicture.asset(CustomIcons.home), label: 'Home'),
          NavigationDestination(
              icon: SvgPicture.asset(CustomIcons.product), label: 'Products'),
          NavigationDestination(
              icon: SvgPicture.asset(CustomIcons.order), label: 'Orders'),
          NavigationDestination(
              icon: SvgPicture.asset(CustomIcons.report), label: 'Management'),
        ],
      ),
      body: destinations[selectedIndex] as Widget,
    );
  }

  void onDestinationSelected(int index) {
    setState(() {
      selectedIndex = index;
    });
  }
}
