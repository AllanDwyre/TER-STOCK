import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:hive_stock/App/widgets/custom_progress_bar.dart';
import 'package:hive_stock/_global/constants/constants.dart';
import 'package:hive_stock/_global/widgets/buttons.dart';
import 'package:hive_stock/_global/widgets/custom_app_bar.dart';
import 'package:hive_stock/login/bloc/login_bloc.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginBloc, LoginState>(
      listener: (context, state) {
        if (state.status.isFailure) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              const SnackBar(content: Text('Authentication Failure')),
            );
        }
      },
      child: Padding(
        padding: defaultPagePadding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const CustomProgressBar(
                currentStep: 0, stepNumber: 3), // todo : Rendre Dynamic
            const SizedBox(height: 10),
            const CustomAppBar(smallOne: false),
            const SizedBox(height: 45),
            // todo : Swipe the widget base on the index we are or base on a map <"step_name" : widget>  or using bloc state
            const _BirthdayWidget(),
            const Spacer(),
            Align(
              alignment: Alignment.center,
              child: _LoginButton(),
            )
          ],
        ),
      ),
    );
  }
}

class _UsernameInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      buildWhen: (previous, current) => previous.username != current.username,
      builder: (context, state) {
        return TextField(
          key: const Key('loginForm_usernameInput_textField'),
          onChanged: (username) =>
              context.read<LoginBloc>().add(LoginUsernameChanged(username)),
          decoration: InputDecoration(
            labelText: 'username',
            errorText:
                state.username.displayError != null ? 'invalid username' : null,
          ),
        );
      },
    );
  }
}

class _Firstname extends StatelessWidget {
  const _Firstname();

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    ColorScheme colorScheme = Theme.of(context).colorScheme;
    return BlocBuilder<LoginBloc, LoginState>(
      buildWhen: (previous, current) => previous.username != current.username, // todo : a changer en firstname
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Welcome !\nPlease enter your first name.",
              style: textTheme.bodyMedium!.copyWith(color: colorScheme.primary),
            ),
            TextFormField(
              autofocus: true,
              onChanged: (username) => context.read<LoginBloc>().add(LoginUsernameChanged(username)),
              decoration: InputDecoration(
                hintText: "Your Firstame",
                hintStyle:
                    textTheme.headlineLarge!.copyWith(color: colorScheme.tertiary),
                border: InputBorder.none,
                errorText: state.username.displayError != null ? 'invalid username' : null,
              ),
              cursorColor: colorScheme.tertiary,
              cursorHeight: textTheme.headlineLarge!.fontSize,
              style: textTheme.headlineLarge!.copyWith(color: colorScheme.tertiary),
              
            )
          ],
        );
      },
    );
  }
}

class _LastName extends StatelessWidget {
  const _LastName({
    String? firstName,
  }) : _firstName = firstName;
  final String? _firstName;
  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    ColorScheme colorScheme = Theme.of(context).colorScheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Oh hello $_firstName !\nWhat is your last name?',
          style: textTheme.bodyMedium!.copyWith(color: colorScheme.primary),
        ),
        TextFormField(
          autofocus: true,
          decoration: InputDecoration(
            hintText: "Your Lastname",
            hintStyle:
                textTheme.headlineLarge!.copyWith(color: colorScheme.tertiary),
            border: InputBorder.none,
          ),
          cursorColor: colorScheme.tertiary,
          cursorHeight: textTheme.headlineLarge!.fontSize,
          style: textTheme.headlineLarge!.copyWith(color: colorScheme.tertiary),
        )
      ],
    );
  }
}

class _Email extends StatelessWidget {
  const _Email({
    required this.textTheme,
    required this.colorScheme,
  });

  final TextTheme textTheme;
  final ColorScheme colorScheme;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Hello Nina la plus belle 👋\nCan you enter your email ?",
          style: textTheme.bodyMedium!.copyWith(color: colorScheme.primary),
        ),
        TextFormField(
          autofocus: true,
          decoration: InputDecoration(
            hintText: "Your email",
            hintStyle:
                textTheme.headlineLarge!.copyWith(color: colorScheme.tertiary),
            border: InputBorder.none,
          ),
          cursorColor: colorScheme.tertiary,
          cursorHeight: textTheme.headlineLarge!.fontSize,
          style: textTheme.headlineLarge!.copyWith(color: colorScheme.tertiary),
        )
      ],
    );
  }
}

class _BirthdayWidget extends StatelessWidget {
  const _BirthdayWidget();

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    ColorScheme colorScheme = Theme.of(context).colorScheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Ho ! You seem to be new here ! \nWhen were you born ?",
          style: textTheme.bodyMedium!.copyWith(color: colorScheme.primary),
        ),
        TextFormField(
          keyboardType: TextInputType.datetime,
          autofocus: true,
          // onChanged: _onBirthdayChange, // todo : create the model for this
          decoration: InputDecoration(
            hintText: "DD MM YYYY",
            hintStyle:
                textTheme.headlineLarge!.copyWith(color: colorScheme.tertiary),
            border: InputBorder.none,
          ),
          cursorColor: colorScheme.tertiary,
          cursorHeight: textTheme.headlineLarge!.fontSize,
          style: textTheme.headlineLarge!.copyWith(color: colorScheme.tertiary),
        )
      ],
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
                key: const Key('loginForm_continue_raisedButton'),
                onPressed: state.isValid
                    ? () {
                        context.read<LoginBloc>().add(const LoginSubmitted());
                      }
                    : null,
                text: 'Login',
              );
      },
    );
  }
}
