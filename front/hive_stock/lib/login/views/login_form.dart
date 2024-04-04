import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:hive_stock/_global/constants/constants.dart';
import 'package:hive_stock/_global/widgets/buttons.dart';
import 'package:hive_stock/_global/widgets/custom_app_bar.dart';
import 'package:hive_stock/login/bloc/login_bloc.dart';

import 'login_widgets.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginBloc, LoginState>(
      listener: (context, state) {
        if (state.status.isFailure) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              const SnackBar(content: Text('Authentication Failure')),
            );
        }
      },
      builder: (context, state) {
        return Padding(
          padding: defaultPagePadding,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              LinearProgressIndicator(
                value: state.step / 2,
                semanticsLabel:
                    'linear progress bar of the authentification steps.',
              ),
              const SizedBox(height: 10),
              const CustomAppBar(smallOne: false),
              const SizedBox(height: 45),
              if (state.step == 0) const UsernameInput(),
              if (state.step == 1) const OTPInput(),
              const Spacer(),
              Align(
                alignment: Alignment.center,
                child: _LoginButton(),
              )
            ],
          ),
        );
      },
    );
  }
}

class _LoginButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      builder: (context, state) {
        return state.status.isInProgress
            ? const CircularProgressIndicator()
            : PrimaryButton(
                // key: const Key('loginForm_continue_raisedButton'),
                onPressed: onPressed(state, context),
                text: 'Continue',
              );
      },
    );
  }

  VoidCallback? onPressed(LoginState state, BuildContext context) {
    if (!state.isValid) return null;
    debugPrint('Current step : ${state.step}');
    if (state.step == 0) {
      // todo : instead of login, just fecth if the user exist and add one to the step, and add to the total step the adequate number if we need to register
      return () =>
          context.read<LoginBloc>().add(const LoginUsernameSubmitted());
    } else {
      return () => context.read<LoginBloc>().add(const LoginSubmitted());
    }
  }
}
