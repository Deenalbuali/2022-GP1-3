//import 'package:elfaa/screens/login/login_screen.dart';
//import 'package:elfaa/screens/notificationPage/Notepage.dart';
import 'package:elfaa/screens/profile/profile_page.dart';
import 'package:elfaa/screens/welcome/welcome.dart';
import 'package:firebase_core/firebase_core.dart';
//import 'package:elfaa/screens/Homepage/Home_page.dart';
//import 'package:elfaa/screens/Homepage/navPage.dart';
import 'package:flutter/material.dart';
//import 'package:cloud_firestore/cloud_firestore.dart';
//import 'package:elfaa/screens/profile/profile_page.dart';
import 'constants.dart';

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
      debugShowCheckedModeBanner: false,
      title: 'FirstPage',
      theme: ThemeData(
        primaryColor: kPrimaryColor,
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: kPrimaryColor,
            textStyle: TextStyle(fontSize: 22),
            shadowColor: Color.fromARGB(255, 0, 0, 0),
            elevation: 3,
            foregroundColor: Colors.white,
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
      home: WelcomesssuiScreen(),
    );
  }
}
