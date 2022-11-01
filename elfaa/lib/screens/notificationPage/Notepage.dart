import 'package:elfaa/screens/mngChildInfo/addChild.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:elfaa/screens/Homepage/childrenList.dart';
import 'package:elfaa/screens/notificationPage/NotlistBox.dart';
import 'package:flutter/material.dart';
import 'package:elfaa/constants.dart';
import 'package:elfaa/screens/Homepage/HomelistBox.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

final DateTime now = DateTime.now();
final DateFormat formatter = DateFormat('yyyy-MM-dd');
final String formatted = formatter.format(now);
List<Object> _childrenList2 = [];

class NotePage extends StatefulWidget {
  @override
  State<NotePage> createState() => _NotePageState();
}

class _NotePageState extends State<NotePage> {
  String userid = "";

  void dispose() {
    super.dispose();
  }

  int index = 1;

  //const NotePage({super.key});
  final Color color1 = Color(0xFF429EB2);

  final Color color2 = Color(0xFF429EB2);

  final Color color3 = Color(0xFF429EB2);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        elevation: 0,
        toolbarHeight: 90,
        title: Text(
          "التنبيهات",
          style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
        ),
        centerTitle: true,
        flexibleSpace: Container(
            decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(28),
              bottomRight: Radius.circular(28)),
          color: kPrimaryColor,
        )),
      ),
      body: SingleChildScrollView(
        child: Column(children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: EdgeInsets.only(top: 12, left: 50),
                child: Text(
                  formatted,
                  style: TextStyle(
                    color: Color(0xff919296),
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 25.0, vertical: 25.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          color: Colors.orange, shape: BoxShape.circle),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(
            child: Column(
              children: [
                Container(
                    padding: const EdgeInsets.all(25.0),
                    child: ListView.builder(
                        itemCount: _childrenList2.length,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          //if (index == 0)
                          //return Null;
                          // else
                          return NotlistBox(
                              _childrenList2[index] as childrenList);
                        })),
              ],
            ),
          )
        ]),
      ),
    );
  }

  void didChangeDependencies() {
    super.didChangeDependencies();
    getChildrenList();
  }

  void initState() {
    super.initState();
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
        .orderBy('birthday', descending: true)
        .get();
    if (!mounted) return;

    setState(() {
      if (!mounted) return;
      _childrenList2 =
          List.from(data.docs.map((doc) => childrenList.fromSnapshot(doc)));
    });
  }
}
