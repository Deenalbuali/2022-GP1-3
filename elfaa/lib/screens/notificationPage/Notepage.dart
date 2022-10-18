import 'package:elfaa/screens/mngChildInfo/addChild.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:elfaa/screens/Homepage/childrenList.dart';
import 'package:flutter/material.dart';

class NotePage extends StatelessWidget {
  int index = 0;
  //const NotePage({super.key});
  final Color color1 = Color.fromRGBO(0, 122, 151, 1);
  final Color color2 = Color.fromRGBO(0, 122, 151, 1);
  final Color color3 = Color.fromRGBO(0, 122, 151, 1);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFf5f5f5),
      body: SingleChildScrollView(
        child: Column(children: <Widget>[
          _buildHeader(),
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
                childrenList(
                    childImagePath: 'assets/images/ahmad.png',
                    childName: 'أحمد',
                    zoneName: "!" 'تم إيجاد طفلك '),
                childrenList(
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

  Container _buildHeader() {
    return Container(
      height: 100,
      width: double.infinity,
      child: Stack(
        children: <Widget>[
          Positioned(
            bottom: 0,
            right: 10,
            top: -280,
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
          Container(
            margin: const EdgeInsets.only(top: 30, left: 150),
            child: Column(
              //crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  "التنبيهات",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 28.0,
                      fontWeight: FontWeight.w700),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
