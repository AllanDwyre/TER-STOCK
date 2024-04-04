import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_stock/_global/widgets/snackbars.dart';
import 'package:hive_stock/login/bloc/login_bloc.dart';
import 'package:otp_text_field/otp_text_field.dart';

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
            )
          ],
        );
      },
    );
  }
}

class OTPInput extends StatelessWidget {
  const OTPInput({super.key}); // ? add a otp controller when sumbit
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
              "Hello ${state.username.value} 👋\nLast step! Enter the unique code we just sent to your email to verify it's really you.",
              style: textTheme.bodyMedium!.copyWith(color: colorScheme.primary),
            ),
            OTPTextField(
              // controller: otpController,
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
            const SizedBox(height: 50),
            CustomSnackbar(
                type: SnackbarType.info,
                showIcon: false,
                description:
                    "Please enter the OTP within the specified time frame to proceed with your login or requested  action. If you haven't received the OTP, you can request for it to be  resent. Thank you for prioritizing the security of your account with us.")
          ],
        );
      },
    );
  }
}
