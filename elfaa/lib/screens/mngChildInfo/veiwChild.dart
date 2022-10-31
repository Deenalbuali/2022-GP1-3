import 'package:age_calculator/age_calculator.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:elfaa/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';

class viewChild extends StatefulWidget {
  const viewChild({super.key});
  @override
  State<viewChild> createState() => _viewChildState();
}

class _viewChildState extends State<viewChild> {
  //Child Info to be retreived from database
  late String childName;
  late String childAge;
  late int childHeight;
  String zoneName = 'منطقة الألعاب';

  Future<void> getCurrentChild() async {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    final User? user = await _auth.currentUser;
    final uid = user!.uid;
    await FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .collection('children')
        .doc('CiQbU3gkuwde5vcBjPKf')
        .get()
        .then((DocumentSnapshot<Map<String, dynamic>> snapshot) {
      //Convert timestamp type of data to DateTime 
      DateTime childBirthday =
          DateTime.parse(snapshot['birthday'].toDate().toString());
      //Calculate Age As years: 0, Months: 0, Days: 0
      DateDuration calcAge = AgeCalculator.age(childBirthday);
      setState(() {
        childName = snapshot['name'];
        //Age numbers extraction as three digits String "000" for later presentation
        childAge = calcAge.toString().replaceAll(new RegExp(r'[^0-9]'), '');
      });
    });
  }

  @override
  void initState() {
    getCurrentChild();
    super.initState();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.transparent,
          elevation: 0,
          toolbarHeight: 90,
          leading: const BackButton(color: Colors.white),
          title: const Text(
            "صفحة الطفل",
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
          ),
          actions: [IconButton(icon: Icon(Icons.edit), onPressed: (() {}))],
          centerTitle: true,
          flexibleSpace: Container(
              decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(28),
                bottomRight: Radius.circular(28)),
            color: kPrimaryColor,
          )),
        ),
        body: Column(
          children: [
            Container(
              height: 530,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
                  image: DecorationImage(
                      image: AssetImage("assets/images/location.jpeg"),
                      fit: BoxFit.cover)),
            ),
            Container(
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(28),
                    topRight: Radius.circular(28)),
                color: kPrimaryColor,
              ),
              child: Padding(
                padding: const EdgeInsets.only(top: 10, bottom: 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      children: [
                        Container(
                          child: Image.asset(
                            "assets/images/empty.png",
                            height: 100,
                          ),
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          "الاسم",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          "العمر",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          "الطول",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          "المكان الحالي",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      );
}
