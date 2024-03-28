import 'package:flutter/material.dart';
import 'package:hive_stock/App/components/buttons.dart';
import 'package:hive_stock/App/components/custom_app_bar.dart';

class OnBoardingWidget extends StatelessWidget {
	const OnBoardingWidget({super.key});

	@override
	Widget build(BuildContext context) {
		// final ColorScheme colorTheme = Theme.of(context).colorScheme;
		return Scaffold(
			body: Padding(
				padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 40),
				child: Column(
					crossAxisAlignment: CrossAxisAlignment.end,
					mainAxisAlignment: MainAxisAlignment.spaceBetween,
					children: [
						const CustomAppBar(
							smallOne: false,
						),
						Container(
							decoration: BoxDecoration(
									borderRadius: BorderRadius.circular(5),
									color: const Color(0xEDA6B4FF)),
							height: 560,
							width: double.infinity,
							padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 35),
							child: const OnBoardingPageView(),
						),
						const PrimaryButton(
							text: "Next",
							icon: Icons.arrow_forward,
						)
					],
				),
			),
		);
	}
}

class OnBoardingPageView extends StatefulWidget {
	const OnBoardingPageView({super.key});

	@override
	State<OnBoardingPageView> createState() => _OnBoardingPageViewState();
}

class _OnBoardingPageViewState extends State<OnBoardingPageView>
		with TickerProviderStateMixin {
	late PageController _pageController;

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

	@override
Widget build(BuildContext context) {
  final TextTheme textTheme = Theme.of(context).textTheme;
  final screenWidth = MediaQuery.of(context).size.width;
  final imageWidth = screenWidth / 2;

  return SingleChildScrollView(
    scrollDirection: Axis.horizontal,
    child: Row(
      children: onbordingData.map((data) {
        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 10.0),
          width: imageWidth,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.0),
          ),
          child: Column(
            children: [
              Expanded(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20.0),
                  child: Image.asset(
                    data["path"] ?? "",
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Text(
                data["title"] ?? "[Title]",
                style: textTheme.titleLarge,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 10),
              Text(
                data["description"] ?? "[description]",
                style: textTheme.bodyMedium,
                textAlign: TextAlign.center,
              ),
            ],
          ),
        );
      }).toList(),
    ),
  );
}


	void _handlePageViewChanged(int currentPageIndex) {
		setState(() {
			// _currentPageIndex = currentPageIndex;
		});
	}
}
