import 'package:aladl_project/gmap_app/gmap_screen.dart';
import 'package:aladl_project/guess_app/guess_screen.dart';
import 'package:aladl_project/hello_app/hello_screen.dart';
import 'package:aladl_project/quiz_app/quiz_home_screen.dart';
import 'package:aladl_project/toggl_clone_api/time_entry_screen.dart';
import 'package:aladl_project/toggl_clone_api/toggl_home_screen.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  runApp(
      EasyLocalization(
          child: MyApp(),
        supportedLocales: [Locale("en", "US"), Locale("ar", "SA")],
        path: "assets/locales",
        fallbackLocale: Locale("en", "US"),
      )
  );
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.pink,
        accentColor: Colors.deepPurple,
        backgroundColor: Colors.pink,
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            textStyle:
            TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
          ),
        )
      ),
      // home: HelloScreen(),
      // home: GuessScreen(),
      // home: QuizHomeScreen(),
      // home: TogglHomeScreen(),
      home: GMapScreen(),

      routes: {
        TimeEntryScreen.addEntry: (context) => TimeEntryScreen(),
        TogglHomeScreen.routeName: (context) => TogglHomeScreen(),
      },
    );
  }
}
