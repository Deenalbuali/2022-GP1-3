import 'package:elfaa/screens/login/login_screen.dart';
import 'package:elfaa/screens/notificationPage/Notepage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:elfaa/screens/Homepage/Home_page.dart';
import 'package:elfaa/screens/Homepage/navPage.dart';
import 'package:flutter/material.dart';
//import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:elfaa/screens/Welcome/welcome.dart';
import 'constants.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'FirstPage',
      theme: ThemeData(
        primaryColor: kPrimaryColor,
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            shadowColor: Colors.black,
            elevation: 0,
            primary: kPrimaryColor,
            shape: const StadiumBorder(),
            maximumSize: const Size(double.infinity, 56),
            minimumSize: const Size(double.infinity, 56),
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(100.0),
              borderSide: BorderSide(color: Colors.grey.shade300)),
          contentPadding: const EdgeInsets.fromLTRB(20, 12, 20, 12),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(100.0),
              borderSide: BorderSide(color: Colors.grey.shade500, width: 1.5)),
          errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(100.0),
              borderSide: const BorderSide(color: Colors.red, width: 2.0)),
          focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(100.0),
              borderSide: const BorderSide(color: Colors.red, width: 2.0)),
          floatingLabelStyle: const TextStyle(fontSize: 22, color: Colors.blue),
          helperStyle: const TextStyle(fontSize: 14),
        ),
      ),
      home: NavPage(),
    );
  }
}
