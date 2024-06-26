import 'package:flutter/material.dart';
import 'package:hive_stock/home/views/navigation_menu.dart';
import 'package:hive_stock/onBording/views/onbording_page.dart';
import 'package:hive_stock/splash/views/splash_page.dart';
import 'package:hive_stock/authentication/repository/authentication_repository.dart';
import 'package:hive_stock/user/repository/user_repository.dart';
import 'package:hive_stock/utils/app/configuration.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_stock/utils/constants/colors.dart';
import 'package:hive_stock/authentication/bloc/authentication_bloc.dart';

/// app.dart is split into two parts App and AppView.
/// App is responsible for creating/providing the AuthenticationBloc which will be consumed by the AppView.
/// This decoupling will enable us to easily test both the App and AppView widgets later on.
class App extends StatefulWidget {
  const App({super.key});

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
    // _bridgeRepository.
    _authenticationRepository.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //RepositoryProvider is used to provide the single instance of AuthenticationRepository to the entire application which will come in handy later on.
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider.value(
          value: _authenticationRepository,
        ),
      ],
      child: BlocProvider(
        create: (context) => AuthenticationBloc(
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
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // début section test page produit
    var themeData = ThemeData(
      colorScheme: lightColorScheme,
      textTheme: GoogleFonts.urbanistTextTheme(Theme.of(context).textTheme),
    );
    var themeData2 = ThemeData(
      colorScheme: darkColorScheme,
      textTheme: GoogleFonts.urbanistTextTheme(Theme.of(context).textTheme),
    );

    return MaterialApp(
      title: 'HiveStock',
      debugShowCheckedModeBanner: ApiConfiguration.isDebugMode,
      theme: themeData.copyWith(extensions: [lightCustomColors]),
      darkTheme: themeData2.copyWith(extensions: [darkCustomColors]),
      themeMode: ThemeMode.system,
      navigatorKey: _navigatorKey,
      onGenerateRoute: (_) => SplashPage.route(),
      builder: (context, child) {
        return BlocListener<AuthenticationBloc, AuthenticationState>(
          listener: (context, state) {
            switch (state.status) {
              case AuthenticationStatus.authenticated:
                _navigator.pushAndRemoveUntil<void>(
                  NavigationMenu.route(),
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
