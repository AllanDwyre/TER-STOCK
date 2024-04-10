import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_stock/login/bloc/login_bloc.dart';
import 'package:hive_stock/login/views/registration_widgets.dart';
import 'package:hive_stock/utils/constants/constants.dart';
import 'package:hive_stock/login/views/login_form.dart';

class BirthdayPage extends StatelessWidget {
  const BirthdayPage({super.key});

  static Route<void> route() {
    return MaterialPageRoute<void>(builder: (_) => const BirthdayPage());
  }

  @override
  Widget build(BuildContext context) {
    context.read<LoginBloc>().add(const LoginReset());
    return const Scaffold(
      body: Padding(
        padding: defaultPagePadding,
        child: LoginForm(
          step: 3,
          totalStep: 5,
          child: PhoneInput(),
        ),
      ),
    );
  }
}

class PhonePage extends StatelessWidget {
  const PhonePage({super.key});

  static Route<void> route() {
    return MaterialPageRoute<void>(builder: (_) => const PhonePage());
  }

  @override
  Widget build(BuildContext context) {
    context.read<LoginBloc>().add(const LoginReset());
    return const Scaffold(
      body: Padding(
        padding: defaultPagePadding,
        child: LoginForm(
          step: 4,
          totalStep: 5,
          child: PhoneInput(),
        ),
      ),
    );
  }
}
