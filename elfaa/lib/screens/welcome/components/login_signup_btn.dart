import 'package:flutter/material.dart';
import '../../../screens/Login/login_screen.dart';
import '../../../screens/signup/signup_screen.dart';
import '../../../../constants.dart';

class LoginAndSignupBtn extends StatelessWidget {
  const LoginAndSignupBtn({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Hero(
          tag: "login_btn",
          child: ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return SignInScreen();
                  },
                ),
              );
            },
            child: Text(
              "تسجيل الدخول",
              style: TextStyle(fontSize: 22),
            ),
          ),
        ),
        const SizedBox(height: 16),
        ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) {
                  return SignupPage();
                },
              ),
            );
          },
         style: ElevatedButton.styleFrom(backgroundColor: kLightColor, elevation: 1),
          child: Text(
            "تسجيل",
           style: TextStyle(color: Colors.black, fontSize: 22),
          ),
        ),
      ],
    );
  }
}
