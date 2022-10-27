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
            "اعادة تعيين كلمة المرور",
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
                            MediaQuery.of(context).size.height * 0.04, 20, 0),
                        child: Column(
                          children: <Widget>[
                            const SizedBox(height: 40),
                            Directionality(
                                textDirection: TextDirection.rtl,
                                child: TextFormField(
                                    textAlign: TextAlign.right,
                                    controller: email,
                                    decoration: const InputDecoration(
                                      suffixIcon: Icon(Icons.email_outlined,
                                          color: Color(0xFFFD8601)),
                                      labelText: "البريد الإلكتروني",
                                      hintText: "example@example.com",
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
                                    })),
                            const SizedBox(height: 30),
                            ElevatedButton(
                              onPressed: () async {
                                if (_formKey.currentState!.validate()) {
                                  resetPassword();
                                }
                              },
                              child: Text("ارسال",
                                  style: TextStyle(color: Colors.white)),
                            ),
                          ],
                        ))))));
  }

  Future resetPassword() async {
    await FirebaseAuth.instance.sendPasswordResetEmail(email: email.text);
    Fluttertoast.showToast(
        msg: "تم ارسال البريد الإلكتروني الخاص باعادة تعيين كلمة المرور بنجاح",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 5,
        backgroundColor: Colors.lightGreen,
        fontSize: 16.0,
        textColor: Colors.white);
  }
}
