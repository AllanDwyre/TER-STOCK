import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_stock/authentication/bloc/authentication_bloc.dart';
import 'package:hive_stock/user/bloc/user_bloc.dart';
import 'package:hive_stock/user/repository/user_repository.dart';
import 'package:hive_stock/utils/app/bridge_repository.dart';
import 'package:hive_stock/utils/constants/constants.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  static Route<void> route() {
    return MaterialPageRoute<void>(builder: (_) => const ProfilePage());
  }

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: RepositoryProvider(
        create: (context) => UserRepository(
            bridge: RepositoryProvider.of<BridgeRepository>(context)),
        child: BlocProvider(
          create: (context) => UserBloc(
            userRepository: RepositoryProvider.of<UserRepository>(context),
          )..add(OnUserFetched()),
          child: const ProfileBody(),
        ),
      ),
    );
  }
}

class ProfileBody extends StatelessWidget {
  const ProfileBody({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    // ColorScheme colorTheme = Theme.of(context).colorScheme;
    TextTheme textTheme = Theme.of(context).textTheme;
    // Size size = MediaQuery.of(context).size;

    return BlocBuilder<UserBloc, UserState>(
      builder: (context, state) {
        return Padding(
          padding: defaultPagePadding,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //image
                  Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.black12,
                    ),
                  ),
                  const SizedBox(width: 20),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 10),
                      Text(
                        state.user?.fullname ?? "-",
                        style:
                            textTheme.titleLarge?.copyWith(color: Colors.black),
                      ),
                      Text(
                        state.user?.username ?? "-",
                        style:
                            textTheme.bodyLarge?.copyWith(color: Colors.black),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Text(
                "UserID: ${state.user?.id ?? "-"}",
                style: textTheme.bodyMedium?.copyWith(color: Colors.black),
              ),
              Text(
                "Birthday: ${state.user?.birthday ?? "-"}",
                style: textTheme.bodyMedium?.copyWith(color: Colors.black),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                child: const Text('Logout'),
                onPressed: () {
                  context
                      .read<AuthenticationBloc>()
                      .add(AuthenticationLogoutRequested());
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
