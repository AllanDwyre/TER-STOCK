import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_stock/utils/constants/constants.dart';
import 'package:hive_stock/utils/widgets/custom_app_bar.dart';
import 'package:hive_stock/login/bloc/login_bloc.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({
    super.key,
    required this.child,
  });
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      builder: (context, state) {
        return Padding(
          padding: defaultPagePadding,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              LinearProgressIndicator(
                value: state.step / state.totalStep,
                semanticsLabel:
                    'linear progress bar of the authentification steps.',
              ),
              const SizedBox(height: 10),
              const CustomAppBar(smallOne: false),
              const SizedBox(height: 45),
              Expanded(child: child),
            ],
          ),
        );
      },
    );
  }
}
