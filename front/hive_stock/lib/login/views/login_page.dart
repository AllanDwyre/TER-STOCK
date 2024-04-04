import 'package:flutter/material.dart';
import 'package:hive_stock/login/views/login_widgets.dart';
import 'package:hive_stock/utils/constants/constants.dart';
import 'package:hive_stock/login/views/login_form.dart';

class UsernamePage extends StatelessWidget {
  const UsernamePage({super.key});

  static Route<void> route() {
    return MaterialPageRoute<void>(builder: (_) => const UsernamePage());
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Padding(
        padding: defaultPagePadding,
        child: LoginForm(
          child: UsernameInput(),
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
    return const Scaffold(
      body: Padding(
        padding: defaultPagePadding,
        child: LoginForm(
          child: OtpInput(),
        ),
      ),
    );
  }
}
