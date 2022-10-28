import 'package:elfaa/constants.dart';
import 'package:elfaa/screens/welcome/welcome.dart';
import 'package:flutter/material.dart';
import 'package:elfaa/alert_dialog.dart';
import 'package:elfaa/screens/profile/changpass_page.dart';
import 'package:flutter/services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluttertoast/fluttertoast.dart';

class EditProfilePage extends StatefulWidget {
  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  String? _name;
  String? _email;
  String? _phoneNumber;
  bool tappedYes = false;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController phoneNo = TextEditingController();

  Future<void> getCurrentUser() async {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    final User? user = await _auth.currentUser;
    final uid = user!.uid;
    await FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .get()
        .then((DocumentSnapshot<Map<String, dynamic>> snapshot) {
      name.text = snapshot['name'];
      email.text = snapshot['email'];
      phoneNo.text = snapshot['phoneNo'].toString();
    });
  }

  Widget _buildName() {
    return Directionality(
        textDirection: TextDirection.rtl,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(10, 8, 10, 8),
          child: TextFormField(
            textAlign: TextAlign.right,
            controller: name,
            decoration: InputDecoration(
                labelText: 'الاسم', hintText: 'أدخل الاسم', helperText: ""),
            validator: (String? value) {
              if (value!.isEmpty) {
                return 'الحقل مطلوب';
              } else if (value.length == 1) {
                return " يجب أن يحتوي الاسم أكثر من حرف على الأقل";
              } else if (!RegExp(
                      r"^[\u0600-\u065F\u066A-\u06EF\u06FA-\u06FFa-zA-Z]+(?:\s[\u0600-\u065F\u066A-\u06EF\u06FA-\u06FFa-zA-Z]+)?$")
                  .hasMatch(value)) {
                return 'أدخل اسم يحتوي على أحرف فقط';
              }
              return null;
            },
            onSaved: (String? value) {
              _name = value;
            },
          ),
        ));
  }

  Widget _buildEmail() {
    return Directionality(
        textDirection: TextDirection.rtl,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(10, 8, 10, 8),
          child: TextFormField(
            textAlign: TextAlign.right,
            controller: email,
            decoration: InputDecoration(
                labelText: 'البريد الإلكتروني',
                hintText: 'أدخل بريدك الإلكتروني',
                helperText: ""),
            validator: (String? value) {
              if (value!.isEmpty) {
                return 'الحقل مطلوب';
              }
              if (!RegExp(
                      r"[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?")
                  .hasMatch(value)) {
                return 'أدخل بريد إلكتروني صالح';
              }
              return null;
            },
            onSaved: (String? value) {
              _email = value!;
            },
          ),
        ));
  }

  Widget _buildPhoneNumber() {
    return Directionality(
        textDirection: TextDirection.rtl,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(10, 8, 10, 8),
          child: TextFormField(
            textAlign: TextAlign.right,
            controller: phoneNo,
            keyboardType: TextInputType.number,
            inputFormatters: <TextInputFormatter>[
              FilteringTextInputFormatter.digitsOnly
            ],
            decoration: InputDecoration(
                labelText: 'رقم الجوال',
                hintText: '05xxxxxxxx',
                helperText: ""),
            validator: (String? value) {
              if (value!.isEmpty) {
                return 'الحقل مطلوب';
              } else if (value.length != 10) {
                return "الرقم ليس مكوّن من 10 خانات";
              } else if (!value.startsWith('05', 0)) {
                return "ادخل رقم جوال يبدأ ب05";
              }
              return null;
            },
            onSaved: (String? value) {
              _phoneNumber = value!;
            },
          ),
        ));
  }

  @override

  // initState()
  void initState() {
    // get current user
    getCurrentUser();
    super.initState();
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is removed from the widget tree.
    name.dispose();
    email.dispose();
    phoneNo.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFfafafa),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        elevation: 0,
        toolbarHeight: 90,
        title: Text(
          "حسابي الشخصي",
          style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
        ),
        centerTitle: true,
        flexibleSpace: Container(
            decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(28),
              bottomRight: Radius.circular(28)),
          color: kPrimaryColor,
        )),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.fromLTRB(24, 24, 24, 100),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(height: 30),
                _buildName(),
                _buildEmail(),
                _buildPhoneNumber(),
                Directionality(
                  textDirection: TextDirection.rtl,
                  child: ElevatedButton.icon(
                    icon: Icon(
                      Icons.edit,
                      color: kPrimaryColor,
                    ),
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStatePropertyAll<Color>(Color(0xFFf5f5f5)),
                      maximumSize: MaterialStateProperty.all(Size(180, 56)),
                      minimumSize: MaterialStateProperty.all(Size(180, 56)),
                      side: MaterialStateProperty.all(
                        BorderSide.lerp(
                            BorderSide(
                              style: BorderStyle.solid,
                              color: kPrimaryColor,
                              width: 1.0,
                            ),
                            BorderSide(
                              style: BorderStyle.solid,
                              color: kPrimaryColor,
                              width: 1.0,
                            ),
                            1.0),
                      ),
                      overlayColor: MaterialStateProperty.resolveWith<Color>(
                        (Set<MaterialState> states) {
                          if (states.contains(MaterialState.hovered))
                            return Color(0xFFBED7DC);
                          return Color(0xFFBED7DC);
                        },
                      ),
                    ),
                    label: Text(
                      '  عدّل معلوماتي   ',
                      style: TextStyle(color: kPrimaryColor, fontSize: 20),
                    ),
                    onPressed: () async {
                      if (!_formKey.currentState!.validate()) {
                        return;
                      }
                      final action2 = await AlertDialogs.yesCancelDialog(
                          context,
                          'تعديل معلومات الحساب الشخصي',
                          'هل أنت متأكد من حفظ التعديل؟');
                      if (action2 == DialogsAction.yes) {
                        setState(() => tappedYes = true);
                        final FirebaseAuth _auth = await FirebaseAuth.instance;
                        final User? user = await _auth.currentUser;
                        final uid = user!.uid;
                        try {
                          await FirebaseFirestore.instance
                              .collection('users')
                              .doc(uid)
                              .update({
                            'name': name.text,
                            'email': email.text,
                            'phoneNo': phoneNo.text,
                          });
                          await user.updateEmail(email.text); 
                          Fluttertoast.showToast(
                              msg: "تم تعديل البيانات بنجاح",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.BOTTOM,
                              timeInSecForIosWeb: 1,
                              backgroundColor: Colors.lightGreen,
                              textColor: Colors.black,
                              fontSize: 16.0);
                        } catch (e) {
                          Fluttertoast.showToast(
                              msg: "حدث خطأ ما",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.BOTTOM,
                              timeInSecForIosWeb: 1,
                              backgroundColor: Colors.red,
                              textColor: Colors.black,
                              fontSize: 16.0);
                        }
                        _formKey.currentState!.save();
                      }
                    },
                  ),
                ),
                SizedBox(height: 20),
                Directionality(
                  textDirection: TextDirection.rtl,
                  child: ElevatedButton.icon(
                    icon: Icon(
                      Icons.lock_reset,
                      color: kPrimaryColor,
                    ),
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStatePropertyAll<Color>(Color(0xFFf5f5f5)),
                      maximumSize: MaterialStateProperty.all(Size(180, 56)),
                      minimumSize: MaterialStateProperty.all(Size(180, 56)),
                      side: MaterialStateProperty.all(
                        BorderSide.lerp(
                            BorderSide(
                              style: BorderStyle.solid,
                              color: kPrimaryColor,
                              width: 1.0,
                            ),
                            BorderSide(
                              style: BorderStyle.solid,
                              color: kPrimaryColor,
                              width: 1.0,
                            ),
                            1.0),
                      ),
                      overlayColor: MaterialStateProperty.resolveWith<Color>(
                        (Set<MaterialState> states) {
                          if (states.contains(MaterialState.hovered))
                            return Color(0xFFBED7DC);
                          return Color(0xFFBED7DC);
                        },
                      ),
                    ),
                    label: Text(
                      'تغيير كلمة المرور',
                      style: TextStyle(color: kPrimaryColor, fontSize: 20),
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return changePasswordPage();
                          },
                        ),
                      );
                    },
                  ),
                ),
                SizedBox(height: 40),
                Directionality(
                  textDirection: TextDirection.rtl,
                  child: ElevatedButton.icon(
                    icon: Icon(
                      Icons.logout,
                      color: Color(0xFF9C0000),
                    ),
                    style: ElevatedButton.styleFrom(
                      textStyle: TextStyle(fontSize: 22),
                      shadowColor: Color.fromARGB(255, 0, 0, 0),
                      elevation: 1,
                      backgroundColor: Colors.white,
                      shape: const StadiumBorder(),
                      maximumSize: const Size(180, 56),
                      minimumSize: const Size(180, 56),
                    ),
                    label: Text(
                      '  تسجيل الخروج    ',
                      style: TextStyle(color: Color(0xFF9C0000), fontSize: 20),
                    ),
                    onPressed: () async {
                      final action = await AlertDialogs.yesCancelDialog(context,
                          'تسجيل الخروج', 'هل أنت متأكد من تسجيل الخروج؟');
                      if (action == DialogsAction.yes) {
                        setState(() => tappedYes = true);
                        FirebaseAuth.instance.signOut();
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => WelcomeScreen()));
                      } else {
                        setState(() => tappedYes = false);
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
