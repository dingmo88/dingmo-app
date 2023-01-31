import 'package:dingmo/di/service_locator.dart';
import 'package:dingmo/routes/routes.dart';
import 'package:dingmo/ui/main/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

class DingmoApp extends StatefulWidget {
  const DingmoApp({Key? key}) : super(key: key);

  @override
  State<DingmoApp> createState() => _DingmoAppState();
}

class _DingmoAppState extends State<DingmoApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate
        ],
        supportedLocales: const [
          Locale('en', 'US'), // English
          Locale('ko', 'KR')
        ],
        debugShowCheckedModeBanner: false,
        title: 'Dingmo',
        theme: ThemeData(
            scaffoldBackgroundColor: Colors.white,
            primarySwatch: Colors.blue,
            bottomSheetTheme: BottomSheetThemeData(
                backgroundColor: Colors.black.withOpacity(0))),
        home: FutureBuilder(
          future: getIt.allReady(),
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return const HomePage();
            } else {
              return Container(color: Colors.white);
            }
          },
        ),
        onGenerateRoute: (settings) {
          return MaterialPageRoute(
              builder: (context) => Routes.getPage(settings));
        });
  }
}
