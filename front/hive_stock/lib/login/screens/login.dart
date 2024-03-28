import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hive_stock/App/components/buttons.dart';
import 'package:hive_stock/App/components/custom_app_bar.dart';
import 'package:hive_stock/App/components/custom_progress_bar.dart';
import 'package:hive_stock/App/constants/padding.dart';

// ? Ici plusieur question se pose, comment faire cette page, un page view peut etre interressant pour garder les data centralisé.
// ? DE plus il permettera a la progress bar detre maniable facilement
// ? https://docs.flutter.dev/cookbook/forms/validation

// * https://www.youtube.com/shorts/sDcAQNvRD10

class LoginScreen extends StatelessWidget {
  const LoginScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: defaultPagePadding,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const CustomProgressBar(
                  currentStep: 0, stepNumber: 3), // todo : Rendre Dynamic
              const SizedBox(height: 10),
              const CustomAppBar(smallOne: false),
              const SizedBox(height: 45),
              // todo : Split here the widget. To split the repeated widget and personnal ones
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Welcome back!\nPlease enter your first name.",
                    style: textTheme.bodyMedium!
                        .copyWith(color: colorScheme.primary),
                  ),
                  TextFormField(
                    autofocus: true,
                    onChanged: (value) =>
                        {}, // todo : make the function (not here but in a logic class -> then test the logic class with unit tests)
                    decoration: InputDecoration(
                      hintText: "Your Firstame",
                      hintStyle: textTheme.headlineLarge!
                          .copyWith(color: colorScheme.tertiary),
                      border: InputBorder.none,
                    ),
                    cursorColor: colorScheme.tertiary,
                    cursorHeight: textTheme.headlineLarge!.fontSize,
                    style: textTheme.headlineLarge!
                        .copyWith(color: colorScheme.tertiary),
                  )
                ],
              ),
              const Spacer(),
              Align(
                alignment: Alignment.center,
                child: PrimaryButton(
                  text: "Continue",
                  icon: Icons.arrow_forward,
                  onPressed: () => Navigator.of(context).pushNamed(
                      "/login"), // Todo : make the logic work here (may be no a go to but a page index transition)
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
