import 'package:elfaa/screens/mngChildInfo/addChild.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:elfaa/screens/Homepage/childrenList.dart';
import 'package:elfaa/screens/notificationPage/NoteList.dart';
import 'package:flutter/material.dart';
import 'package:elfaa/constants.dart';
import 'package:elfaa/screens/Homepage/listBox.dart';
import 'package:elfaa/screens/Homepage/qr.dart';
import 'package:elfaa/screens/mngChildInfo/addChild.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:elfaa/constants.dart';

String username = "";
List<Object> _childrenList = [];

class NotePage extends StatelessWidget {
  String userid = "";
  Future<void> getCurrentUserr() async {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    final User? user = await _auth.currentUser;
    final userid = user!.uid;
    await FirebaseFirestore.instance
        .collection('users')
        .doc(userid)
        .get()
        .then((DocumentSnapshot<Map<String, dynamic>> snapshot) {
      username = snapshot['name'];
    });
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
            children: [
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
                        itemCount: _childrenList.length,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          //if (index == 0)
                          //return Null;
                          // else
                          return listBox(_childrenList[index] as childrenList);
                        })),
              ],
            ),
          )
          // Padding(
          //   padding: const EdgeInsets.all(25.0),
          //   child: Column(
          //     children: [
          //       noteList(
          //           childImagePath: 'assets/images/ahmad.png',
          //           childName: 'أحمد',
          //           zoneName: "! " 'مر من بوابة رقم ٧ '),
          //       noteList(
          //           childImagePath: 'assets/images/sarah.png',
          //           childName: 'سارة',
          //           zoneName: 'تم تحديث الحالة  '),
          //     ],
          //   ),
          // )
        ]),
      ),
    );
  }

  Future<void> getChildrenList() async {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    final User? user = await _auth.currentUser;
    final userid = user!.uid;

    var data = await FirebaseFirestore.instance
        .collection('users')
        .doc(userid)
        .collection('children')
        .orderBy('birthday', descending: true)
        .get();

    setState(() {
      _childrenList =
          List.from(data.docs.map((doc) => childrenList.fromSnapshot(doc)));
    });
  }
}
