import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:elfaa/screens/Homepage/childrenList.dart';
import 'package:elfaa/screens/notificationPage/noteList.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'dart:ui' as ui;

class NotlistBox extends StatefulWidget {
  final childrenList _childrenList;
  final noteList _childrenNote;
  NotlistBox(this._childrenList, this._childrenNote);

  @override
  State<NotlistBox> createState() => _NotlistBoxState();
}

class _NotlistBoxState extends State<NotlistBox> {
  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();
    String formattedTime = DateFormat.jm().format(now);
    final DateTime now2 = DateTime.now();
    final DateFormat formatter = DateFormat('yyyy-MM-dd');
    final String formatted = formatter.format(now2);
    final GlobalKey<ScaffoldState> _ScaffoldKey = GlobalKey<ScaffoldState>();
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;
    //var i = _childrenNote[0] as noteList;
    // try {
    //   for (var i = 0; i < {widget._childrenNote}.length; i++) {
    //     if (widget._childrenNote.childID![i] ==
    //         widget._childrenList.childID![i])
    //       return so(height, now, formatted, width,
    //           widget._childrenList.childName![i]);
    //   }
    // } catch (e) {

      
    // }
    return Padding(
      padding: const EdgeInsets.only(bottom: 15, left: 25, right: 25, top: 7),
      child: newMethod(height, now, formatted, width),
    );
  }

  Container newMethod(double height, DateTime now, String formatted, double width) {
    return Container(
      height: height * 0.1,
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
              Directionality(
                textDirection: ui.TextDirection.rtl,
                child: Container(
                  padding: EdgeInsets.only(top: 10, bottom: 15),
                  child: Text(((widget._childrenNote.childID![i] ==
           widget._childrenList.childID![i])
                      " مر " +
                          "${widget._childrenList.childName}" +
                          " من "
                              "${widget._childrenNote.zone_name}",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF9C0000),
                      )),
                ),
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
                        right: 1, left: 0.1, top: width * 0.05, bottom: 0.1),
                    child: Text(
                      "${widget._childrenList.childName} ",
                      style: TextStyle(
                          fontSize: 20,
                          color: Color.fromARGB(255, 41, 41, 32)),
                    ),
                  ),
                ],
              ),
              Container(
                padding: EdgeInsets.all(5),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10.0),
                  child: networkImg("${widget._childrenList.childImagePath}",
                      width, height),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // Widget list() => ListView.builder(
  //     itemCount: _childrenNote.length,
  //     shrinkWrap: true,
  //     itemBuilder: (context, index) {
  //       //if (index == 0)
  //       //return Null;
  //       // else
  //       return NotlistBox(_childrenNote[index] as childrenList);
  //     });
}
// Widget _findchild() {

// }

networkImg(String childImage, double ScreenWidth, double ScreenHeight) {
  try {
    return Image.network(
      childImage,
      width: ScreenWidth * 0.15,
      height: ScreenHeight * 0.33,
      fit: BoxFit.cover,
      frameBuilder:
          (BuildContext context, Widget child, int? frame, bool isAsyncLoaded) {
        return Container(
          child: child,
        );
      },
      loadingBuilder: (BuildContext context, Widget child,
          ImageChunkEvent? loadingProgress) {
        if (loadingProgress == null) return child;
        return Center(
          child: Text(
            "جاري التحميل",
            style: TextStyle(
                color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
          ),
        );
      },
      errorBuilder: (BuildContext context, Object error, StackTrace? st) {
        return Container(
          width: ScreenWidth * 0.15,
          height: ScreenHeight * 0.33,
          child: Center(
            child: Text(
              "! حدث خطأ",
              style: TextStyle(
                fontSize: 12,
                color: Color.fromARGB(255, 41, 41, 32),
              ),
            ),
          ),
        );
      },
    );
  } catch (error) {}
}
//const childrenList({
  //  Key? key,
    //required this.childImagePath,
   // required this.childName,
   // required this.zoneName,
 // }) : super(key: key);
