import 'package:android_app/constants/constants.dart';
import 'package:android_app/hive/adapters.dart';
import 'package:android_app/provider/counter_provider.dart';
import 'package:android_app/provider/database_provider.dart';
import 'package:android_app/provider/top_section_provider.dart';
import 'package:android_app/screens/settings/setting_screen.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:easy_localization_loader/easy_localization_loader.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:provider/provider.dart';

import 'screens/home/home_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await EasyLocalization.ensureInitialized();

  await Hive.initFlutter();
  Hive.registerAdapter(DhikrAdapter());

  runApp(
    EasyLocalization(
      supportedLocales: [Locale('en'), Locale('ru'), Locale('es')],
      assetLoader: CsvAssetLoader(),
      path: 'assets/langs/langs.csv',
      fallbackLocale: const Locale('en'),
      child: const AndroidApp(),
    ),
  );
}

class AndroidApp extends StatelessWidget {
  const AndroidApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => CounterProvider(),
          lazy: false,
        ),
        ChangeNotifierProvider(create: (context) => TopSectionProvider()),
        ChangeNotifierProvider(create: (context) => DatabaseProvider()),
      ],
      child: KeyedSubtree(
        key: ValueKey(context.locale),
        child: MaterialApp.router(
          theme: ThemeData(
            fontFamily: 'Gilroy',
            scaffoldBackgroundColor: greyBg,
            colorScheme: ColorScheme(
              brightness: Brightness.light,
              primary: blue,
              onPrimary: black,
              secondary: black,
              onSecondary: black,
              error: Colors.red,
              onError: Colors.red,
              surface: Colors.white,
              onSurface: black,
            ),
          ),
          localizationsDelegates: context.localizationDelegates,
          supportedLocales: context.supportedLocales,
          locale: context.locale,

          debugShowCheckedModeBanner: false,
          routerConfig: _router,
        ),
      ),
    );
  }
}

final _router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const HomeScreen(),
      routes: [
        GoRoute(
          path: 'settings',
          builder: (context, state) => const SettingScreen(),
        ),
      ],
    ),
  ],
);
