import 'package:flutter/material.dart';
import 'package:hive_stock/App/components/buttons.dart';
import 'package:hive_stock/App/components/custom_app_bar.dart';
import 'package:hive_stock/App/constants/padding.dart';

class OnBoardingScreen extends StatelessWidget {
  const OnBoardingScreen({super.key});

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
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: const Color(0xFFEFF4F7)),
                height: 560,
                width: double.infinity,
                child: const _PageViewWidget(),
              ),
              PrimaryButton(
                text: "Get Started",
                icon: Icons.arrow_forward,
                onPressed: () => Navigator.of(context).pushNamed("/login"),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class _PageViewWidget extends StatefulWidget {
  const _PageViewWidget({super.key});

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

  List<Map<String, String>> onbordingData = [
    {
      "path": "assets/on_boarding/image2.png",
      "title": "You're in control",
      "description":
          "Effortlessly track your stock, manage orders, and streamline your operations with ease.",
    },
    {
      "path": "assets/on_boarding/image2.png",
      "title": "Manage your inventory",
      "description":
          "A well-organized warehouse for efficient inventory management.",
    },
    {
      "path": "assets/on_boarding/image3.png",
      "title": "Realtime, everywhere",
      "description": "Streamline Your Inventory, Elevate Your Efficiency.",
    },
    {
      "path": "assets/on_boarding/image4.jpg",
      "title": "Keep it organized",
      "description": "Unlock the Power of Organized Inventory Management.",
    },
    {
      "path": "assets/on_boarding/image4.jpg",
      "title": "Take command",
      "description":
          "Take Command. Unleash efficiency with our advanced barcode scanning.",
    },
    {
      "path": "assets/on_boarding/image4.jpg",
      "title": "From Chaos to Control",
      "description": "Revolutionize Your Inventory Management.",
    }
  ];

  void _onPageChanged(int newPage) {
    setState(() {
      currentIndex = newPage;
    });
  }

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    final ColorScheme colorScheme = Theme.of(context).colorScheme;

    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        PageView.builder(
          controller: _pageController,
          onPageChanged: _onPageChanged,
          itemCount: onbordingData.length,
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
                    onbordingData[index]["path"] ?? "",
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Text(
                onbordingData[index]["title"] ?? "",
                style: textTheme.titleLarge!
                    .copyWith(color: colorScheme.onSurface),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 10),
              Text(
                onbordingData[index]["description"] ?? "",
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
            child: _DotIndicatorWidget(currentIndex, onbordingData.length),
          ),
        ),
      ],
    );
  }
}

class _DotIndicatorWidget extends StatelessWidget {
  const _DotIndicatorWidget(
    this.currentSelectionIndex,
    this.lenght, {
    super.key,
  });
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
