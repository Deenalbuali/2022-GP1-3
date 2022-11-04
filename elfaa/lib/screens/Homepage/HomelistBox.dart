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
    final GlobalKey<ScaffoldState> _ScaffoldKey = GlobalKey<ScaffoldState>();
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;
    return Padding(
        padding: const EdgeInsets.only(bottom: 15, left: 18, right: 18, top: 1),
        child: InkWell(
          child: Container(
            decoration: BoxDecoration(boxShadow: [
              BoxShadow(
                color: Colors.grey,
                blurRadius: 10,
                spreadRadius: 1,
              )
            ], color: Colors.white, borderRadius: BorderRadius.circular(12)),
            height: height * 0.1,
            // width: width * 0.00001,
            padding: EdgeInsets.all(5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                    //padding: EdgeInsets.only(left: 10),
                    child: IconButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => viewChild(
                              childID: "${_childlist.childID}",
                              childImage: "${_childlist.childImagePath}",
                              childname: "${_childlist.childName}",
                              childbirthday: "${_childlist.childbirthday}",
                              childHeight: _childlist.childHeight!,
                              childGender: "${_childlist.childGender}")),
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
                          crossAxisAlignment: CrossAxisAlignment.end,
                          //mainAxisAlignment: MainAxisAlignment.spaceEvenly,

                          children: [
                            Container(
                              padding: EdgeInsets.only(
                                  right: width * 0.05,
                                  left: 0.1,
                                  top: 0.1,
                                  bottom: 0.1),
                              child: Text(
                                "${_childlist.childName}",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                    color: Color.fromARGB(255, 41, 41, 32)),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.only(
                                  right: width * 0.05,
                                  left: 0.1,
                                  top: 0.1,
                                  bottom: 0.1),
                              child: Text("منطقة الألعاب",
                                  style: TextStyle(
                                      fontSize: 16, color: Colors.grey)),
                            )
                          ],
                        ),
                        Container(
                          padding: EdgeInsets.all(1),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10.0),
                            child: Image.network(
                              "${_childlist.childImagePath}",
                              fit: BoxFit.cover,
                              width: width * 0.20,
                              height: height * 0.15,
                              
                            ),
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
                      childGender: "${_childlist.childGender}")),
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
