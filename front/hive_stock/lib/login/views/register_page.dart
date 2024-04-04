import 'package:flutter/material.dart';
import 'package:hive_stock/login/views/registration_widgets.dart';
import 'package:hive_stock/utils/constants/constants.dart';
import 'package:hive_stock/login/views/login_form.dart';

class EmailPage extends StatelessWidget {
  const EmailPage({super.key});

  static Route<void> route() {
    return MaterialPageRoute<void>(builder: (_) => const EmailPage());
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Padding(
        padding: defaultPagePadding,
        child: LoginForm(
          child: EmailInput(),
        ),
      ),
    );
  }
}

class BirthdayPage extends StatelessWidget {
  const BirthdayPage({super.key});

  static Route<void> route() {
    return MaterialPageRoute<void>(builder: (_) => const BirthdayPage());
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Padding(
        padding: defaultPagePadding,
        child: LoginForm(
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
    return const Scaffold(
      body: Padding(
        padding: defaultPagePadding,
        child: LoginForm(
          child: PhoneInput(),
        ),
      ),
    );
  }
}
