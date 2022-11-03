import 'package:elfaa/screens/Homepage/childrenList.dart';
import 'package:elfaa/screens/mngChildInfo/veiwChild.dart';
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

class HomelistBox extends StatelessWidget {
  final childrenList _childlist;
  HomelistBox(this._childlist);
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(bottom: 25.0),
        child: InkWell(
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
                    child: IconButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => viewChild(
                                  childID: "${_childlist.childID}",
                                  childImage: "${_childlist.childImagePath}",
                                  childname: "${_childlist.childName}",
                                  childbirthday: "${_childlist.childName}",
                                  childHeight: _childlist.childHeight!,
                                  childGender: "${_childlist.childName}")),
                        );
                      },
                      icon: Icon(Icons.arrow_back_ios),
                      color: Colors.black,
                    )),
                Row(
                  children: [
                    Row(
                      children: [
                        Column(
                          //crossAxisAlignment: CrossAxisAlignment.start,
                          //mainAxisAlignment: MainAxisAlignment.spaceEvenly,

                          children: [
                            Container(
                              padding: EdgeInsets.only(top: 1),
                              child: Text(
                                "${_childlist.childName}",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                    color: Color.fromARGB(255, 41, 41, 32)),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.only(right: 25, top: 5),
                              child: Text("منطقة الألعاب",
                                  style: TextStyle(
                                      fontSize: 16, color: Colors.grey)),
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
              ],
            ),
          ),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => viewChild(
                      childID: "${_childlist.childID}",
                      childImage: "${_childlist.childImagePath}",
                      childname: "${_childlist.childName}",
                      childbirthday: "${_childlist.childbirthday}",
                      childHeight: _childlist.childHeight!,
                      childGender: "${_childlist.childName}")),
            );
          },
        ));
  }
}
//const childrenList({
  //  Key? key,
    //required this.childImagePath,
   // required this.childName,
   // required this.zoneName,
 // }) : super(key: key);
