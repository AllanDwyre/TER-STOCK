import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hive_stock/utils/constants/customs_icons.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  static Route<void> route() {
    return MaterialPageRoute<void>(builder: (_) => const SplashPage());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SvgPicture.asset(
              CustomIcons.logo,
              height: MediaQuery.sizeOf(context).shortestSide * 0.25,
            ),
            const SizedBox(height: 50),
            const CircularProgressIndicator(
              strokeWidth: 2.0,
            ),
          ],
        ),
      ),
    );
  }
}
