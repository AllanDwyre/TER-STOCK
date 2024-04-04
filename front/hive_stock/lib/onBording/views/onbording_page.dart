import 'package:flutter/material.dart';
import 'package:hive_stock/utils/constants/constants.dart';
import 'package:hive_stock/utils/widgets/buttons.dart';
import 'package:hive_stock/utils/widgets/custom_app_bar.dart';
import 'package:hive_stock/login/views/login_page.dart';

import '__page_view_widget.dart';

class OnBoardingPage extends StatelessWidget {
  const OnBoardingPage({super.key});

  static Route<void> route() {
    return MaterialPageRoute<void>(builder: (_) => const OnBoardingPage());
  }

  @override
  Widget build(BuildContext context) {
    // final ColorScheme colorTheme = Theme.of(context).colorScheme;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: defaultPagePadding,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const CustomAppBar(
                smallOne: false,
              ),
              const Spacer(
                flex: 2,
              ),
              Expanded(
                flex: 20,
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: const Color(0xFFEFF4F7)),
                  width: double.infinity,
                  child: const PageViewWidget(),
                ),
              ),
              const Spacer(),
              PrimaryButton(
                text: "Get Started",
                icon: Icons.arrow_forward,
                onPressed: () =>
                    Navigator.of(context).push<void>(UsernamePage.route()),
              )
            ],
          ),
        ),
      ),
    );
  }
}
