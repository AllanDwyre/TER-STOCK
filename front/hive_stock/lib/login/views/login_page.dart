import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_stock/login/bloc/login_bloc.dart';
import 'package:hive_stock/login/views/login_widgets.dart';
import 'package:hive_stock/login/views/register_page.dart';
import 'package:hive_stock/utils/constants/constants.dart';
import 'package:hive_stock/login/views/login_form.dart';

class UsernamePage extends StatelessWidget {
  const UsernamePage({super.key});

  static Route<void> route() {
    return MaterialPageRoute<void>(builder: (_) => const UsernamePage());
  }

  @override
  Widget build(BuildContext context) {
    context.read<LoginBloc>().add(const LoginReset());
    return const Scaffold(
      body: Padding(
        padding: defaultPagePadding,
        child: LoginForm(
          step: 1,
          totalStep: 3,
          child: UsernameInput(),
        ),
      ),
    );
  }
}

class EmailPage extends StatelessWidget {
  const EmailPage({super.key});

  static Route<void> route() {
    return MaterialPageRoute<void>(builder: (_) => const EmailPage());
  }

  @override
  Widget build(BuildContext context) {
    context.read<LoginBloc>().add(const LoginReset());
    return BlocListener<LoginBloc, LoginState>(
      listenWhen: (previous, current) =>
          previous.isAttemptingLogin != current.isAttemptingLogin,
      listener: (context, state) {
        debugPrint(state.isAttemptingLogin.toString());
        if (state.isAttemptingLogin!) {
          Navigator.of(context).push<void>(OtpPage.route());
        } else {
          Navigator.of(context).push<void>(BirthdayPage.route());
        }
      },
      child: const Scaffold(
        body: Padding(
          padding: defaultPagePadding,
          child: LoginForm(
            step: 2,
            totalStep: 3,
            child: EmailInput(),
          ),
        ),
      ),
    );
  }
}

class OtpPage extends StatelessWidget {
  const OtpPage({super.key});

  static Route<void> route() {
    return MaterialPageRoute<void>(builder: (_) => const OtpPage());
  }

  @override
  Widget build(BuildContext context) {
    context.read<LoginBloc>().add(const LoginReset());
    return const Scaffold(
      body: Padding(
        padding: defaultPagePadding,
        child: LoginForm(
          step: 3,
          totalStep: 3,
          child: OtpInput(),
        ),
      ),
    );
  }
}
