import 'package:elfaa/screens/mngChildInfo/addChild.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:elfaa/screens/Homepage/childrenList.dart';
import 'package:elfaa/screens/notificationPage/NoteList.dart';
import 'package:flutter/material.dart';
import 'package:elfaa/constants.dart';

class NotePage extends StatelessWidget {
  int index = 1;
  //const NotePage({super.key});
  final Color color1 = Color(0xFF429EB2);
  final Color color2 = Color(0xFF429EB2);
  final Color color3 = Color(0xFF429EB2);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFf5f5f5),
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
                gradient: LinearGradient(
                  colors: [Color(0xFFADCED6), kPrimaryColor],
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                ))),
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
          Padding(
            padding: const EdgeInsets.all(25.0),
            child: Column(
              children: [
                noteList(
                    childImagePath: 'assets/images/ahmad.png',
                    childName: 'أحمد',
                    zoneName: "!" 'تم إيجاد طفلك '),
                noteList(
                    childImagePath: 'assets/images/sarah.png',
                    childName: 'سارة',
                    zoneName: "!" 'تم إيجاد طفلك '),
              ],
            ),
          )
        ]),
      ),
    );
  }
}
