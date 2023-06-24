import 'package:audioTourBuilder/presentation/pages/auth/view/login_page.dart';
import 'package:audioTourBuilder/presentation/pages/auth/view/sign_up_page.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class WelcomePage extends StatelessWidget {
  static const String route = 'welcome';

  const WelcomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding:
              const EdgeInsets.symmetric(horizontal: 24.0, vertical: 102.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Image.asset(
                'assets/images/logo.png',
                height: 200,
                alignment: Alignment.centerLeft,
              ),
              const Spacer(),
              Text(
                'Welcome to \nCity tour traveler',
                style: Theme.of(context)
                    .textTheme
                    .titleLarge
                    ?.copyWith(fontSize: 34.0),
              ),
              const Gap(14.0),
              Text(
                'Want to get to know a new city? Go through the tour route around or create your own one.',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const Gap(44.0),
              TextButton(
                onPressed: () => Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const LoginPage())),
                child: const Text('Login'),
              ),
              const Gap(12.0),
              TextButton(
                onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const SignUpPage())),
                child: const Text('Sign Up'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
