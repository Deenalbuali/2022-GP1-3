import 'package:elfaa/screens/Reportpage/ReportlistBox.dart';
import 'package:elfaa/screens/Homepage/childrenList.dart';
import 'package:flutter/material.dart';
import 'package:elfaa/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

List<Object> _childrenList3 = [];

class ReportPage extends StatefulWidget {
  @override
  State<ReportPage> createState() => _ReportPageState();
}

class _ReportPageState extends State<ReportPage> {
  int index = 0;
  void dispose() {
    super.dispose();
  }

  //const NotePage({super.key});
  final Color color1 = kPrimaryColor;
  final Color color2 = kPrimaryColor;
  final Color color3 = kPrimaryColor;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        elevation: 0,
        toolbarHeight: 90,
        title: Text(
          "البلاغات",
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
      body: Column(children: [
        Align(
          alignment: Alignment.topCenter,
          child: Padding(
            padding: const EdgeInsets.only(top: 30),
            child: Directionality(
              textDirection: TextDirection.rtl,
              child: ElevatedButton.icon(
                icon: Icon(
                  Icons.campaign,
                  color: Color.fromARGB(255, 255, 255, 255),
                ),
                style: ElevatedButton.styleFrom(
                  textStyle: TextStyle(fontSize: 22),
                  shadowColor: Color.fromARGB(255, 0, 0, 0),
                  elevation: 0,
                  backgroundColor: Colors.grey,
                  shape: const StadiumBorder(),
                  maximumSize: const Size(180, 56),
                  minimumSize: const Size(180, 56),
                ),
                label: Text(
                  ' إنشاء بلاغ   ',
                  style: TextStyle(
                      color: Color.fromARGB(255, 255, 255, 255), fontSize: 20),
                ),
                onPressed: () {},
              ),
            ),
          ),
        ),
        SizedBox(
            child: _childrenList3.length == 0
                ? Padding(
                    padding: const EdgeInsets.all(25),
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                        image: AssetImage("assets/images/noReports.png"),
                      )),
                    ),
                  )
                : _buildList()),
      ]),
    );
  }

  Widget list() => ListView.builder(
      itemCount: _childrenList3.length,
      shrinkWrap: true,
      itemBuilder: (context, index) {
        return ReportlistBox(_childrenList3[index] as childrenList);
      });

  void didChangeDependencies() {
    super.didChangeDependencies();
    getChildrenList();
  }

  void initState() {
    super.initState();
  }

  Container _buildList() {
    final GlobalKey<ScaffoldState> _ScaffoldKey = GlobalKey<ScaffoldState>();
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;
    return Container(
      height: height * 0.65,
      width: double.infinity,
      child: Stack(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 10, left: 10, top: 10),
            child: SizedBox(child: list()),
          )
        ],
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
        .orderBy('birthday', descending: true)
        .get();
    if (!mounted) return;

    setState(() {
      if (!mounted) return;
      _childrenList3 =
          List.from(data.docs.map((doc) => childrenList.fromSnapshot(doc)));
    });
  }
}
