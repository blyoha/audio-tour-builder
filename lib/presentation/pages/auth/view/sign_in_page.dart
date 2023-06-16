import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

import '../../../../blocs/auth/auth_bloc.dart';
import '../../../../router.dart';
import '../../../../theme/theme.dart';
import '../../../widgets/input_field.dart';

class SignInPage extends StatefulWidget {
  static const String route = 'signIn';

  const SignInPage({Key? key}) : super(key: key);

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
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
      body: BlocConsumer(
        bloc: authBloc,
        listener: (context, state) {
          if (state is AuthAuthenticated) {
            Navigator.pushReplacementNamed(context, AppRouter.homePage);
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
          if (state is AuthUnauthenticated) {
            return Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 24.0,
                vertical: 8.0,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Sing In",
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const Gap(16.0),
                  InputField(
                    controller: email,
                    hint: "Your email",
                  ),
                  const Gap(12.0),
                  InputField(
                    controller: password,
                    hint: "Your password",
                    obscure: true,
                  ),
                  const Gap(16.0),
                  TextButton(
                    onPressed: () {
                      authBloc.add(AuthSignIn(
                        email: email.text,
                        password: password.text,
                      ));
                    },
                    child: const Text('Sign In'),
                  ),
                ],
              ),
            );
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }
}
