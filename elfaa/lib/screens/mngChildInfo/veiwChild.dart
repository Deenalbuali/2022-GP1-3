import 'package:age_calculator/age_calculator.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:elfaa/constants.dart';
import 'package:elfaa/screens/mngChildInfo/editChild.dart';
import 'package:firebase_auth/firebase_auth.dart';

class viewChild extends StatefulWidget {
  const viewChild({super.key});
  @override
  State<viewChild> createState() => _viewChildState();
}

class _viewChildState extends State<viewChild> {
  //Child Info to be retreived from database
  late String childName;
  late String childAgeYears;
  late String childAgeMonths;
  late int childHeight;
  late String childImage;
  late String childGender;
  String zoneName = 'في منطقة الألعاب';

  Future<void> getCurrentChild() async {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    final User? user = await _auth.currentUser;
    final uid = user!.uid;
    await FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .collection('children')
        .doc('XuulXMzQvkPimuv0NDXR')
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
        //Extract each of years and months 
        childAgeYears = (calcAge.toString().replaceAll(new RegExp(r'[^0-9]'), ''))[0];
        childAgeMonths = (calcAge.toString().replaceAll(new RegExp(r'[^0-9]'), ''))[1];


        childHeight = snapshot['height'];
        childImage = snapshot['image'];
        childGender = snapshot['gender'];
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
          actions: [IconButton(icon: Icon(Icons.edit), onPressed: (() 
          {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => editChild()),
                        );
                      }
          ))],
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
              height: 450,
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
                padding: const EdgeInsets.only(top: 25, bottom: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(20.0),
                          child: Image.network(
                            childImage,
                            width: 140,
                            height: 140,
                            fit:BoxFit.cover,
                            frameBuilder: (BuildContext context, Widget child, int? frame, bool isAsyncLoaded){
                              return Padding(padding: EdgeInsets.all(1),
                              child: child,);
                            },
                             loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
                             if (loadingProgress == null) return child;
                             return Center(
                              child: Text("جاري التحميل"),
                             );
                             },
                             errorBuilder: (BuildContext context, Object error, StackTrace? st){
                              return Center(
                                child: Text("error"),
                              );
                             },
                          ),
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          "$childName",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 12,
                        ),
                        Text(
                        (int.parse(childAgeYears)>10)?
                          "$childAgeYears سنة":
                          "$childAgeYears سنوات",
                          textDirection: TextDirection.rtl,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 2,
                        ),
                        Text(
                          "$childGender",
                          textDirection: TextDirection.rtl,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 2,
                        ),
                        Text(
                          "$childHeight سم",
                          textDirection: TextDirection.rtl,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          "$zoneName",
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
