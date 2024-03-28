import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hive_stock/App/widgets/buttons.dart';
import 'package:hive_stock/App/widgets/custom_app_bar.dart';
import 'package:hive_stock/App/widgets/custom_progress_bar.dart';
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
              // todo : Swipe the widget base on the index we are or base on a map <"step_name" : widget>
              _Firstname(textTheme: textTheme, colorScheme: colorScheme),
              const Spacer(),
              Align(
                alignment: Alignment.center,
                child: PrimaryButton(
                  text: "Continue",
                  icon: Icons.arrow_forward,
                  onPressed: () => Navigator.of(context).pushNamed(
                    "/LastName",
                  ), // Todo : make the logic work here (may be no a go to but a page index transition)
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class _Firstname extends StatelessWidget {
  const _Firstname({
    super.key,
    required this.textTheme,
    required this.colorScheme,
  });

  final TextTheme textTheme;
  final ColorScheme colorScheme;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Welcome !\nPlease enter your first name.",
          style: textTheme.bodyMedium!.copyWith(color: colorScheme.primary),
        ),
        TextFormField(
          autofocus: true,
          onChanged: (value) =>
              {}, // todo : make the function (not here but in a logic class -> then test the logic class with unit tests)
          decoration: InputDecoration(
            hintText: "Your Firstame",
            hintStyle:
                textTheme.headlineLarge!.copyWith(color: colorScheme.tertiary),
            border: InputBorder.none,
          ),
          cursorColor: colorScheme.tertiary,
          cursorHeight: textTheme.headlineLarge!.fontSize,
          style: textTheme.headlineLarge!.copyWith(color: colorScheme.tertiary),
        )
      ],
    );
  }
}

class _Email extends StatelessWidget {
  const _Email({
    super.key,
    required this.textTheme,
    required this.colorScheme,
  });

  final TextTheme textTheme;
  final ColorScheme colorScheme;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Hello Nina la plus belle 👋\nCan you enter your email ?",
          style: textTheme.bodyMedium!.copyWith(color: colorScheme.primary),
        ),
        TextFormField(
          autofocus: true,
          onChanged: (value) =>
              {}, // todo : make the function (not here but in a logic class -> then test the logic class with unit tests)
          decoration: InputDecoration(
            hintText: "Your email",
            hintStyle:
                textTheme.headlineLarge!.copyWith(color: colorScheme.tertiary),
            border: InputBorder.none,
          ),
          cursorColor: colorScheme.tertiary,
          cursorHeight: textTheme.headlineLarge!.fontSize,
          style: textTheme.headlineLarge!.copyWith(color: colorScheme.tertiary),
        )
      ],
    );
  }
}

class _LastName extends StatelessWidget {
  const _LastName({
    super.key,
    required this.textTheme,
    required this.colorScheme,
  });

  final TextTheme textTheme;
  final ColorScheme colorScheme;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Oh hello  !\nWhat is your last name?",
          style: textTheme.bodyMedium!.copyWith(color: colorScheme.primary),
        ),
        TextFormField(
          autofocus: true,
          onChanged: (value) =>
              {}, // todo : make the function (not here but in a logic class -> then test the logic class with unit tests)
          decoration: InputDecoration(
            hintText: "Your Lastname",
            hintStyle:
                textTheme.headlineLarge!.copyWith(color: colorScheme.tertiary),
            border: InputBorder.none,
          ),
          cursorColor: colorScheme.tertiary,
          cursorHeight: textTheme.headlineLarge!.fontSize,
          style: textTheme.headlineLarge!.copyWith(color: colorScheme.tertiary),
        )
      ],
    );
  }
}

class _birthdayWidget extends StatelessWidget {
  const _birthdayWidget({
    super.key,
    required this.textTheme,
    required this.colorScheme,
  });

  final TextTheme textTheme;
  final ColorScheme colorScheme;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Ho ! You seem to be new here ! \nWhen were you born ?",
          style: textTheme.bodyMedium!.copyWith(color: colorScheme.primary),
        ),
        TextFormField(
          autofocus: true,
          onChanged: (value) =>
              {}, // todo : make the function (not here but in a logic class -> then test the logic class with unit tests)
          decoration: InputDecoration(
            hintText: "DD MM YYYY",
            hintStyle:
                textTheme.headlineLarge!.copyWith(color: colorScheme.tertiary),
            border: InputBorder.none,
          ),
          cursorColor: colorScheme.tertiary,
          cursorHeight: textTheme.headlineLarge!.fontSize,
          style: textTheme.headlineLarge!.copyWith(color: colorScheme.tertiary),
        )
      ],
    );
  }
}
