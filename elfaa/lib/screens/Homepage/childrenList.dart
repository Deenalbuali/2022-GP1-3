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
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Container(
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(12)),
              height: 80,
              padding: EdgeInsets.all(12),
              child: Image.asset(childImagePath),
            ),
            SizedBox(
              height: 20,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  childName,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(zoneName,
                    style: TextStyle(fontSize: 16, color: Colors.blue))
              ],
            ),
          ],
        ),
        Icon(Icons.arrow_forward_ios),
      ],
    );
  }
}
