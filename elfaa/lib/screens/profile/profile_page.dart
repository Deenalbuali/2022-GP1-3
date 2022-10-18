import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class EditProfilePage extends StatefulWidget {
  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
/*
Future<bool> exitDialog() {
  return showDialog(
    context: context,
    builder: (context) -> new AlertDialog(
      title: Text('Are you sure?'),
      content: Text("Do you want to exit from the app? "),
      actions: [
        FlatButton(
          child: Text('EXIT"),
          onPressed: () {},
          ), // FlatButton
          child: Text('CANCEL"),
          onPressed: () {},
          ),
        ],
        ),
  );
}
*/
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        toolbarHeight: 90,
        title:  Text(
                "حسابي الشخصي",
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
              ),
        centerTitle: true,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(bottomLeft: Radius.circular(28), bottomRight: Radius.circular(28)),
            gradient: LinearGradient(
              colors: [Color(0xFFF44336), Colors.pink],
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
            )
          )
        ),
      ),
      body: Container(
        padding: EdgeInsets.only(left: 16, top: 25, right: 16),
         child: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: Column(
            children: [
              SizedBox(
                height: 50,
              ),
              buildTextField("الاسم", "مها"),
              buildTextField("البريد الإلكتروني", "Mahax01@gmail.com"),
              buildTextField("رقم الجوال", "0505058882"),
              SizedBox(
                height: 35,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildTextField(
      String labelText, String placeholder) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 35.0),
      child: TextField(
        decoration: InputDecoration(
            contentPadding: EdgeInsets.only(bottom: 3),
            labelText: labelText,
            floatingLabelBehavior: FloatingLabelBehavior.always,
            hintText: placeholder,
            hintStyle: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            )),
      ),
    );
  }
}
