import 'package:elfaa/constants.dart';
import 'package:elfaa/screens/welcome/welcome.dart';
//import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:elfaa/alert_dialog.dart';
import 'package:elfaa/screens/profile/changpass_page.dart';
import 'package:flutter/services.dart';

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

  Widget _buildName() {
    return Directionality(
        textDirection: TextDirection.rtl,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(10, 8, 10, 8),
          child: TextFormField(
            textAlign: TextAlign.right,
            controller: name,
            decoration: InputDecoration(
                labelText: 'الاسم', hintText: 'أدخل اسمك', helperText: ""),
            validator: (String? value) {
              if (value!.isEmpty) {
                return 'الحقل مطلوب';
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
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFf5f5f5),
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
                      maximumSize: MaterialStateProperty.all(Size(200, 56)),
                      minimumSize: MaterialStateProperty.all(Size(200, 56)),
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
                      '  عدل معلوماتي   ',
                      style: TextStyle(color: kPrimaryColor, fontSize: 20),
                    ),
                    onPressed: () {
                      if (!_formKey.currentState!.validate()) {
                        return;
                      }
                      _formKey.currentState!.save();

                      print(_name);
                      print(_email);
                      print(_phoneNumber);
                    },
                  ),
                ),
                SizedBox(height: 30),
                Directionality(
                  textDirection: TextDirection.ltr,
                  child: ElevatedButton.icon(
                    icon: Icon(
                      Icons.lock_reset,
                      color: kPrimaryColor,
                    ),
                    style: ElevatedButton.styleFrom(
                      textStyle: TextStyle(fontSize: 22),
                      elevation: 0.9,
                      shadowColor: Color.fromARGB(255, 0, 0, 0),
                      backgroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0)),
                      maximumSize: Size(320, 56),
                      minimumSize: Size(320, 56),
                    ),
                    label: Text(
                      '                            تغيير كلمة السر',
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
                SizedBox(height: 10),
                Directionality(
                  textDirection: TextDirection.ltr,
                  child: ElevatedButton.icon(
                    icon: Icon(
                      Icons.qr_code,
                      color: kPrimaryColor,
                    ),
                    style: ElevatedButton.styleFrom(
                      textStyle: TextStyle(fontSize: 22),
                      elevation: 0.9,
                      shadowColor: Color.fromARGB(255, 0, 0, 0),
                      backgroundColor: Color.fromARGB(255, 208, 207, 207),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0)),
                      maximumSize: Size(320, 56),
                      minimumSize: Size(320, 56),
                    ),
                    label: Text(
                      ' QR إنشاء رمز الاستجابة السريعة',
                      style: TextStyle(color: kPrimaryColor, fontSize: 20),
                    ),
                    onPressed: () {},
                  ),
                ),
                SizedBox(height: 70),
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
                      maximumSize: const Size(200, 56),
                      minimumSize: const Size(200, 56),
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
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return WelcomeScreen();
                            },
                          ),
                        );
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
