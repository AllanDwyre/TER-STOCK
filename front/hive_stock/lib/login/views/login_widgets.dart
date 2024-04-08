import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:hive_stock/login/bloc/login_bloc.dart';
import 'package:hive_stock/login/views/login_page.dart';
import 'package:otp_text_field/otp_text_field.dart';

import 'auth_button.dart';

class UsernameInput extends StatelessWidget {
  const UsernameInput({super.key});

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    ColorScheme colorScheme = Theme.of(context).colorScheme;
    return BlocBuilder<LoginBloc, LoginState>(
      buildWhen: (previous, current) => previous.username != current.username,
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Welcome !\nPlease enter your username.",
              style: textTheme.bodyMedium!.copyWith(color: colorScheme.primary),
            ),
            TextFormField(
              autofocus: true,
              initialValue: state.username.value,
              onChanged: (username) =>
                  context.read<LoginBloc>().add(LoginUsernameChanged(username)),
              decoration: InputDecoration(
                hintText: "Your Username",
                hintStyle: textTheme.headlineLarge!
                    .copyWith(color: colorScheme.tertiary),
                border: InputBorder.none,
                errorText: state.username.displayError != null
                    ? 'invalid username ${state.username.displayError}'
                    : null,
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
    return () => Navigator.of(context).push<void>(EmailPage.route());
  }
}

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
              "Hello ${state.username.value} 👋\nPlease enter your email.",
              style: textTheme.bodyMedium!.copyWith(color: colorScheme.primary),
            ),
            TextFormField(
              autofocus: true,
              initialValue: state.email.value,
              onChanged: (email) =>
                  context.read<LoginBloc>().add(LoginEmailChanged(email)),
              decoration: InputDecoration(
                hintText: "Your email",
                hintStyle: textTheme.headlineLarge!
                    .copyWith(color: colorScheme.tertiary),
                border: InputBorder.none,
                errorText: state.username.displayError != null
                    ? 'invalid email ${state.username.displayError}'
                    : null,
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
    return () => context.read<LoginBloc>().add(const LoginAttemptSubmitted());
  }
}

class OtpInput extends StatefulWidget {
  const OtpInput({super.key});
  @override
  State<OtpInput> createState() => _OtpInputState();
}

class _OtpInputState extends State<OtpInput> {
  // ? add a otp controller when sumbit
  late OtpFieldController _controller;

  @override
  void initState() {
    _controller = OtpFieldController();
    super.initState();
  }

  String obstructEmail(String email) {
    String obfuscatedEmail = '';
    int at = email.indexOf('@');
    for (int i = 0; i < email.length; i++) {
      if (i <= at / 2) {
        obfuscatedEmail += '*';
      } else {
        obfuscatedEmail += email[i];
      }
    }
    return obfuscatedEmail;
  }

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    ColorScheme colorScheme = Theme.of(context).colorScheme;
    return BlocBuilder<LoginBloc, LoginState>(
      buildWhen: (previous, current) => previous.otp != current.otp,
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Last step! ${state.username.value} 👋\nEnter the unique code we just sent to ${obstructEmail(state.email.value)}.",
              style: textTheme.bodyMedium!.copyWith(color: colorScheme.primary),
            ),
            OTPTextField(
              controller: _controller,
              length: 6,
              width: MediaQuery.of(context).size.width,
              otpFieldStyle:
                  OtpFieldStyle(focusBorderColor: colorScheme.tertiary),
              fieldWidth: 45,
              style: textTheme.headlineLarge!
                  .copyWith(color: colorScheme.tertiary),
              onChanged: (pin) =>
                  context.read<LoginBloc>().add(LoginOTPChanged(pin)),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Didn't get the opt?",
                  style: textTheme.bodyMedium,
                ),
                TextButton(
                  onPressed: () {},
                  child: Text(
                    'Resend',
                    style: textTheme.bodyMedium?.copyWith(
                      color: colorScheme.primary,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
              ],
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
    return () => context.read<LoginBloc>().add(const LoginSubmitted());
  }
}
