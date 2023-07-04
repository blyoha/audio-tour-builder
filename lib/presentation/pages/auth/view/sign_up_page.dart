import 'package:audioTourBuilder/blocs/auth/auth.dart';
import 'package:audioTourBuilder/theme/theme_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

import '../../../../router.dart';
import '../widgets/input_field.dart';

class SignUpPage extends StatefulWidget {
  static const String route = 'signUp';

  const SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  late AuthBloc authBloc;
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();
  final TextEditingController passwordVerified = TextEditingController();

  @override
  void initState() {
    super.initState();
    authBloc = context.read<AuthBloc>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign Up'),
        leading: const BackButton(),
      ),
      body: BlocConsumer<AuthBloc, AuthState>(
        bloc: authBloc,
        listener: (context, state) {
          if (state is AuthAuthenticated) {
            Navigator.pushNamedAndRemoveUntil(
              context,
              AppRouter.homePage,
              (route) => false,
            );
          }
          if (state is AuthError) {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(state.error)));
          }
        },
        builder: (context, state) {
          if (state is AuthLoading) {
            return const Center(
              child: CircularProgressIndicator(color: primaryColor),
            );
          }
          return _buildBody();
        },
      ),
    );
  }

  Widget _buildBody() {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 24.0,
        vertical: 8.0,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _buildInputs(),
          const Gap(48.0),
          TextButton(
            onPressed: () {
              if (password.text != passwordVerified.text) {
                ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Passwords don\'t match')));
                return;
              }
              authBloc.add(AuthSignUp(
                email: email.text.trim(),
                password: password.text,
              ));
            },
            child: const Text('Sign In'),
          ),
        ],
      ),
    );
  }

  Widget _buildInputs() {
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
      const Gap(28.0),
      InputField(
        controller: passwordVerified,
        hint: "Confirm password",
        icon: Icons.lock_outline_rounded,
        obscure: true,
      ),
    ]);
  }
}
