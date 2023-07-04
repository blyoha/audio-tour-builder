import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

import '../../../../blocs/auth/auth_bloc.dart';
import '../../../../router.dart';
import '../../../../theme/theme.dart';
import '../widgets/input_field.dart';
import 'recover_page.dart';

class LoginPage extends StatefulWidget {
  static const String route = 'login';

  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late AuthBloc authBloc;
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();

  @override
  void initState() {
    super.initState();
    authBloc = context.read<AuthBloc>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Text('Sign In'),
        leading: const BackButton(),
      ),
      body: BlocConsumer(
        bloc: authBloc,
        listener: (context, state) {
          if (state is AuthAuthenticated) {
            Navigator.pushNamedAndRemoveUntil(context, AppRouter.homePage, (route) => false,);
          }
          if (state is AuthError) {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(state.error)));
          }
        },
        builder: (context, state) {
          if (state is AuthLoading) {
            return Center(
              child: CircularProgressIndicator(color: AppColors.primary),
            );
          }
          return Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 24.0,
              vertical: 8.0,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildInputs(),
                const Gap(48.0),
                _buildButtons(),
              ],
            ),
          );
        },
      ),
    );
  }

  _buildInputs() {
    return Column(children: [
      InputField(
        controller: email,
        hint: "Your email",
        icon: Icons.email_outlined,
      ),
      const Gap(28.0),
      InputField(
        controller: password,
        hint: "Your password",
        icon: Icons.lock_outline_rounded,
        obscure: true,
      ),
      const Gap(12.0),
      GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const RecoverPage()),
          );
        },
        child: const Text(
          'Forget password?',
          style: TextStyle(
            decoration: TextDecoration.underline,
          ),
        ),
      )
    ]);
  }

  Widget _buildButtons() {
    return TextButton(
      onPressed: () {
        authBloc.add(AuthSignIn(
          email: email.text.trim(),
          password: password.text,
        ));
      },
      child: const Text('Sign In'),
    );
  }
}
