import 'package:authentication_repository/authentication_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_stock/utils/constants/constants.dart';
import 'package:hive_stock/login/bloc/login_bloc.dart';
import 'package:hive_stock/login/views/login_form.dart';
import 'package:hive_stock/register/bloc/register_bloc.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  static Route<void> route() {
    return MaterialPageRoute<void>(builder: (_) => const LoginPage());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: defaultPagePadding,
        child: MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (context) => LoginBloc(
                authenticationRepository:
                    RepositoryProvider.of<AuthenticationRepository>(context),
              ),
            ),
            BlocProvider(
              create: (context) => RegisterBloc(),
            ),
          ],
          child: const LoginForm(),
        ),
      ),
    );
  }
}
