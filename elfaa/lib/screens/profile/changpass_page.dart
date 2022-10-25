import 'package:elfaa/constants.dart';
import 'package:elfaa/screens/login/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';

class changePasswordPage extends StatefulWidget {
  @override
  _changePasswordPageState createState() => _changePasswordPageState();
}

class _changePasswordPageState extends State<changePasswordPage> {
  String? _old;
  String? _new;
  String? _confirmed;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController old = TextEditingController();
  TextEditingController nnew = TextEditingController();
  TextEditingController confirmed = TextEditingController();

  Future<void> updatePassword() async {
    final user = await FirebaseAuth.instance.currentUser;
    final credential = EmailAuthProvider.credential(
        email: user!.email.toString(), password: _old.toString());
    user.reauthenticateWithCredential(credential).then((value) {
      if (_new == _confirmed) {
        user.updatePassword(_new.toString()).then((value) {
          Fluttertoast.showToast(
              msg: "تم تغيير كلمة السر بنجاح",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.green,
              textColor: Colors.white,
              fontSize: 16.0);

          FirebaseAuth.instance.signOut();
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => SignInScreen()));
        }).catchError((error) {
          Fluttertoast.showToast(
              msg: "حدث خطأ ما",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 16.0);
        });
      } else {
        Fluttertoast.showToast(
            msg: "كلمة السر غير متطابقة",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
      }
    }).catchError((error) {
      Fluttertoast.showToast(
          msg: "كلمة السر القديمة غير صحيحة",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    });
  }

  Widget _buildOld() {
    return Directionality(
        textDirection: TextDirection.rtl,
        child: Padding(
            padding: const EdgeInsets.fromLTRB(10, 8, 10, 8),
            child: TextFormField(
              textAlign: TextAlign.right,
              controller: old,
              decoration: InputDecoration(
                  labelText: 'كلمة السر القديمة',
                  hintText: 'أدخل كلمة السر الحالية',
                  helperText: ""),
              validator: (String? value) {
                if (value!.isEmpty) {
                  return 'الحقل مطلوب';
                }
                return null;
              },
              onSaved: (String? value) {
                _old = value;
              },
            )));
  }

  Widget _buildNew() {
    return Directionality(
        textDirection: TextDirection.rtl,
        child: Padding(
            padding: const EdgeInsets.fromLTRB(10, 8, 10, 8),
            child: TextFormField(
              textAlign: TextAlign.right,
              controller: nnew,
              decoration: InputDecoration(
                  labelText: 'كلمة السر الجديدة',
                  hintText: 'أدخل كلمة سر جديدة',
                  helperText: ""),
              validator: (String? value) {
                RegExp regex = RegExp(
                    r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])'); //Min 1 uppercase, 1 lowercase and 1 numeric number
                if (value!.isEmpty || nnew.text.trim() == "") {
                  return "الحقل مطلوب";
                } else if (!regex.hasMatch(value)) {
                  return "كلمة السر يجب أن تحتوي على حرف كبير، حرف صغير، ورقم";
                } else if (value.length < 8) {
                  return "ادخل كلمة سر مكوّنة من 8 خانات على الأقل";
                }
                return null;
              },
              onSaved: (String? value) {
                _new = value;
              },
            )));
  }

  Widget _buildConfirmed() {
    return Directionality(
        textDirection: TextDirection.rtl,
        child: Padding(
            padding: const EdgeInsets.fromLTRB(10, 8, 10, 8),
            child: TextFormField(
              textAlign: TextAlign.right,
              controller: confirmed,
              decoration: InputDecoration(
                  labelText: 'تأكيد كلمة السر الجديدة',
                  hintText: 'أعد إدخال كلمة السر الجديدة',
                  helperText: ""),
              validator: (String? value) {
                if (value!.isEmpty) {
                  return 'الحقل مطلوب';
                }
                return null;
              },
              onSaved: (String? value) {
                _confirmed = value;
              },
            )));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xFFf5f5f5),
        appBar: AppBar(
          automaticallyImplyLeading: true,
          backgroundColor: Colors.transparent,
          elevation: 0,
          toolbarHeight: 90,
          title: Text(
            "تغيير كلمة السر",
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
                  _buildOld(),
                  _buildNew(),
                  _buildConfirmed(),
                  SizedBox(height: 30),
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
                        maximumSize: MaterialStateProperty.all(Size(170, 56)),
                        minimumSize: MaterialStateProperty.all(Size(170, 56)),
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
                        '  حفظ   ',
                        style: TextStyle(color: kPrimaryColor, fontSize: 20),
                      ),
                      onPressed: () {
                        if (!_formKey.currentState!.validate()) {
                          return;
                        }
                        updatePassword();
                        _formKey.currentState!.save();
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
