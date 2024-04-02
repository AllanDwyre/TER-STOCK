import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive_stock/_global/widgets/buttons.dart';
import 'package:hive_stock/_global/widgets/custom_app_bar.dart';
import 'package:hive_stock/_global/widgets/custom_progress_bar.dart';
import 'package:hive_stock/_global/constants/padding.dart';
import 'package:hive_stock/login/models/authentification.dart';

// !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
// !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!! Obselete !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
// !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

// ? Ici plusieur question se pose, comment faire cette page, un page view peut etre interressant pour garder les data centralisé.
// ? DE plus il permettera a la progress bar detre maniable facilement
// ? https://docs.flutter.dev/cookbook/forms/validation

// * https://www.youtube.com/shorts/sDcAQNvRD10
// * https://github.com/felangel/bloc/blob/master/examples/flutter_form_validation/lib/main.dart

class LoginScreen extends StatefulWidget {
  const LoginScreen({
    super.key,
  });

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late Authentification _authentification;
  @override
  void initState() {
    _authentification =
        Authentification(); //? Comment gerer la persistance des données ???
    super.initState();
  }

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
              const _BirthdayWidget(),
              const Spacer(),
              Align(
                alignment: Alignment.center,
                child: PrimaryButton(
                  text: "Continue",
                  icon: Icons.arrow_forward,
                  onPressed: () => Navigator.of(context).pushNamed(
                    "/",
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
          validator: (value) => Authentification.nameValidation(value ?? ""),
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

class _LastName extends StatelessWidget {
  const _LastName({
    String? firstName,
  }) : _firstName = firstName;
  final String? _firstName;
  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    ColorScheme colorScheme = Theme.of(context).colorScheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Oh hello $_firstName !\nWhat is your last name?',
          style: textTheme.bodyMedium!.copyWith(color: colorScheme.primary),
        ),
        TextFormField(
          autofocus: true,
          validator: (value) => Authentification.nameValidation(
              value), // todo : make the function (not here but in a logic class -> then test the logic class with unit tests)
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

class _Email extends StatefulWidget {
  const _Email({
    required this.textTheme,
    required this.colorScheme,
  });

  final TextTheme textTheme;
  final ColorScheme colorScheme;

  @override
  State<_Email> createState() => _EmailState();
}

class _EmailState extends State<_Email> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Hello Nina la plus belle 👋\nCan you enter your email ?",
          style: widget.textTheme.bodyMedium!
              .copyWith(color: widget.colorScheme.primary),
        ),
        TextFormField(
          autofocus: true,
          validator: (value) => Authentification.emailValidation(value),
          decoration: InputDecoration(
            hintText: "Your email",
            hintStyle: widget.textTheme.headlineLarge!
                .copyWith(color: widget.colorScheme.tertiary),
            border: InputBorder.none,
          ),
          cursorColor: widget.colorScheme.tertiary,
          cursorHeight: widget.textTheme.headlineLarge!.fontSize,
          style: widget.textTheme.headlineLarge!
              .copyWith(color: widget.colorScheme.tertiary),
        )
      ],
    );
  }
}

class _BirthdayWidget extends StatefulWidget {
  const _BirthdayWidget();

  @override
  State<_BirthdayWidget> createState() => _BirthdayWidgetState();
}

class _BirthdayWidgetState extends State<_BirthdayWidget> {
  late TextEditingController _brithdayController;
  @override
  void initState() {
    _brithdayController = TextEditingController();
    super.initState();
  }

  void _onBirthdayChange(value) {
    setState(() {
      _brithdayController.text = Authentification.birthdayFormat(value);
    });
  }

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    ColorScheme colorScheme = Theme.of(context).colorScheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Ho ! You seem to be new here ! \nWhen were you born ?",
          style: textTheme.bodyMedium!.copyWith(color: colorScheme.primary),
        ),
        TextFormField(
          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          validator: (value) =>
              Authentification.birthdayValidation(value ?? ""),
          controller: _brithdayController,
          autofocus: true,
          onChanged: _onBirthdayChange,
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
