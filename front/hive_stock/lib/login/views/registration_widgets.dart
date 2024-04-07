import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:hive_stock/login/bloc/login_bloc.dart';
import 'package:hive_stock/login/views/auth_button.dart';
import 'package:hive_stock/login/views/login_page.dart';
import 'package:hive_stock/login/views/register_page.dart';

class BirthdayInput extends StatefulWidget {
  const BirthdayInput({super.key});

  @override
  State<BirthdayInput> createState() => _BirthdayInputState();
}

class _BirthdayInputState extends State<BirthdayInput> {
  late TextEditingController _controller;

  @override
  void initState() {
    _controller = TextEditingController();
    super.initState();
  }

  String birthdayFormat(String value) {
    value = value.trim();

    if (value.isEmpty) {
      return "";
    }
    String day = value.substring(0, min(2, value.length));
    String month = "";
    String year = "";

    if (value.length > 2) {
      month = value.substring(2, min(4, value.length));
    }
    if (value.length > 4) {
      year = value.substring(4, min(8, value.length));
    }
    return "$day $month $year";
  }

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    ColorScheme colorScheme = Theme.of(context).colorScheme;
    return BlocBuilder<LoginBloc, LoginState>(
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "\nWhen were you born ?",
              style: textTheme.bodyMedium!.copyWith(color: colorScheme.primary),
            ),
            TextFormField(
              controller: _controller,
              keyboardType: TextInputType.datetime,
              autofocus: true,
              onChanged: (birthday) {
                _controller.text = birthdayFormat(birthday);
                context.read<LoginBloc>().add(LoginBirthdayChanged(birthday));
              },
              decoration: InputDecoration(
                hintText: "DD MM YYYY",
                hintStyle: textTheme.headlineLarge!
                    .copyWith(color: colorScheme.tertiary),
                border: InputBorder.none,
              ),
              cursorColor: colorScheme.tertiary,
              cursorHeight: textTheme.headlineLarge!.fontSize,
              style: textTheme.headlineLarge!
                  .copyWith(color: colorScheme.tertiary),
            ),
            const Spacer(),
            AuthButton(
              isInProgress: state.status.isInProgress,
              onPressed: _onPressed(context, state),
            )
          ],
        );
      },
    );
  }

  VoidCallback? _onPressed(BuildContext context, LoginState state) {
    if (!state.isValid) return null;
    return () => Navigator.of(context).push<void>(PhonePage.route());
  }
}

class PhoneInput extends StatelessWidget {
  const PhoneInput({super.key});
//TODO : Change to an actual phone number input (from package)
  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    ColorScheme colorScheme = Theme.of(context).colorScheme;
    return BlocBuilder<LoginBloc, LoginState>(
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "\nCan we get your number ?",
              style: textTheme.bodyMedium!.copyWith(color: colorScheme.primary),
            ),
            TextFormField(
              keyboardType: TextInputType.datetime,
              autofocus: true,
              onChanged: (phone) =>
                  context.read<LoginBloc>().add(LoginPhoneChanged(phone)),
              decoration: InputDecoration(
                hintText: "Your Phone",
                hintStyle: textTheme.headlineLarge!
                    .copyWith(color: colorScheme.tertiary),
                border: InputBorder.none,
              ),
              cursorColor: colorScheme.tertiary,
              cursorHeight: textTheme.headlineLarge!.fontSize,
              style: textTheme.headlineLarge!
                  .copyWith(color: colorScheme.tertiary),
            ),
            const Spacer(),
            AuthButton(
              isInProgress: state.status.isInProgress,
              onPressed: _onPressed(context, state),
            )
          ],
        );
      },
    );
  }

  VoidCallback? _onPressed(BuildContext context, LoginState state) {
    if (!state.isValid) return null;
    return () => Navigator.of(context).push<void>(OtpPage.route());
  }
}
