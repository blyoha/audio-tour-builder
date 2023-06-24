import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../blocs/auth/auth_bloc.dart';
import '../../../theme/theme.dart';

class ProfilePage extends StatefulWidget {
  static const String route = 'profile';

  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late AuthBloc bloc;

  @override
  void initState() {
    super.initState();

    bloc = context.read();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
      ),
      body: BlocConsumer(
        bloc: bloc,
        listener: (context, state) {
          if (state is AuthError) {
            ScaffoldMessenger.of(context)
                .showSnackBar(const SnackBar(content: Text('Log Out failed')));
          }
          if (state is AuthUnauthenticated) {
            ScaffoldMessenger.of(context)
                .showSnackBar(const SnackBar(content: Text('Logged Out')));
          }
        },
        builder: (context, state) {
          return Center(
            child: MaterialButton(
              color: AppColors.primary,
              child: const Text('Log Out'),
              onPressed: () {
                if (state is AuthAuthenticated) {
                  bloc.add(AuthSignOut());
                }
              },
            ),
          );
        },
      ),
    );
  }
}
