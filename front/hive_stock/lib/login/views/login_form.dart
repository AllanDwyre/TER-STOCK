import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:hive_stock/authentication/authentication.dart';
import 'package:hive_stock/home/views/navigation_menu.dart';
import 'package:hive_stock/login/views/auth_button.dart';
import 'package:hive_stock/utils/constants/constants.dart';
import 'package:hive_stock/utils/widgets/custom_app_bar.dart';
import 'package:hive_stock/login/bloc/login_bloc.dart';
import 'package:hive_stock/utils/widgets/snackbars.dart';

import '../../utils/widgets/form_text_field.dart';

class LoginBody extends StatefulWidget {
  const LoginBody({super.key});

  @override
  State<LoginBody> createState() => _LoginBodyState();
}

class _LoginBodyState extends State<LoginBody> {
  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    ColorScheme colorScheme = Theme.of(context).colorScheme;
    return BlocListener<AuthenticationBloc, AuthenticationState>(
      listener: (context, state) {
        if (state.isAuthentified) {
          Navigator.of(context).pushAndRemoveUntil(
            NavigationMenu.route(),
            (route) => false,
          );
        }
      },
      child: BlocConsumer<LoginBloc, LoginState>(
        listenWhen: (previous, current) => previous.status != current.status,
        listener: (BuildContext context, LoginState state) {
          if (state.status.isFailure) {
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(
                SnackBar(
                    behavior: SnackBarBehavior.floating,
                    backgroundColor: colorScheme.errorContainer,
                    margin: const EdgeInsets.all(20),
                    content: Row(
                      children: [
                        Icon(Icons.error_outline_outlined,
                            color: colorScheme.onErrorContainer),
                        const SizedBox(width: 10),
                        Flexible(
                          child: Text(
                            'Authentication Failure ${state.errorMessage}',
                            style: textTheme.bodyMedium
                                ?.copyWith(color: colorScheme.onErrorContainer),
                          ),
                        ),
                      ],
                    )),
              );
          }
        },
        builder: (context, state) {
          return SafeArea(
            child: Padding(
              padding: defaultPagePadding,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const CustomAppBar(smallOne: false),
                  const SizedBox(height: 30),
                  Text(
                    state.isAttemptingLogin
                        ? 'Welcome back!\nCan you enter your information ?'
                        : 'Welcome!\nCan you enter your information ?',
                    style: textTheme.bodyMedium,
                  ),
                  const SizedBox(height: 20),
                  _Form(),
                  const SizedBox(height: 15),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        state.isAttemptingLogin
                            ? 'Haven’t an account? '
                            : 'Have already an account? ',
                        style: textTheme.bodySmall,
                      ),
                      GestureDetector(
                        onTap: () =>
                            context.read<LoginBloc>().add(const LoginSwitch()),
                        child: Text(
                          state.isAttemptingLogin ? 'Sign up' : 'Sign in',
                          style: textTheme.bodySmall
                              ?.copyWith(color: colorScheme.primary),
                        ),
                      ),
                    ],
                  ),
                  const Spacer(),
                  Visibility(
                    visible: !state.isAttemptingLogin,
                    child: Column(
                      children: [
                        CustomSnackbar(
                          type: SnackbarType.info,
                          description:
                              'By continuing you confirm that you agree to our Privacy Policy and Therm of Service',
                        ),
                        const SizedBox(height: 20),
                      ],
                    ),
                  ),
                  StatefullButton(
                      isInProgress: state.status.isInProgress,
                      onPressed: _onPressed(context, state))
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  VoidCallback? _onPressed(BuildContext context, LoginState state) {
    if (!state.isValid) return null;
    return () => context.read<LoginBloc>().add(const LoginSubmitted());
  }
}

class _Form extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      builder: (BuildContext context, state) {
        return Column(
          children: [
            FormTextField(
              hintText: 'Your Username',
              labelText: 'Username',
              onChanged: (username) => context.read<LoginBloc>().add(
                    LoginUsernameChanged(username),
                  ),
            ),
            const SizedBox(height: 20),
            FormTextField(
              labelText: 'Password',
              hintText: 'Your Password',
              onChanged: (psw) => context.read<LoginBloc>().add(
                    LoginPasswordChanged(psw),
                  ),
              obscureText: true,
            ),
            Visibility(
              visible: !state.isAttemptingLogin,
              child: Column(
                children: [
                  const SizedBox(height: 20),
                  FormTextField(
                    onChanged: (email) =>
                        context.read<LoginBloc>().add(LoginEmailChanged(email)),
                    labelText: 'Email',
                    hintText: 'Your Email',
                  ),
                  const SizedBox(height: 20),
                  FormTextField(
                    onChanged: (birthday) => context
                        .read<LoginBloc>()
                        .add(LoginBirthdayChanged(birthday)),
                    labelText: 'Birthday',
                    hintText: 'Your Birthday',
                  ),
                  const SizedBox(height: 20),
                  FormTextField(
                    onChanged: (phone) =>
                        context.read<LoginBloc>().add(LoginPhoneChanged(phone)),
                    labelText: 'Phone',
                    hintText: 'Your Phone',
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
