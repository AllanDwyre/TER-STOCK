import 'package:flutter/material.dart';
import 'package:hive_stock/home/views/home_body.dart';
import 'package:hive_stock/user/views/profile.dart';
import 'package:hive_stock/utils/constants/padding.dart';
import 'package:hive_stock/utils/widgets/bottom_nav_bar.dart';
import 'package:hive_stock/utils/widgets/custom_appbar.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  static Route<void> route() {
    return MaterialPageRoute<void>(builder: (_) => const HomePage());
  }

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(context),
      body: HomeBody(),
      bottomNavigationBar:
          BottomNavBar(initialTab: 0, onTabChange: onTabChange),
    );
  }

  AppBar _appBar(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    ColorScheme colorTheme = Theme.of(context).colorScheme;
    return customAppBar(
      context,
      actions: <Widget>[
        GestureDetector(
          onTap: () {},
          child: Text(
            "Store mode",
            style: textTheme.labelSmall?.copyWith(color: colorTheme.secondary),
          ),
        ),
        IconButton(
          icon: const Icon(Icons.notifications_none),
          onPressed: () => {},
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
      ],
    );
  }

  onTabChange(int newIndex) {
    setState(() {});
  }
}
