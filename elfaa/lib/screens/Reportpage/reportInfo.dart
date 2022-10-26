import 'dart:ffi';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:blurrycontainer/blurrycontainer.dart';
import 'package:blurrycontainer/blurrycontainer.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

//import 'package:firebase_auth/firebase_auth.dart';
//import 'package:firebase_core/firebase_core.dart';
class reportInfo extends StatefulWidget {
  @override
  State<reportInfo> createState() => _reportInfoState();
}

class _reportInfoState extends State<reportInfo> {
//profile image variables
  PickedFile? _imgFile;
  final ImagePicker _picker = ImagePicker();
//information form controllers
  final controllerName = TextEditingController();
  final controllerBirthday = TextEditingController();
  final controllerHeight = TextEditingController();
  final now = DateTime.now();
  final df = new DateFormat('dd-MM-yyyy hh:mm a');
  int myvalue = 1558432747;

  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: const Color(0xFFf5f5f5),
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.transparent,
          elevation: 0,
          toolbarHeight: 90,
          leading: BackButton(color: Colors.white),
          title: Text(
            "تفاصيل البلاغ",
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
          ),
          centerTitle: true,
          flexibleSpace: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(28),
                      bottomRight: Radius.circular(28)),
                  gradient: LinearGradient(
                    colors: [
                      Color(0xFF429EB2),
                      Color.fromARGB(255, 131, 165, 173)
                    ],
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                  ))),
        ),
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.all(10),
            child: Column(
              children: [
                Stack(
                  children: [
                    Container(
                      height: 400,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25),
                          image: DecorationImage(
                              image: AssetImage("assets/images/location.jpeg"),
                              fit: BoxFit.cover)),
                    ),
                    Positioned(
                      top: 320,
                      child: BlurryContainer(
                        padding: EdgeInsets.all(20),
                        height: 140,
                        width: 377,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(30),
                            topRight: Radius.circular(30),
                            bottomLeft: Radius.circular(25)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              children: [
                                SizedBox(
                                  height: 4,
                                ),
                                Container(
                                  height: 37,
                                  width: 120,
                                  child: Center(
                                      child: Text(
                                    "..." "جاري البحث",
                                    style: TextStyle(
                                        color: Color(0xff919296),
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold),
                                  )),
                                  decoration: BoxDecoration(
                                      color: Colors.yellow,
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey,
                                          blurRadius: 10,
                                          spreadRadius: 1,
                                        )
                                      ],
                                      borderRadius: BorderRadius.circular(8)),
                                ),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      "سارة" "   ",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Container(
                                      height: 42,
                                      width: 42,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Image.asset(
                                            "assets/images/sarah.png",
                                            height: 35,
                                          ),
                                          SizedBox(
                                            height: 4,
                                          ),
                                        ],
                                      ),
                                      decoration: BoxDecoration(
                                          color: Color(0xff101419),
                                          borderRadius:
                                              BorderRadius.circular(8)),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        ": " "وقت وتاريخ البلاغ",
                        style: TextStyle(
                          color: Color(0xff919296),
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        ),
                      ),
                      Text(
                        df.format(new DateTime.fromMillisecondsSinceEpoch(
                            myvalue * 1000)),
                        style: TextStyle(
                          color: Color(0xff919296),
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      SizedBox(
                        height: 40,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: 50,
                            width: 150,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.red, // background
                                // foreground
                              ),
                              child: Text(
                                'إلغاء البلاغ',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                ),
                              ),
                              onPressed: () {
                                Navigator.pop(context);
                              },
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      );
}
