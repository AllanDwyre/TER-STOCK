import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hive_stock/login/screens/login.dart';
import 'package:hive_stock/login/screens/onbording.dart';

/// This class allows to centralized the logic of routing, and the logic of passing data between page transition.
/// Futhermore, it can handle the logic of the user state (disconnected / connected) and roles, to allow or not the user to access a page.
class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    // getting arguments passed in calling Navigator.pushNamed
    final args = settings.arguments;

    switch (settings.name) {
      case '/':
        // todo : verify the user state and correctyl direct
        return MaterialPageRoute(builder: (_) => const OnBoardingScreen());
      case '/login':
        return MaterialPageRoute(builder: (_) => const LoginScreen());
      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() => MaterialPageRoute(
        builder: (context) => Scaffold(
          appBar: AppBar(
            title: const Text("404 Page"),
          ),
          body: SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SvgPicture.asset("assets/app/page_not_found.svg"),
                const Text(
                  "Oops! Wrong turn!\nBack to safety with the back button or homepage. Happy surfing!",
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      );
}
