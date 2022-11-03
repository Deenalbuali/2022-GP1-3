import 'package:elfaa/screens/Homepage/HomelistBox.dart';
//import 'package:elfaa/screens/Homepage/qr.dart';
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
  int _counter = 0;
  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  Future<void> getCurrentUserr() async {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    final User? user = await _auth.currentUser;
    if (!mounted) return;
    final userid = user!.uid;
    await FirebaseFirestore.instance
        .collection('users')
        .doc(userid)
        .get()
        .then((DocumentSnapshot<Map<String, dynamic>> snapshot) {
      username = snapshot['name'];
    });
    if (!mounted) return;
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
    final GlobalKey<ScaffoldState> _ScaffoldKey = GlobalKey<ScaffoldState>();
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Container(
        child: Column(crossAxisAlignment: CrossAxisAlignment.end, children: <
            Widget>[
          _buildHeader(),

          Padding(
            padding: const EdgeInsets.only(right: 25.0, top: 5),
            child: Text(
              "تتبع أطفالك ",
              style: TextStyle(
                  color: kOrangeColor,
                  fontSize: 18.0,
                  fontWeight: FontWeight.w700),
            ),
          ),

          _childrenList.length == 0
              ? Padding(
                  padding:
                      const EdgeInsets.only(left: 25.0, right: 25, bottom: 10),
                  child: Container(
                    height: height * 0.2,
                    decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                              color: Colors.grey,
                              offset: Offset(1.0, 1.0),
                              blurRadius: 4.0)
                        ],
                        borderRadius: BorderRadius.circular(30),
                        image: DecorationImage(
                            image: AssetImage("assets/images/empty.jpeg"),
                            fit: BoxFit.cover)),
                  ),
                )
              : _childrenList.length == 1
                  ? Padding(
                      padding: const EdgeInsets.only(
                          left: 25.0, right: 25, bottom: 10),
                      child: Container(
                        height: height * 0.2,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.grey,
                                  offset: Offset(1.0, 1.0),
                                  blurRadius: 4.0)
                            ],
                            borderRadius: BorderRadius.circular(30),
                            image: DecorationImage(
                                image: AssetImage("assets/images/oneChild.jpg"),
                                fit: BoxFit.cover)),
                      ),
                    )
                  : Padding(
                      padding: const EdgeInsets.only(
                          left: 25.0, right: 25, bottom: 10),
                      child: Container(
                        height: height * 0.2,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.grey,
                                  offset: Offset(1.0, 1.0),
                                  blurRadius: 4.0)
                            ],
                            borderRadius: BorderRadius.circular(30),
                            image: DecorationImage(
                                image: AssetImage("assets/images/MainMap.jpg"),
                                fit: BoxFit.cover)),
                      ),
                    ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 25.0),
                child: Container(
                    height: height * 0.06,
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
                        _incrementCounter;
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => addChild()),
                        );
                      },
                      icon: Icon(Icons.add),
                      color: Colors.white,
                    )),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 25.0),
                child: Container(
                    height: height * 0.06,
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
                        // Navigator.push(
                        //   context,
                        //   MaterialPageRoute(builder: (context) => QRPage()),
                        // );
                      },
                      icon: Icon(Icons.qr_code, size: 20),
                      color: Colors.white,
                    )),
              ),
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
          _childrenList.length == 0
              ?
              //     child: Column(
              //       children: [
              //         Container(
              //             padding: const EdgeInsets.only(
              //                 right: 25.0, left: 25, bottom: 25),
              //             child: ListView.builder(
              //                 physics: const AlwaysScrollableScrollPhysics(),
              //                 itemCount: _childrenList.length,
              //                 shrinkWrap: true,
              //                 itemBuilder: (context, index) {
              //                   return HomelistBox(
              //                       _childrenList[index] as childrenList);
              //                 })),
              //       ],
              //     ),
              //   )
              Padding(
                  padding: const EdgeInsets.only(top: 5.0, left: 30),
                  child: Container(
                    height: height * 0.35,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        // boxShadow: [
                        //   BoxShadow(
                        //       color: Colors.grey,
                        //       offset: Offset(1.0, 1.0),
                        //       blurRadius: 4.0)
                        // ],
                        //borderRadius: BorderRadius.circular(15),
                        image: DecorationImage(
                            image: AssetImage("assets/images/noChildren.png"),
                            fit: BoxFit.cover)),
                  ),
                )
              : _buildHeader2(),
        ]),
      ),
    );
  }

  Container _buildHeader2() {
    final GlobalKey<ScaffoldState> _ScaffoldKey = GlobalKey<ScaffoldState>();
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;
    return Container(
      height: height * 0.4,
      width: double.infinity,
      child: Stack(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(left: 10, right: 10, top: 0.1),
            child: SizedBox(child: list()),
          )
        ],
      ),
    );
  }

  Container _buildHeader() {
    final GlobalKey<ScaffoldState> _ScaffoldKey = GlobalKey<ScaffoldState>();
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;
    return Container(
      height: height * 0.22,
      width: double.infinity,
      child: Stack(
        children: <Widget>[
          Positioned(
            bottom: 0,
            top: height * -0.24,
            right: width * -0.2,
            child: Container(
              width: width * 0.8,
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
            top: height * 0.06,
            right: width * 0.1,
            bottom: 0,
            child: Text(
              "! مرحبًا" " ",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                  fontWeight: FontWeight.w700),
            ),
          ),
          Positioned(
            top: height * 0.1,
            right: width * 0.08,
            child: Text(
              username,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 25.0,
                  fontWeight: FontWeight.w700),
            ),
          ),
          //margin: const EdgeInsets.only(top: 40, left: 250),
        ],
      ),
    );
  }

  Widget list() => ListView.builder(
      physics: const AlwaysScrollableScrollPhysics(),
      itemCount: _childrenList.length,
      shrinkWrap: true,
      itemBuilder: (context, index) {
        return HomelistBox(_childrenList[index] as childrenList);
      });
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
      _childrenList =
          List.from(data.docs.map((doc) => childrenList.fromSnapshot(doc)));
    });
  }

  void dispose() {
    super.dispose();
  }
}

//class ListPageState extends State<ListPage> {}
