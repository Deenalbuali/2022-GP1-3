import 'package:elfaa/screens/Homepage/navPage.dart';
import 'package:elfaa/screens/welcome/welcome.dart';
import 'package:elfaa/screens/mngChildInfo/veiwChild.dart';
import 'package:elfaa/screens/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'constants.dart';

class MyCustomScrollBehavior extends MaterialScrollBehavior {
  // Override behavior methods and getters like dragDevices
  @override
  Set<PointerDeviceKind> get dragDevices => {
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
        // etc.
      };
}

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      scrollBehavior: MyCustomScrollBehavior(),
      debugShowCheckedModeBanner: false,
      title: 'FirstPage',
      theme: ThemeData(
        scaffoldBackgroundColor: Color(0xFFfafafa),
        backgroundColor: Color(0xFFfafafa),
        primaryColor: kPrimaryColor,
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: kPrimaryColor,
            textStyle: TextStyle(fontSize: 22),
            shadowColor: Color.fromARGB(255, 0, 0, 0),
            elevation: 3,
            foregroundColor: Color(0xFFfafafa),
            shape: const StadiumBorder(),
            maximumSize: const Size(250, 56),
            minimumSize: const Size(250, 56),
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          floatingLabelBehavior: FloatingLabelBehavior.always,
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20.0),
              borderSide: BorderSide(color: Colors.grey.shade300)),
          contentPadding: EdgeInsets.all(12),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20.0),
              borderSide: BorderSide(color: Colors.grey.shade500, width: 1.5)),
          errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20.0),
              borderSide: BorderSide(color: Colors.red, width: 2.0)),
          focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20.0),
              borderSide: BorderSide(color: Colors.red, width: 2.0)),
          floatingLabelStyle:
              const TextStyle(fontSize: 22, color: kPrimaryColor),
          helperStyle: TextStyle(fontSize: 14),
          errorStyle: TextStyle(fontSize: 14, color: Colors.red),
          labelStyle: TextStyle(fontSize: 22, color: kPrimaryColor),
          hintStyle: TextStyle(color: Colors.grey),
        ),
      ),
      home: NavPage(),
    );
  }
}
