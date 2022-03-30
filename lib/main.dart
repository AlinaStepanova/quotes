import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:quotes_app/constants.dart';

import 'api/api.dart';
import 'home_page.dart';

Future<void> main() async {
  await API().initDio();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: Constants.appName,
      theme: ThemeData(
        textTheme: TextTheme().apply(
          bodyColor: Constants.textColor,
        ),
        fontFamily: Constants.defaultFontFamily,
        colorScheme: ColorScheme.fromSwatch().copyWith(
            primary: Colors.lightBlueAccent[200], secondary: Colors.lightBlueAccent[200]),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      builder: (context, child) {
        return CupertinoTheme(
          data: CupertinoThemeData(),
          child: Material(child: child),
        );
      },
      home: HomePage(),
    );
  }
}
