import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hive_stock/home/views/home_body.dart';
import 'package:hive_stock/utils/constants/padding.dart';

enum ProfilePage {on, off}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  static Route<void> route() {
    return MaterialPageRoute<void>(builder: (_) => const HomePage());
  }

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  ProfilePage profilePageDisplayed = ProfilePage.off;
  
  @override
  Widget build(BuildContext context) {

    Size size = MediaQuery.of(context).size;
    TextTheme textTheme = Theme.of(context).textTheme;
    ColorScheme colorTheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: colorTheme.onPrimary,
        elevation: 0,
        leading: IconButton(
          icon: SvgPicture.asset("assets/icons/hivestock_logo.svg"),
          onPressed: () {},
        ),
        title:const Text("Hivestock"),
        actions: <Widget>[
          GestureDetector(
            onTap: () {},
            child: Text(
              "Store mode",
              style: textTheme.labelSmall
                  ?.copyWith(color: colorTheme.secondary),
            ),
          ),
          IconButton(
            icon:const Icon(Icons.notifications_none),
            onPressed: () => {},
          ),
          IconButton(
            icon: ClipRRect(
                borderRadius: BorderRadius.circular(30),
                child: Image.asset("./assets/images(for_test)/pdp.png"),
            ),
            iconSize: 50,
            onPressed: () => setState(() {
              profilePageDisplayed = profilePageDisplayed == ProfilePage.on ? ProfilePage.off : ProfilePage.on;
            }),
          ),
          const SizedBox(width: kDefaultPadding / 2),
        ],
      ),
      body: GestureDetector(
        onTap: () {
          if(profilePageDisplayed == ProfilePage.on) {
            setState(() {
              profilePageDisplayed = ProfilePage.off;
            });
          }
        },
        child: HomeBody(profilePageDisplayed: profilePageDisplayed)
        ),
    );
  }
}
