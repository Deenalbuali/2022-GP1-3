import 'package:elfaa/screens/Reportpage/reportInfo.dart';
import 'package:flutter/material.dart';

class reportList extends StatelessWidget {
  final String childImagePath;
  final String childName;
  final String zoneName;
  const reportList({
    Key? key,
    required this.childImagePath,
    required this.childName,
    required this.zoneName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 25.0),
      child: Container(
        decoration: BoxDecoration(boxShadow: [
          BoxShadow(
            color: Colors.grey,
            blurRadius: 10,
            spreadRadius: 1,
          )
        ], color: Colors.white, borderRadius: BorderRadius.circular(12)),
        height: 80,
        padding: EdgeInsets.all(5),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
                decoration: BoxDecoration(
                    color: Colors.orange,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                          color: Colors.orange,
                          offset: Offset(1.0, 1.0),
                          blurRadius: 4.0)
                    ]),
                child: IconButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => reportInfo()),
                    );
                  },
                  icon: Icon(Icons.content_paste),
                  color: Colors.white,
                )),
            Row(
              children: [
                Column(
                  //crossAxisAlignment: CrossAxisAlignment.start,
                  //mainAxisAlignment: MainAxisAlignment.spaceEvenly,

                  children: [
                    SizedBox(
                      width: 20,
                    ),
                    Text(
                      childName,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: Color.fromARGB(255, 41, 41, 32)),
                    ),
                    Text(zoneName,
                        style: TextStyle(fontSize: 16, color: Colors.orange))
                  ],
                ),
                Container(
                  padding: EdgeInsets.all(12),
                  child: Image.asset(childImagePath),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
