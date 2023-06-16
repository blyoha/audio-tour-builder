import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'blocs/auth/auth_bloc.dart';
import 'blocs/tours/tours_bloc.dart';
import 'theme/theme.dart';
import 'firebase_options.dart';
import 'repositories/auth_repository.dart';
import 'repositories/tours_repository.dart';
import 'router.dart';
import 'theme/theme_constants.dart';
import 'theme/theme_manager.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  final authRepo = AuthRepositoryImpl();
  final isLogged = await authRepo.isLogged();
  final initRoute = isLogged ? AppRouter.homePage : AppRouter.signInPage;

  runApp(RepositoryProvider.value(
    value: authRepo,
    child: TourBuilderApp(initialRoute: initRoute),
  ));
}

ThemeManager _themeManager = ThemeManager();

class TourBuilderApp extends StatefulWidget {
  final String initialRoute;

  const TourBuilderApp({Key? key, required this.initialRoute})
      : super(key: key);

  @override
  State<TourBuilderApp> createState() => _TourBuilderAppState();
}

class _TourBuilderAppState extends State<TourBuilderApp> {
  late AuthRepositoryImpl _authRepo;

  @override
  void initState() {
    super.initState();
    _authRepo = context.read<AuthRepositoryImpl>();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => AuthBloc(authRepo: _authRepo)),
        BlocProvider(
            create: (context) =>
                ToursBloc(toursRepository: ToursRepositoryImpl())),
      ],
      child: MaterialApp(
        theme: appTheme(),
        onGenerateRoute: AppRouter.onGenerateRoute,
        initialRoute: widget.initialRoute,
      ),
    );
  }
}
