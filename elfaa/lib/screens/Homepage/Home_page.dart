import 'package:elfaa/screens/Homepage/listBox.dart';
import 'package:elfaa/screens/Homepage/qr.dart';
import 'package:elfaa/screens/mngChildInfo/addChild.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:elfaa/constants.dart';
import 'childrenList.dart';

int index = 2;
final Color color1 = kPrimaryColor;
final Color color2 = kPrimaryColor;
final Color color3 = kPrimaryColor;
String username = "";
List<Object> _childrenList = [];

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //const HomePage({super.key});
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

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    getChildrenList();
  }

  @override
  void initState() {
    getCurrentUserr();
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(children: <Widget>[
          _buildHeader(),
          Row(
            children: [
              SizedBox(
                width: 20,
              ),
              Align(
                alignment: Alignment(-0.1, -1),
                child: Container(
                    decoration: BoxDecoration(
                        color: kOrangeColor,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                              color: kOrangeColor,
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
              ),
              SizedBox(
                width: 250,
              ),
              Container(
                  decoration: BoxDecoration(
                      color: Colors.grey,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                            color: Colors.grey,
                            offset: Offset(1.0, 1.0),
                            blurRadius: 4.0)
                      ]),
                  child: IconButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => QRPage()),
                      );
                    },
                    icon: Icon(Icons.qr_code),
                    color: Colors.white,
                  )),
            ],
          ),
          // SizedBox(
          //   height: 10,
          //   width: 10,
          //   child: Column(
          //     children: [
          //       Container(
          //           child: ListView.builder(
          //               itemCount: 10,
          //               shrinkWrap: true,
          //               itemBuilder: (context, index) {
          //                 return ListTile(title: Text('index: $index'));
          //               })),
          //     ],
          //   ),
          // ),
          SizedBox(height: 15),
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

          //Column(
          //   children: [
          //     // childrenList(
          //     //     childImagePath: 'assets/images/ahmad.png',
          //     //     childName: 'أحمد',
          //     //     zoneName: 'منطقة الألعاب'),
          //     // childrenList(
          //     //     childImagePath: 'assets/images/sarah.png',
          //     //     childName: 'سارة',
          //     //     zoneName: 'منطقة المطاعم'),
          // ],
          // ),
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
            margin: const EdgeInsets.only(top: 60, left: 260),
            child: Column(
              //crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  "! مرحبًا" " ",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 28.0,
                      fontWeight: FontWeight.w700),
                ),
                SizedBox(height: 1),
                Text(
                  username,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 28.0,
                      fontWeight: FontWeight.w700),
                ),
                SizedBox(height: 10.0),
              ],
            ),
          )
        ],
      ),
    );
  }

  //void initState() {
  // getCurrentUser();

  // final user = FirebaseAuth.instance.currentUser!.uid;
  // final userRef = FirebaseFirestore.instance
  //   .collection('parent')
  //   .doc(user)
  //   .collection('children')
  //  .doc();
  // _buildHeader();
  //   super.initState();
  // }

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

//class ListPageState extends State<ListPage> {}
