import 'package:elfaa/constants.dart';
import 'package:elfaa/screens/welcome/welcome.dart';
//import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:elfaa/alert_dialog.dart';

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

Widget _buildName() {
return  Directionality(
      textDirection: TextDirection.rtl,
      child: TextFormField(
      textAlign: TextAlign.right,
      decoration: InputDecoration(labelText: 'الاسم', hintText: 'أدخل اسمك'),
      maxLength: 10,
      validator: (String? value) {
        if (value!.isEmpty) {
          return 'يجب أن لا يكون الحقل فارغًا';
        }
        return null;
      },
      onSaved: (String? value) {
        _name = value;
      },
    ));
  }

  Widget _buildEmail() {
   return  Directionality(
      textDirection: TextDirection.rtl,
      child: TextFormField(
      textAlign: TextAlign.right,
      decoration: InputDecoration(
          labelText: 'البريد الإلكتروني', hintText: 'أدخل بريدك الإلكتروني'),
      validator: (String? value) {
        if (value!.isEmpty) {
          return 'يجب أن لا يكون الحقل فارغًا';
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
    ));
  }

  Widget _buildPhoneNumber() {
    return  Directionality(
      textDirection: TextDirection.rtl,
      child:  TextFormField(
      textAlign: TextAlign.right,
      decoration:
          InputDecoration(labelText: 'رقم الجوال', hintText: '05xxxxxxxx'),
      keyboardType: TextInputType.phone,
      validator: (String? value) {
        if (value!.isEmpty) {
          return 'يجب أن لا يكون الحقل فارغًا';
        }

        return null;
      },
      onSaved: (String? value) {
        _phoneNumber = value!;
      },
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
                gradient: LinearGradient(
                  colors: [Color(0xFFADCED6), kPrimaryColor],
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                ))),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.all(24),
          child: Form(
            key: _formKey,
              child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(height: 50),
                _buildName(),
                SizedBox(height: 10),
                _buildEmail(),
                SizedBox(height: 30),
                _buildPhoneNumber(),
                SizedBox(height: 100),
                ElevatedButton(
                  child: Text(
                    'حفظ التعديلات',
                    style: TextStyle(color: Colors.white, fontSize: 22),
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
                      shadowColor: Colors.black,
                      elevation: 1,
                      backgroundColor: Colors.white,
                      shape: const StadiumBorder(),
                      maximumSize: const Size(200, 56),
                      minimumSize: const Size(200, 56),
                    ),
                    label: Text(
                      '  تسجيل الخروج    ',
                      style: TextStyle(color: Color(0xFF9C0000), fontSize: 22),
                    ),
                    onPressed: () async {
                      final action = await AlertDialogs.yesCancelDialog(
                          context, 'تسجيل الخروج', 'هل أنت متأكد من تسجيل الخروج؟');
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
