import 'package:flutter/material.dart';

class _Email extends StatelessWidget {
  const _Email();

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    ColorScheme colorScheme = Theme.of(context).colorScheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Hello Nina la plus belle 👋\nCan you enter your email ?",
          style: textTheme.bodyMedium!.copyWith(color: colorScheme.primary),
        ),
        TextFormField(
          autofocus: true,
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

class _BirthdayWidget extends StatelessWidget {
  const _BirthdayWidget();

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
          keyboardType: TextInputType.datetime,
          autofocus: true,
          // onChanged: _onBirthdayChange, // todo : create the model for this
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
