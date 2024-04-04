import 'package:authentication_repository/authentication_repository.dart';
import 'package:flutter/material.dart';
import 'package:hive_stock/home/views/home_page.dart';
import 'package:hive_stock/onBording/views/onbording_page.dart';
import 'package:hive_stock/splash/views/splash_page.dart';
import 'package:user_repository/user_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_stock/utils/constants/colors.dart';
import 'package:hive_stock/authentication/bloc/authentication_bloc.dart';

/// app.dart is split into two parts App and AppView.
/// App is responsible for creating/providing the AuthenticationBloc which will be consumed by the AppView.
/// This decoupling will enable us to easily test both the App and AppView widgets later on.
class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  late final AuthenticationRepository _authenticationRepository;
  late final UserRepository _userRepository;

  @override
  void initState() {
    super.initState();
    _authenticationRepository = AuthenticationRepository();
    _userRepository = UserRepository();
  }

  @override
  void dispose() {
    _authenticationRepository.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //RepositoryProvider is used to provide the single instance of AuthenticationRepository to the entire application which will come in handy later on.
    return RepositoryProvider.value(
      value: _authenticationRepository,
      child: BlocProvider(
        create: (_) => AuthenticationBloc(
          authenticationRepository: _authenticationRepository,
          userRepository: _userRepository,
        ),
        child: const AppView(),
      ),
    );
  }
}

class AppView extends StatefulWidget {
  const AppView({
    super.key,
  });

  @override
  State<AppView> createState() => _AppViewState();
}

class _AppViewState extends State<AppView> {
  final _navigatorKey = GlobalKey<NavigatorState>();

  NavigatorState get _navigator => _navigatorKey.currentState!;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'HiveStock',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: lightColorScheme,
        textTheme: GoogleFonts.urbanistTextTheme(Theme.of(context).textTheme),
      ).copyWith(extensions: [lightCustomColors]),
      darkTheme: ThemeData(
              colorScheme: darkColorScheme,
              textTheme:
                  GoogleFonts.urbanistTextTheme(Theme.of(context).textTheme))
          .copyWith(extensions: [darkCustomColors]),
      themeMode: ThemeMode.system,
      navigatorKey: _navigatorKey,
      onGenerateRoute: (_) => SplashPage.route(),
      builder: (context, child) {
        return BlocListener<AuthenticationBloc, AuthenticationState>(
          listener: (context, state) {
            switch (state.status) {
              case AuthenticationStatus.authenticated:
                _navigator.pushAndRemoveUntil<void>(
                  HomePage.route(),
                  (route) => false,
                );
              case AuthenticationStatus.unauthenticated:
                _navigator.pushAndRemoveUntil<void>(
                  OnBoardingPage.route(),
                  (route) => false,
                );
              case AuthenticationStatus.unknown:
                break;
            }
          },
          child: child,
        );
      },
    );
  }
}
