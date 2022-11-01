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

class listBox extends StatelessWidget {
  final childrenList _childlist;
  listBox(this._childlist);
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
                padding: EdgeInsets.only(left: 10),
                child: Icon(Icons.arrow_back_ios)),
            Row(
              children: [
                Column(
                  //crossAxisAlignment: CrossAxisAlignment.start,
                  //mainAxisAlignment: MainAxisAlignment.spaceEvenly,

                  children: [
                    Container(
                      padding: EdgeInsets.only(right: 25, top: 10),
                      child: Text(
                        "${_childlist.childName}",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: Color.fromARGB(255, 41, 41, 32)),
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Container(
                      padding: EdgeInsets.only(right: 25),
                      child: Text("${_childlist.zoneName}",
                          style: TextStyle(fontSize: 16, color: Colors.orange)),
                    )
                  ],
                ),
                ClipRRect(
                  borderRadius: BorderRadius.circular(10.0),
                  child: Image.network(
                    "${_childlist.childImagePath}",
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
