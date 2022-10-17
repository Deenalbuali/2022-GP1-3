import 'package:elfaa/screens/Homepage/Home_page.dart';
import 'package:elfaa/screens/login/login_screen.dart';
import 'package:elfaa/screens/mngChildInfo/addChild.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:elfaa/screens/Homepage/childrenList.dart';
import 'package:elfaa/screens/notificationPage/Notepage.dart';
import 'package:flutter/material.dart';

class NavPage extends StatefulWidget {
  const NavPage({super.key});

  @override
  State<NavPage> createState() => _NavPageState();
}

class _NavPageState extends State<NavPage> {
  final navigationKey = GlobalKey<CurvedNavigationBarState>();
  final screens = [NotePage(), HomePage()];
  int index = 1;
  @override
  Widget build(BuildContext context) {
    final items = <Widget>[
      Icon(Icons.notifications, color: Colors.orange, size: 30),
      Icon(Icons.home, color: Colors.orange, size: 30),
      Icon(
        Icons.person,
        color: Colors.orange,
        size: 30,
      )
    ];
    return Scaffold(
      extendBody: true,
      backgroundColor: Color.fromARGB(255, 235, 234, 234),
      body: screens[index],
      bottomNavigationBar: Theme(
          data: Theme.of(context).copyWith(
            iconTheme: IconThemeData(color: Colors.orange),
          ),
          child: CurvedNavigationBar(
            color: Colors.white,
            buttonBackgroundColor: Colors.grey[300],
            animationDuration: Duration(milliseconds: 300),
            backgroundColor: Colors.transparent,
            height: 60,
            index: index,
            items: items,
            onTap: (index) => setState(() => this.index = index),
          )),
    );
  }
}
