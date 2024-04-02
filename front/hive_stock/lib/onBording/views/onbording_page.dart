import 'package:flutter/material.dart';
import 'package:hive_stock/_global/constants/constants.dart';
import 'package:hive_stock/_global/widgets/buttons.dart';
import 'package:hive_stock/_global/widgets/custom_app_bar.dart';
import 'package:hive_stock/login/views/login_page.dart';
import 'package:hive_stock/onBording/models/onboarding_data.dart';

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
                  child: const _PageViewWidget(),
                ),
              ),
              const Spacer(),
              PrimaryButton(
                text: "Get Started",
                icon: Icons.arrow_forward,
                onPressed: () =>
                    Navigator.of(context).push<void>(LoginPage.route()),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class _PageViewWidget extends StatefulWidget {
  const _PageViewWidget();

  @override
  State<_PageViewWidget> createState() => _PageViewWidgetState();
}

class _PageViewWidgetState extends State<_PageViewWidget>
    with TickerProviderStateMixin {
  late PageController _pageController;
  late int currentIndex = 0;
  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
  }

  void _onPageChanged(int newPage) {
    setState(() {
      currentIndex = newPage;
    });
  }

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    final List<Map<String, String>> onboardingData = OnboardingData.getData();

    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        PageView.builder(
          controller: _pageController,
          onPageChanged: _onPageChanged,
          itemCount: onboardingData.length,
          itemBuilder: (BuildContext context, int index) => Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 35),
            child: Column(children: [
              Expanded(
                flex: 1,
                child: Container(
                  width: double.infinity,
                  height: double.infinity,
                  clipBehavior: Clip.antiAlias,
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(12)),
                  child: Image.asset(
                    onboardingData[index]["path"] ?? "",
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Text(
                onboardingData[index]["title"] ?? "",
                style: textTheme.titleLarge!
                    .copyWith(color: colorScheme.onSurface),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 10),
              Text(
                onboardingData[index]["description"] ?? "",
                style: textTheme.bodyMedium!
                    .copyWith(color: colorScheme.onSurface),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
            ]),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 35),
          child: SizedBox(
            width: 57,
            child: _DotIndicatorWidget(currentIndex, onboardingData.length),
          ),
        ),
      ],
    );
  }
}

class _DotIndicatorWidget extends StatelessWidget {
  const _DotIndicatorWidget(this.currentSelectionIndex, this.lenght);
  final int currentSelectionIndex;
  final int lenght;
  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;

    return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      for (int i = 0; i < lenght; i++)
        Container(
          width: currentSelectionIndex == i ? 5 : 3,
          height: currentSelectionIndex == i ? 5 : 3,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: currentSelectionIndex == i
                ? colorScheme.primary
                : colorScheme.secondary,
          ),
        )
    ]);
  }
}
