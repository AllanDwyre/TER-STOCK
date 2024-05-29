import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hive_stock/home/views/home_body.dart';
import 'package:hive_stock/home/views/navigation_menu.dart';
import 'package:hive_stock/scanner/views/scanner_page.dart';
import 'package:hive_stock/user/views/profile.dart';
import 'package:hive_stock/utils/constants/constants.dart';

class HomePage extends StatelessWidget implements Menu {
  const HomePage({super.key});

  @override
  List<Widget> appBarActions(BuildContext context) {
    return <Widget>[
      IconButton(
        icon: SvgPicture.asset(CustomIcons.scan),
        onPressed: () => Navigator.push(context, ScannerScreen.route()),
      ),
      IconButton(
        icon: ClipRRect(
          borderRadius: BorderRadius.circular(30),
          child: Image.asset("./assets/images(for_test)/pdp.png"),
        ),
        iconSize: 50,
        onPressed: () => Navigator.of(context).push(ProfilePage.route()),
      ),
      const SizedBox(width: kDefaultPadding / 2),
    ];
  }

  @override
  Widget? floatingButton(BuildContext context) => null;

  @override
  Widget build(BuildContext context) {
    return const HomeBody();
  }
}
