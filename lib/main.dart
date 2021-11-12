import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:itg_marvel_task/constants/assets.dart';
import 'package:itg_marvel_task/providers/characters_provider.dart';
import 'package:itg_marvel_task/screens/characters_screen.dart';
import 'package:itg_marvel_task/utils/api.dart';
import 'package:itg_marvel_task/utils/locator.dart';
import 'package:provider/provider.dart';

import 'constants/constants.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  setup();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  runApp(
    EasyLocalization(
        supportedLocales: const [Locale(kEnLanguage)],
        path: kTranslations,
        startLocale: const Locale(kEnLanguage),
        fallbackLocale: const Locale(kEnLanguage),
        child: const MyApp()),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => CharactersProvider(API.kPerPage)),
      ],
      child: MaterialApp(
        localizationsDelegates: context.localizationDelegates,
        debugShowCheckedModeBanner: false,
        supportedLocales: const [Locale(kEnLanguage)],
        locale: const Locale(kEnLanguage),
        title: kAppTitle,
        home: const CharactersScreen(), //splashscreen here
      ),
    );
  }
}
