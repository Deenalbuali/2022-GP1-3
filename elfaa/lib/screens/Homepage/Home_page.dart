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
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: Column(children: [
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 25.0, vertical: 25.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                    padding: EdgeInsets.all(4),
                    decoration: BoxDecoration(
                        color: Colors.orange, shape: BoxShape.circle),
                    child: Icon(Icons.add)),
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
                Row(
                  children: [
                    Container(
                      decoration: BoxDecoration(color: Colors.white),
                      height: 80,
                      padding: EdgeInsets.all(12),
                      child: Image.asset('assets/images/ahmad.png'),
                    ),
                    Column(
                      children: [Text('أحمد'), Text('منطقة الألعاب')],
                    ),
                    Icon(Icons.arrow_forward_ios)
                  ],
                )
              ],
            ),
          )
        ]),
      ),
    );
  }
}
