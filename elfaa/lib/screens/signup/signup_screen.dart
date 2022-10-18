import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  TextEditingController email = TextEditingController();
  TextEditingController pass = TextEditingController();
  TextEditingController phoneNo = TextEditingController();
  TextEditingController fname = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFf5f5f5),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          "                                            تسجيل جديد",
          style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Color(0xFFFD8601)),
        ),
      ),
      body: Container(
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Padding(
              padding: EdgeInsets.fromLTRB(
                  20, MediaQuery.of(context).size.height * 0.2, 20, 0),
              child: Column(
                children: <Widget>[
                  Directionality(
                      textDirection: TextDirection.rtl,
                      child: TextFormField(
                        textAlign: TextAlign.right,
                        controller: fname,
                        decoration: const InputDecoration(
                          suffixIcon:
                              Icon(Icons.person, color: Color(0xFFFD8601)),
                          labelText: "الاسم الأول",
                        ),
                        validator: (value) {
                          if (value!.isEmpty || fname.text.trim() == "") {
                            return "الحقل مطلوب";
                          }
                        },
                      )),
                  const SizedBox(height: 20),
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
                          }
                        },
                      )),
                  const SizedBox(height: 20),
                  Directionality(
                      textDirection: TextDirection.rtl,
                      child: TextFormField(
                        textAlign: TextAlign.right,
                        controller: phoneNo,
                        keyboardType: TextInputType.number,
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        decoration: const InputDecoration(
                          suffixIcon: Icon(Icons.phone_callback,
                              color: Color(0xFFFD8601)),
                          labelText: "رقم الجوال",
                          hintText: "05xxxxxxxx",
                        ),
                        validator: (value) {
                          if (value!.isEmpty || phoneNo.text.trim() == "") {
                            return "الحقل مطلوب";
                          } else if (value.length != 10) {
                            return "الرقم ليس مكوّن من 10 خانات";
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
                          if (value!.isEmpty || pass.text.trim() != "") {
                            return "الحقل مطلوب";
                          }
                        },
                      )),
                  const SizedBox(height: 50),
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        //if all fields are valid
                        //add to DB
                      }
                    },
                    child: Text("تسجيل", style: TextStyle(color: Colors.white)),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
