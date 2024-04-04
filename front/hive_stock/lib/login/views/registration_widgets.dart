import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:hive_stock/login/bloc/login_bloc.dart';
import 'package:hive_stock/login/views/auth_button.dart';
import 'package:hive_stock/login/views/login_page.dart';
import 'package:hive_stock/login/views/register_page.dart';

class EmailInput extends StatelessWidget {
  const EmailInput({super.key});

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
              "Ho ! You seem to be new here !\nPlease enter your email.",
              style: textTheme.bodyMedium!.copyWith(color: colorScheme.primary),
            ),
            TextFormField(
              autofocus: true,
              onChanged: (email) =>
                  context.read<LoginBloc>().add(LoginEmailChanged(email)),
              decoration: InputDecoration(
                hintText: "Your email",
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
    return () => Navigator.of(context).push<void>(BirthdayPage.route());
  }
}

class BirthdayInput extends StatelessWidget {
  const BirthdayInput({super.key});

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
              keyboardType: TextInputType.datetime,
              autofocus: true,
              onChanged: (birthday) =>
                  context.read<LoginBloc>().add(LoginBirthdayChanged(birthday)),
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
