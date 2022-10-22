import 'package:flutter/material.dart';
import 'package:elfaa/screens/signup/signup_screen.dart';
import 'package:elfaa/constants.dart';
import 'package:elfaa/screens/Homepage/navPage.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  TextEditingController email = TextEditingController();
  TextEditingController pass = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFf5f5f5),
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: kPrimaryColor,
        ),
        backgroundColor: Color(0xFFFFFFFF),
        elevation: 0,
        title: const Text(
          "تسجيل الدخول",
          style: TextStyle(
              fontSize: 24, fontWeight: FontWeight.bold, color: kPrimaryColor),
        ),
        centerTitle: true,
      ),
      body: Container(
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Padding(
              padding: EdgeInsets.fromLTRB(
                  20, MediaQuery.of(context).size.height * 0.1, 20, 0),
              child: Column(
                children: <Widget>[
                  logoWidget("assets/images/logo1.png"),
                  const SizedBox(height: 50),
                  Directionality(
                      textDirection: TextDirection.rtl,
                      child: TextFormField(
                        textAlign: TextAlign.right,
                        controller: email,
                        decoration: const InputDecoration(
                          suffixIcon: Icon(Icons.email_outlined,
                              color: Color(0xFFFD8601)),
                          labelText: "البريد الإلكتروني",
                        ),
                        validator: (value) {
                          if (value!.isEmpty || email.text.trim() == "") {
                            return "الحقل مطلوب";
                          } else if (!RegExp(
                                  r"[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?")
                              .hasMatch(value)) {
                            return 'أدخل بريد إلكتروني صالح';
                          }
                        },
                      )),
                  const SizedBox(height: 20),
                  Directionality(
                      textDirection: TextDirection.rtl,
                      child: TextFormField(
                        obscureText: true,
                        controller: pass,
                        decoration: const InputDecoration(
                          suffixIcon: Icon(Icons.lock_outline,
                              color: Color(0xFFFD8601)),
                          labelText: "كلمة السر",
                        ),
                        validator: (value) {
                          if (value!.isEmpty || pass.text.trim() == "") {
                            return "الحقل مطلوب";
                          }
                        },
                      )),
                  const SizedBox(height: 50),
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return NavPage();
                            },
                          ),
                        );
                      }
                    },
                    child: Text("تسجيل الدخول",
                        style: TextStyle(color: Colors.white)),
                  ),
                  const SizedBox(height: 10),
                  signUpOption()
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget logoWidget(String imageName) {
    return Center(
        child: Image.asset(
      imageName,
      fit: BoxFit.fill,
      width: 150,
      height: 150,
    ));
  }

  Row signUpOption() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        GestureDetector(
          onTap: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => SignupPage()));
          },
          child: const Text(
            "تسجيل جديد ",
            style: TextStyle(
                fontSize: 17,
                color: Color.fromARGB(255, 129, 129, 129),
                fontWeight: FontWeight.w800),
          ),
        ),
        const Text("ليس لديك حساب؟",
            style: TextStyle(
                fontSize: 17, color: Color.fromARGB(255, 129, 129, 129))),
      ],
    );
  }
}
