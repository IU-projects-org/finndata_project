import 'package:finndata_project/screens/login.dart';
import 'package:finndata_project/utils/local_storage_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'bloc/auth/auth_bloc.dart';
import 'bloc/finn/api_cubit.dart';
import 'constants/app_constants.dart';
import 'repos/auth_repo.dart';
import 'repos/finn_api_repo.dart';
import 'screens/home.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await Hive.initFlutter();
  await SettingsStorage().init();
  await StockSubscriptionsStorage().init();
  FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterFatalError;

  // var container = await BlocInjector.create(BlocModule());

  runApp(
    const MyApp(),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    myTheme.addListener(() {
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(create: (_) => AuthRepository()),
        RepositoryProvider(create: (_) => FinnHubAPIRepository()),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider<AuthBloc>(
            create: (context) => AuthBloc(
              authRepository: RepositoryProvider.of<AuthRepository>(context),
            ),
          ),
          BlocProvider<APICubit>(
            create: (context) => APICubit(
              apiRepository:
                  RepositoryProvider.of<FinnHubAPIRepository>(context),
            ),
          ),
        ],
        child: MaterialApp(
          theme: myTheme.currentTheme(),
          debugShowCheckedModeBanner: false,
          home: StreamBuilder<User?>(
              stream: FirebaseAuth.instance.authStateChanges(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return const Home();
                }
                return const LoginScreen();
              }),
        ),
      ),
    );
  }
}
