import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:new_apta_grading/core/theme/theme_impl.dart';
import 'package:new_apta_grading/features/auth/data/bloc/auth_bloc.dart';
import 'package:new_apta_grading/features/auth/data/cubit/login_c_cubit.dart';
import 'package:new_apta_grading/features/home/data/bloc/home_bloc.dart';
import 'package:new_apta_grading/features/home/data/cubit/home_c_cubit.dart';
import 'package:new_apta_grading/pages.dart';

void main() async {
  const environment = String.fromEnvironment('FLAVOR', defaultValue: 'dev');
  await dotenv.load(fileName: ".$environment.env");

  runApp(MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => AuthBloc()),
        BlocProvider(create: (_) => LoginCCubit()),
        BlocProvider(create: (_) => HomeBloc()),
        BlocProvider(create: (_) => HomeCCubit()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: AppTheme.defaultTheme,
        supportedLocales: const [Locale('id')],
        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        home: const SplashPage(),
      ),
    );
  }
}
