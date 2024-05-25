import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_stock/authentication/bloc/authentication_bloc.dart';
import 'package:hive_stock/user/bloc/user_bloc.dart';
import 'package:hive_stock/user/repository/user_repository.dart';
import 'package:hive_stock/utils/widgets/custom_appbar.dart';

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
      appBar: customAppBar(context),
      body: const ProfileBody(),
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
    Size size = MediaQuery.of(context).size;

    return BlocBuilder<UserBloc, UserState>(
      builder: (context, state) {
        return Container(
          width: size.width,
          height: size.height,
          color: const Color.fromARGB(206, 205, 205, 205),
          child: Padding(
            padding: EdgeInsets.only(top: size.height / 6),
            child: Column(
              children: <Widget>[
                Text(
                  "UserID: ${state.user?.id ?? "-"}",
                  style: textTheme.titleLarge?.copyWith(color: Colors.black),
                ),
                const SizedBox(height: 20),
                Text(
                  state.user?.fullname ?? "-",
                  style: textTheme.titleLarge?.copyWith(color: Colors.black),
                ),
                Text(
                  state.user?.username ?? "-",
                  style: textTheme.bodyLarge?.copyWith(color: Colors.black),
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
          ),
        );
      },
    );
  }
}
