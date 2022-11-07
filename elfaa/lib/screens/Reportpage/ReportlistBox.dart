import 'package:elfaa/screens/Homepage/childrenList.dart';
import 'package:elfaa/screens/Reportpage/reportInfo.dart';
import 'package:flutter/material.dart';
import 'package:elfaa/constants.dart';


class ReportlistBox extends StatelessWidget {
  final childrenList _childlist3;
  ReportlistBox(this._childlist3);
  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> _ScaffoldKey = GlobalKey<ScaffoldState>();
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.only(bottom: 15, left: 15, right: 15, top: 7),
      child: Container(
        decoration: BoxDecoration(boxShadow: [
          BoxShadow(
              color: Color(0xff484848).withOpacity(.3),
              offset: Offset(0, 4),
              blurRadius: 8)
        ], color: Colors.white, borderRadius: BorderRadius.circular(12)),
        height: height * 0.1,
        padding: EdgeInsets.all(5),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                  decoration: BoxDecoration(
                      color: kOrangeColor,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                            color: kOrangeColor.withOpacity(.3),
                            offset: Offset(0,4),
                            blurRadius: 8)
                      ]),
                  child: IconButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => reportInfo(
                                  childName: "${_childlist3.childName}",
                                  childImagePath:
                                      "${_childlist3.childImagePath}",
                                )),
                      );
                    },
                    icon: Icon(Icons.content_paste),
                    color: Colors.white,
                  )),
            ),
            Row(
              children: [
                Column(
                  //crossAxisAlignment: CrossAxisAlignment.start,
                  //mainAxisAlignment: MainAxisAlignment.spaceEvenly,

                  children: [
                    Container(
                      padding: EdgeInsets.only(
                          right: width * 0.05,
                          left: 0.1,
                          top: width * 0.05,
                          bottom: 0.1),
                      child: Text(
                        "${_childlist3.childName}",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: Color.fromARGB(255, 41, 41, 32)),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(5),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10.0),
                    child: networkImg(
                        "${_childlist3.childImagePath}", width, height),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

networkImg(String childImage, double ScreenWidth, double ScreenHeight) {
  try {
    return Image.network(
      childImage,
      width: ScreenWidth * 0.15,
      height: ScreenHeight * 0.33,
      fit: BoxFit.cover,
      frameBuilder:
          (BuildContext context, Widget child, int? frame, bool isAsyncLoaded) {
        return Container(
          child: child,
        );
      },
      loadingBuilder: (BuildContext context, Widget child,
          ImageChunkEvent? loadingProgress) {
        if (loadingProgress == null) return child;
        return Center(
          child: Text(
            "جاري التحميل",
            style: TextStyle(
                color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
          ),
        );
      },
      errorBuilder: (BuildContext context, Object error, StackTrace? st) {
        return Container(
          width: ScreenWidth * 0.15,
          height: ScreenHeight * 0.33,
          child: Center(
            child: Text(
              "! حدث خطأ",
              style: TextStyle(
                fontSize: 12,
                color: Color.fromARGB(255, 41, 41, 32),
              ),
            ),
          ),
        );
      },
    );
  } catch (error) {}
}
//const childrenList({
  //  Key? key,
    //required this.childImagePath,
   // required this.childName,
   // required this.zoneName,
 // }) : super(key: key);
