import 'package:flutter/material.dart';

class childrenList extends StatelessWidget {
  final String childImagePath;
  final String childName;
  final String zoneName;
  const childrenList({
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
            Icon(Icons.arrow_back_ios),
            Row(
              children: [
                Column(
                  //crossAxisAlignment: CrossAxisAlignment.start,
                  //mainAxisAlignment: MainAxisAlignment.spaceEvenly,

                  children: [
                    Text(
                      childName,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: Color.fromARGB(255, 41, 41, 32)),
                    ),
                    SizedBox(
                      height: 5,
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
