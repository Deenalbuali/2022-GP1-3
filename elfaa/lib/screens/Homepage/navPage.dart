import 'package:elfaa/screens/Homepage/Home_page.dart';
import 'package:elfaa/screens/Reportpage/ReportPage.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:elfaa/screens/notificationPage/Notepage.dart';
import 'package:flutter/material.dart';
import 'package:elfaa/screens/profile/profile_page.dart';
import 'package:elfaa/constants.dart';


class NavPage extends StatefulWidget {
  const NavPage({super.key});

  @override
  State<NavPage> createState() => _NavPageState();
}

class _NavPageState extends State<NavPage> {
  final navigationKey = GlobalKey<CurvedNavigationBarState>();
  final screens = [EditProfilePage(), ReportPage(), NotePage(), HomePage()];
  int index = 3;
  void initState() {
    // get current user

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final items = <Widget>[
      Icon(
        Icons.person,
        color: kOrangeColor,
        size: 30,
      ),
      Icon(
        Icons.campaign,
        color: kOrangeColor,
        size: 30,
      ),
      Icon(
        Icons.notifications,
        color: kOrangeColor,
        size: 30,
      ),
      Icon(
        Icons.home,
        color: kOrangeColor,
        size: 30,
      ),
    ];
    return Scaffold(
      extendBody: true,
      backgroundColor: Color(0xFFEBEAEA),
      body: screens[index],
      bottomNavigationBar: Theme(
          data: Theme.of(context).copyWith(
            iconTheme: IconThemeData(color: Colors.orange),
          ),
          child: CurvedNavigationBar(
            color: Colors.white,
            buttonBackgroundColor: Colors.white,
            animationDuration: Duration(milliseconds: 300),
            backgroundColor: Color(0xFFfafafa),
            height: 60,
            index: index,
            items: items,
            onTap: (index) => setState(() => this.index = index),
          )),
    );
  }
}
