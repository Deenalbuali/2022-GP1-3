import 'package:elfaa/screens/Homepage/childrenList.dart';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart' hide TextDirection;
import 'package:elfaa/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';

DateTime now = DateTime.now();
String formattedTime = DateFormat.jm().format(now);
final DateTime now2 = DateTime.now();
final DateFormat formatter = DateFormat('yyyy-MM-dd');
final String formatted = formatter.format(now2);

class NotlistBox extends StatelessWidget {
  final childrenList _childlist2;
  NotlistBox(this._childlist2);
  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> _ScaffoldKey = GlobalKey<ScaffoldState>();
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.only(bottom: 15, left: 15, right: 15, top: 7),
      child: Container(
        height: height * 0.1,
        width: 10,
        decoration: BoxDecoration(boxShadow: [
          BoxShadow(
            color: Colors.grey,
            blurRadius: 10,
            spreadRadius: 1,
          )
        ], color: Colors.white, borderRadius: BorderRadius.circular(12)),
        padding: EdgeInsets.all(5),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 0),
              child: Column(children: [
                Container(
                  padding: EdgeInsets.only(top: 10, bottom: 15),
                  child: Text(".." "تم تحديث الحالة إلى" " :" "جاري البحث عنه",
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey,
                      )),
                ),
                Row(
                  children: [
                    Text(DateFormat.jm().format(now),
                        style: TextStyle(
                          color: Color(0xff919296),
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                        textAlign: TextAlign.left),
                    Text(" | " + formatted,
                        style: TextStyle(
                          color: Color(0xff919296),
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                        textAlign: TextAlign.left),
                  ],
                ),
              ]),
            ),
            Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  //mainAxisAlignment: MainAxisAlignment.spaceEvenly,

                  children: [
                    Container(
                      padding: EdgeInsets.only(
                          right: width * 0.05,
                          left: 0.1,
                          top: width * 0.05,
                          bottom: 0.1),
                      child: Text(
                        "${_childlist2.childName}",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: Color.fromARGB(255, 41, 41, 32)),
                      ),
                    ),
                  ],
                ),
                Container(
                  padding: EdgeInsets.all(1),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10.0),
                    child: Image.network(
                      "${_childlist2.childImagePath}",
                      fit: BoxFit.scaleDown,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
//const childrenList({
  //  Key? key,
    //required this.childImagePath,
   // required this.childName,
   // required this.zoneName,
 // }) : super(key: key);
