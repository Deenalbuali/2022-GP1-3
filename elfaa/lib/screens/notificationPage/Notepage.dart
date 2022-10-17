import 'package:elfaa/screens/mngChildInfo/addChild.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:elfaa/screens/Homepage/childrenList.dart';
import 'package:flutter/material.dart';

class NotePage extends StatelessWidget {
  int index = 0;
  //const NotePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 235, 234, 234),
      body: SafeArea(
        child: Column(children: [
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 25.0, vertical: 25.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  decoration: BoxDecoration(
                      color: Colors.orange, shape: BoxShape.circle),
                ),
                Row(
                  children: [
                    Text(
                      ' التنبيهات ',
                      style: TextStyle(fontSize: 26),
                    ),
                  ],
                )
              ],
            ),
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
}
