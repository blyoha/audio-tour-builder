import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

import '../../../blocs/auth/auth_bloc.dart';
import '../../../theme/theme_constants.dart';
import '../favorites/view/favorites_page.dart';

class ProfilePage extends StatefulWidget {
  static const String route = 'profile';

  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late AuthBloc authBloc;

  @override
  void initState() {
    super.initState();

    authBloc = context.read<AuthBloc>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0),
        child: Column(
          children: [
            ListTile(
              onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const FavoritesPage(),
                  )),
              title: const Text('Favorite tours'),
              trailing: const Icon(
                Icons.arrow_forward_ios_rounded,
                color: Colors.black,
              ),
            ),
            const Gap(28.0),
            TextButton(
              onPressed: () async => await _logOut(),
              style: const ButtonStyle(
                backgroundColor: MaterialStatePropertyAll<Color>(errorColor),
                foregroundColor: MaterialStatePropertyAll<Color>(Colors.white),
              ),
              child: const Text('Logout'),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _logOut() async {
    await authBloc.authRepo
        .signOut()
        .then((value) => Navigator.pushNamedAndRemoveUntil(
              context,
              'welcome',
              (Route<dynamic> route) => false,
            ));
  }
}
