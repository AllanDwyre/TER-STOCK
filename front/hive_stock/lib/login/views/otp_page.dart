import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:hive_stock/login/bloc/login_bloc.dart';
import 'package:hive_stock/login/views/auth_button.dart';
import 'package:hive_stock/utils/constants/constants.dart';
import 'package:otp_text_field/otp_text_field.dart';

class OtpPage extends StatelessWidget {
  const OtpPage({super.key});

  static Route<void> route() {
    return MaterialPageRoute<void>(builder: (_) => const OtpPage());
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Padding(
        padding: defaultPagePadding,
        child: OtpInput(),
      ),
    );
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
