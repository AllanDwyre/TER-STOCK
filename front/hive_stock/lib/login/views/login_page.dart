import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_stock/login/bloc/login_bloc.dart';
import 'package:hive_stock/login/views/login_form.dart';
import 'package:hive_stock/authentication/repository/authentication_repository.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  static Route<void> route() {
    return MaterialPageRoute<void>(builder: (_) => const LoginPage());
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginBloc(
          authenticationRepository: RepositoryProvider.of<AuthenticationRepository>(context),
      ),
      child: const Scaffold(
        resizeToAvoidBottomInset: false,
        body: LoginBody(),
      ),
    );
  }
}
