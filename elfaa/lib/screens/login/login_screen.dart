import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:elfaa/screens/signup/signup_screen.dart';
import 'package:elfaa/constants.dart';
import 'package:elfaa/screens/Homepage/navPage.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:elfaa/screens/login/ForgotPasswordPage.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  TextEditingController email = TextEditingController();
  TextEditingController pass = TextEditingController();
  bool obscured = true;
  Icon icon = Icon(Icons.visibility, color: Colors.grey);
  FocusNode focus = FocusNode();

  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFfafafa),
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
                          hintText: "أدخل بريدك الإلكتروني",
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
                        focusNode: focus,
                        onTap: () {
                          FocusScope.of(context).requestFocus(focus);
                        },
                        controller: pass,
                        obscureText: obscured,
                        decoration: InputDecoration(
                          suffixIcon: focus.hasFocus
                              ? IconButton(
                                  icon: icon,
                                  onPressed: () {
                                    setState(() {
                                      obscured = !obscured;
                                      if (obscured == true) {
                                        icon = Icon(Icons.visibility,
                                            color: Colors.grey);
                                      } else {
                                        icon = Icon(Icons.visibility_off,
                                            color: Colors.grey);
                                      }
                                    });
                                  },
                                )
                              : Icon(Icons.lock_outline,
                                  color: Color(0xFFFD8601)),
                          labelText: "كلمة المرور",
                          hintText: "أدخل كلمة المرور",
                        ),
                        validator: (value) {
                          if (value!.isEmpty || pass.text.trim() == "") {
                            return "الحقل مطلوب";
                          }
                        },
                      )),
                  const SizedBox(height: 20),
                  Align(
                    alignment: Alignment(-0.9, 0),
                    child: Container(
                      child: GestureDetector(
                        child: Text('نسيت كلمة المرور؟',
                            style: TextStyle(
                              fontSize: 17,
                              color: Color.fromARGB(255, 129, 129, 129),
                            )),
                        onTap: () =>
                            Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => ForgotPasswordPage(),
                        )),
                      ),
                    ),
                  ),
                  const SizedBox(height: 40),
                  ElevatedButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        try {
                          if (pass.text.length < 8) {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: new Text("تنبية"),
                                  content:
                                      new Text("كلمة المرور المدخلة ضعيفة "),
                                );
                              },
                            );
                          }
                          UserCredential userCredential = await FirebaseAuth
                              .instance
                              .signInWithEmailAndPassword(
                                  email: email.text, password: pass.text);
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return NavPage();
                              },
                            ),
                          );
                        } catch (e, stack) {
                          Fluttertoast.showToast(
                              msg: "البريد الإلكتروني أو كلمة المرور غير صحيحة",
                              toastLength: Toast.LENGTH_SHORT,
                              backgroundColor: Colors.red,
                              fontSize: 16.0,
                              textColor: Colors.black);
                        }
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
