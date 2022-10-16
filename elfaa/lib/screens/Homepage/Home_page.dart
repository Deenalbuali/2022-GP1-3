import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:elfaa/screens/Homepage/childrenList.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 235, 234, 234),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: CurvedNavigationBar(
          backgroundColor: Color.fromARGB(255, 235, 234, 234),
          animationDuration: Duration(milliseconds: 300),
          onTap: (index) {},
          items: [
            Icon(Icons.notifications, color: Colors.orange, size: 30),
            Icon(Icons.home, color: Colors.orange, size: 30),
            Icon(
              Icons.person,
              color: Colors.orange,
              size: 30,
            )
          ]),
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
                    child: IconButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const addChild()),
                        );
                      },
                      icon: Icon(Icons.add),
                      color: Colors.white,
                    )),
                Row(
                  children: [
                    Text(
                      "! " ' محمد ',
                      style: TextStyle(fontSize: 26),
                    ),
                    Text(
                      'مرحبا ',
                      style:
                          TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
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
}
