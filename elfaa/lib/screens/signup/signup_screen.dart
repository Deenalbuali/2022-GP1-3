import 'package:elfaa/constants.dart';
import 'package:elfaa/screens/Homepage/navPage.dart';
import 'package:elfaa/screens/login/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluttertoast/fluttertoast.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  TextEditingController email = TextEditingController();
  TextEditingController pass = TextEditingController();
  TextEditingController phoneNo = TextEditingController();
  TextEditingController name = TextEditingController();
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
          "تسجيل جديد",
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
                  20, MediaQuery.of(context).size.height * 0.04, 20, 0),
              child: Column(
                children: <Widget>[
                  logoWidget("assets/images/logo1.png"),
                  const SizedBox(height: 40),
                  Directionality(
                      textDirection: TextDirection.rtl,
                      child: TextFormField(
                        textAlign: TextAlign.right,
                        controller: name,
                        decoration: const InputDecoration(
                          suffixIcon:
                              Icon(Icons.person, color: Color(0xFFFD8601)),
                          labelText: "الاسم",
                        ),
                        validator: (value) {
                          if (value!.isEmpty || name.text.trim() == "") {
                            return "الحقل مطلوب";
                          } else if (value.length == 1) {
                            return " يجب أن يحتوي الاسم أكثر من حرف على الأقل";
                          } else if (!RegExp(r"^[a-zA-Z]+$").hasMatch(value)) {
                            return 'أدخل اسم يحتوي على أحرف فقط';
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
                          } else if (!value.startsWith('05', 0)) {
                            return "ادخل رقم جوال يبدأ ب05";
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
                          RegExp regex = RegExp(
                              r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])'); //Min 1 uppercase, 1 lowercase and 1 numeric number
                          if (value!.isEmpty || pass.text.trim() == "") {
                            return "الحقل مطلوب";
                          } else if (!regex.hasMatch(value)) {
                            return "كلمة السر يجب أن تحتوي على حرف كبير، حرف صغير، ورقم";
                          } else if (value.length < 8) {
                            return "ادخل كلمة سر مكوّنة من 8 خانات على الأقل";
                          }
                        },
                      )),
                  const SizedBox(height: 40),
                  ElevatedButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        try {
                          //if all fields are valid , create user
                          await FirebaseAuth.instance
                              .createUserWithEmailAndPassword(
                                  email: email.text, password: pass.text);
                          /*  .then((value) {
                        });*/
                          final user = FirebaseAuth.instance.currentUser!.uid;
                          final userRef = FirebaseFirestore.instance
                              .collection("users")
                              .doc(user);
                          //add user details
                          addUserDetails(name.text.trim(), email.text.trim(),
                              int.parse(phoneNo.text.trim()), user);
                          Fluttertoast.showToast(
                              msg: "تم تسجيل حسابك بنجاح",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.BOTTOM,
                              timeInSecForIosWeb: 3,
                              backgroundColor: Colors.lightGreen,
                              fontSize: 16.0,
                              textColor: Colors.black);
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return SignInScreen();
                              },
                            ),
                          );
                        } catch (e, stack) {
                          Fluttertoast.showToast(
                              msg: "البريد الإلكتروني مستخدم بالفعل",
                              toastLength: Toast.LENGTH_SHORT,
                              backgroundColor: Colors.red,
                              fontSize: 16.0,
                              textColor: Colors.black);
                        }
                      }
                    },
                    child: Text("تسجيل",
                        style: TextStyle(color: Colors.white, fontSize: 22)),
                  ),
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

  Future addUserDetails(
      String firstname, String email, int phoneno, String id) async {
    await FirebaseFirestore.instance.collection('users').doc(id).set(({
          'name': firstname,
          'email': email,
          'phoneNo': phoneno,
          'userID': id,
        }));
  }
}
