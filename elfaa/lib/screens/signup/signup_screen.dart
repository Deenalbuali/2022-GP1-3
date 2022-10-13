import 'package:flutter/material.dart';
import '../../components/background.dart';
import 'package:flutter/cupertino.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Color(0xFFFFF7EE),
      body: Column(
        children: [
          Container(
            width: w,
            height: h * 0.3,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/images/signupimg.png"),
                    fit: BoxFit.cover)),
          ), //container1
          Container(
            child: Column(
              children: [
                Text(
                  "اهلًا بك",
                  style: TextStyle(fontSize: 70, fontWeight: FontWeight.bold),
                ),
                Text(
                  "سجّل كمستخدم جديد في إلفاء!",
                  style: TextStyle(fontSize: 20, color: Colors.grey[500]),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
