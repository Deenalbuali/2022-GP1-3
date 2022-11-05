import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:elfaa/screens/Homepage/childrenList.dart';
import 'package:elfaa/screens/notificationPage/noteList.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart' hide TextDirection;
import 'package:intl/intl.dart';

List<Object> _childrenNote = [];

class NotlistBox extends StatefulWidget {
  final childrenList _childrenList;
  NotlistBox(this._childrenList);

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
    return Padding(
      padding: const EdgeInsets.only(bottom: 15, left: 25, right: 25, top: 7),
      child: Container(
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
                Container(
                  padding: EdgeInsets.only(top: 10, bottom: 15),
                  child: Text(
                      "! " "من " "${widget._childrenList.childName} " " مر ",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF9C0000),
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
                    child: Image.network(
                      "${widget._childrenList.childImagePath}",
                      width: width * 0.20,
                      height: width * 0.15,
                      fit: BoxFit.cover,
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

  Future<void> getChildrenList() async {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    final User? user = await _auth.currentUser;
    if (!mounted) return;
    final userid = user!.uid;

    var data = await FirebaseFirestore.instance
        .collection('users')
        .doc(userid)
        .collection('children')
        .doc("${widget._childrenList.childID} ")
        .collection('notifications')
        .orderBy('time', descending: true)
        .get();
    if (!mounted) return;
    setState(() {
      if (!mounted) return;
      if (data.docs.length != 0) {
        _childrenNote =
            List.from(data.docs.map((doc) => childrenList.fromSnapshot(doc)));
      }
    });
  }
}
//const childrenList({
  //  Key? key,
    //required this.childImagePath,
   // required this.childName,
   // required this.zoneName,
 // }) : super(key: key);
