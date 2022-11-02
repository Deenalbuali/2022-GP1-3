import 'package:elfaa/screens/Homepage/childrenList.dart';
import 'package:elfaa/screens/Reportpage/reportInfo.dart';
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

class ReportlistBox extends StatelessWidget {
  final childrenList _childlist3;
  ReportlistBox(this._childlist3);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 25.0),
      child: Container(
        decoration: BoxDecoration(boxShadow: [
          BoxShadow(
            color: Colors.grey,
            blurRadius: 10,
            spreadRadius: 1,
          )
        ], color: Colors.white, borderRadius: BorderRadius.circular(12)),
        height: 80,
        padding: EdgeInsets.all(5),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
                decoration: BoxDecoration(
                    color: Colors.orange,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                          color: Colors.orange,
                          offset: Offset(1.0, 1.0),
                          blurRadius: 4.0)
                    ]),
                child: IconButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => reportInfo(
                                childName: "${_childlist3.childName}",
                                childImagePath: "${_childlist3.childImagePath}",
                              )),
                    );
                  },
                  icon: Icon(Icons.content_paste),
                  color: Colors.white,
                )),
            Row(
              children: [
                Column(
                  //crossAxisAlignment: CrossAxisAlignment.start,
                  //mainAxisAlignment: MainAxisAlignment.spaceEvenly,

                  children: [
                    Container(
                      padding: EdgeInsets.only(right: 25, top: 18),
                      child: Text(
                        "${_childlist3.childName}",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: Color.fromARGB(255, 41, 41, 32)),
                      ),
                    ),
                  ],
                ),
                ClipRRect(
                  borderRadius: BorderRadius.circular(10.0),
                  child: Image.network(
                    "${_childlist3.childImagePath}",
                    fit: BoxFit.scaleDown,
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
