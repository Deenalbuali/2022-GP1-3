import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:elfaa/constants.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  _ForgotPasswordPageState createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController email = TextEditingController();
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
            "إعادة تعيين كلمة المرور",
            style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: kPrimaryColor),
          ),
          centerTitle: true,
        ),
        body: Container(
            child: SingleChildScrollView(
                child: Form(
                    key: _formKey,
                    child: Padding(
                        padding: EdgeInsets.fromLTRB(20,
                            MediaQuery.of(context).size.height * 0.1, 20, 0),
                        child: Column(
                          children: <Widget>[
                            logoWidget("assets/images/forgot.png"),
                            Text("نسيت كلمة المرور؟",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: kPrimaryColor,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 25)),
                            Text(
                                "الرجاء إدخال البريد الإلكتروني المرتبط بحسابك",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Color.fromARGB(255, 129, 129, 129),
                                    fontSize: 17)),
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
                                    if (value!.isEmpty ||
                                        email.text.trim() == "") {
                                      return "الحقل مطلوب";
                                    } else if (!RegExp(
                                            r"[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?")
                                        .hasMatch(value)) {
                                      return 'أدخل بريد إلكتروني صالح';
                                    }
                                  },
                                )),
                            const SizedBox(height: 40),
                            ElevatedButton(
                              onPressed: () async {
                                if (_formKey.currentState!.validate()) {
                                  resetPassword();
                                }
                              },
                              child: Text("إرسال",
                                  style: TextStyle(color: Colors.white)),
                            ),
                          ],
                        ))))));
  }

  Future resetPassword() async {
    await FirebaseAuth.instance.sendPasswordResetEmail(email: email.text);
    Fluttertoast.showToast(
        msg: "تم إرسال البريد الإلكتروني الخاص بإعادة تعيين كلمة المرور بنجاح",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 7,
        backgroundColor: Colors.lightGreen,
        fontSize: 16.0,
        textColor: Colors.white);
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
}
