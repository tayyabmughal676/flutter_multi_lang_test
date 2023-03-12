// Created by Tayyab Mughal on 12/03/2023.
// Tayyab Mughal
// tayyabmughal676@gmail.com
// © 2022-2023  - All Rights Reserved

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Get the initial locale values
  final String defaultSystemLocale = Platform.localeName;
  final List<Locale> systemLocales = WidgetsBinding.instance.window.locales;

  // Define locales that our app supports (no country codes, see comments below)
  final appSupportedLocales = <Locale>[
    const Locale('ru'),
    const Locale('en'),
  ];

  final MyApp myApp = MyApp(defaultSystemLocale, systemLocales);

  runApp(MaterialApp(
    title: 'MyApp',
    home: myApp,
    supportedLocales: appSupportedLocales,
    localizationsDelegates: const [
      // These are default localization delegates that implement the very basic translations for standard controls and date/time formats.
      GlobalMaterialLocalizations.delegate,
      GlobalWidgetsLocalizations.delegate,
    ],
  ));
}

class MyApp extends StatefulWidget {
  // Store initial locale settings here, they are unchanged
  final String initialDefaultSystemLocale;
  final List<Locale> initialSystemLocales;

  const MyApp(this.initialDefaultSystemLocale, this.initialSystemLocales, {super.key});

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver {
  // Store dynamic changeable locale settings here, they change with the system changes
  late String currentDefaultSystemLocale;
  late List<Locale> currentSystemLocales;

  // Here we read the current locale values
  void setCurrentValues() {
    currentSystemLocales = WidgetsBinding.instance.window.locales;
    currentDefaultSystemLocale = Platform.localeName;
  }

  @override
  void initState() {
    // This is run when the widget is first time initialized
    WidgetsBinding.instance.addObserver(this); // Subscribe to changes
    setCurrentValues();
    super.initState();
  }


  // @override
  // void didChangeLocales(List<Locale> locale) {
  //   // This is run when system locales are changed
  //   super.didChangeLocales(locale);
  //   // Update state with the new values and redraw controls
  //   setState(() {
  //     setCurrentValues();
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Text(
              'Initial system default locale: ${widget.initialDefaultSystemLocale}.'),
          Text(
              'Initial language code: ${widget.initialDefaultSystemLocale.split('_')[0]}, country code: ${widget.initialDefaultSystemLocale.split('_')[1]}.'),
          const Text('Initial system locales:'),
          for (var locale in widget.initialSystemLocales)
            Text(locale.toString()),
          const Text(''),
          Text('Current system default locale: $currentDefaultSystemLocale.'),
          const Text('Current system locales:'),
          for (var locale in currentSystemLocales) Text(locale.toString()),
          const Text(''),
          Text(
              'Selected application locale: ${Localizations.localeOf(context).toString()}.'),
          const Text(''),
          Text(
              'Current date: ${Localizations.of<MaterialLocalizations>(context, MaterialLocalizations)?.formatFullDate(DateTime.now())}.'),
          Text(
              'Current time zone: ${DateTime.now().timeZoneName} (offset ${DateTime.now().timeZoneOffset}).'),
        ],
      ),
    );
  }
}
