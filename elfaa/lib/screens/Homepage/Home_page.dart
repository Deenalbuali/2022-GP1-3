import 'package:elfaa/screens/mngChildInfo/addChild.dart';
import 'package:elfaa/screens/Homepage/childrenList.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:elfaa/constants.dart';

import 'package:elfaa/screens/profile/profile_page.dart';

int index = 2;
final Color color1 = Color(0xFF429EB2);
final Color color2 = Color(0xFF429EB2);
final Color color3 = Color(0xFF429EB2);

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //const HomePage({super.key});
  String _name = "";
  // List<Object> _historyList = [];

  @override
  Future<void> getCurrentUser() async {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    final User? user = await _auth.currentUser;
    final uid = user!.uid;
    await FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .get()
        .then((DocumentSnapshot<Map<String, dynamic>> snapshot) {
      _name = snapshot['name'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFfafafa),
      body: SingleChildScrollView(
        child: Column(children: <Widget>[
          _buildHeader(),
          Row(
            children: [
              SizedBox(
                width: 20,
              ),
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
                        MaterialPageRoute(builder: (context) => addChild()),
                      );
                    },
                    icon: Icon(Icons.add),
                    color: Colors.white,
                  )),
            ],
          ),
          SizedBox(height: 15),
          Directionality(
            textDirection: TextDirection.ltr,
            child: ElevatedButton.icon(
              icon: Icon(
                Icons.qr_code,
                color: kPrimaryColor,
              ),
              style: ElevatedButton.styleFrom(
                textStyle: TextStyle(fontSize: 22),
                elevation: 0.9,
                shadowColor: Color.fromARGB(255, 0, 0, 0),
                backgroundColor: Color(0xFFE5E5E5),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0)),
                maximumSize: Size(335, 56),
                minimumSize: Size(335, 56),
              ),
              label: Text(
                '          QR رمز الاستجابة السريعة',
                style: TextStyle(color: kPrimaryColor, fontSize: 20),
              ),
              onPressed: () {},
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(25.0),
            child: Column(
              children: [
                childrenList(
                    childImagePath: 'assets/images/ahmad.png',
                    childName: 'أحمد',
                    zoneName: 'منطقة الألعاب'),
                childrenList(
                    childImagePath: 'assets/images/sarah.png',
                    childName: 'سارة',
                    zoneName: 'منطقة المطاعم'),
              ],
            ),
          )
        ]),
      ),
    );
  }

  Container _buildHeader() {
    return Container(
      height: 250,
      width: double.infinity,
      child: Stack(
        children: <Widget>[
          Positioned(
            bottom: 0,
            right: -80,
            top: -190,
            child: Container(
              width: 350,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(colors: [color1, color2]),
                  boxShadow: [
                    BoxShadow(
                        color: color2,
                        offset: Offset(4.0, 4.0),
                        blurRadius: 10.0)
                  ]),
            ),
          ),
          Positioned(
            top: 10,
            left: 200,
            child: Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(colors: [color3, color2]),
                  boxShadow: [
                    BoxShadow(
                        color: color3,
                        offset: Offset(1.0, 1.0),
                        blurRadius: 4.0)
                  ]),
            ),
          ),
          Positioned(
            top: 100,
            left: 300,
            child: Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(colors: [color3, color2]),
                  boxShadow: [
                    BoxShadow(
                        color: color3,
                        offset: Offset(1.0, 1.0),
                        blurRadius: 4.0)
                  ]),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 60, left: 220),
            child: Column(
              //crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  "! مرحبًا" " " + _name,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 28.0,
                      fontWeight: FontWeight.w700),
                ),
                SizedBox(height: 1),
                SizedBox(height: 10.0),
              ],
            ),
          )
        ],
      ),
    );
  }

  //void initState() {
  //  getCurrentUser();

  // final user = FirebaseAuth.instance.currentUser!.uid;
  // final userRef = FirebaseFirestore.instance
  //   .collection('parent')
  //   .doc(user)
  //   .collection('children')
  //  .doc();
  // _buildHeader();
  // super.initState();
  // }

  void updateUI() {
    setState(() {
      //You can also make changes to your state here.
    });
  }
}

//class ListPageState extends State<ListPage> {}
