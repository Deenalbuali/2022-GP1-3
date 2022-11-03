import 'package:age_calculator/age_calculator.dart';
import 'package:flutter/material.dart';
import 'package:elfaa/constants.dart';
import 'package:elfaa/screens/mngChildInfo/editChild.dart';

class viewChild extends StatefulWidget {
  const viewChild({super.key, required this.childID, required this.childImage, required this.childname, required this.childbirthday, required this.childHeight, required this.childGender});
  final String childID;
  final String childImage;
  final String childname;
  final String childbirthday;
  final int childHeight;
  final String childGender;
  @override
  State<viewChild> createState() => _viewChildState();
}

class _viewChildState extends State<viewChild> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    //Child Info
    String childName = widget.childname;
    int childHeight = widget.childHeight;
    String childImage = widget.childImage;
    String childGender = widget.childGender;
    String zoneName = 'منطقة الألعاب';

    //Responsiviness variables
    final double ScreenHeight = MediaQuery.of(context).size.height;
    final double ScreenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.arrow_forward_ios,
              color: Colors.white,
            ),
            onPressed: () => Navigator.of(context).pop(),
          )
        ],
        backgroundColor: Colors.transparent,
        elevation: 0,
        toolbarHeight: 90,
        title: const Text(
          "صفحة الطفل",
          style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
        ),
        leading: IconButton(
            icon: Icon(Icons.edit),
            onPressed: (() {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => editChild(
                      childID: widget.childID,
                      childImage: childImage,
                      childname: childName,
                      childbirthday: widget.childbirthday,
                      childHeight: childHeight,
                      childGender: childGender
                    )),
              );
            })),
        centerTitle: true,
        flexibleSpace: Container(
            decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(28),
              bottomRight: Radius.circular(28)),
          color: kPrimaryColor,
        )),
      ),
      body: Column(
        children: [
          Container(
            height: ScreenHeight * 0.6,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
                image: DecorationImage(
                    image: AssetImage("assets/images/MainMap.jpg"),
                    fit: BoxFit.cover)),
          ),
          Container(
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(28), topRight: Radius.circular(28)),
              color: kPrimaryColor,
            ),
            child: Padding(
              padding: const EdgeInsets.only(top: 15, bottom: 6.206),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Directionality(
                            textDirection: TextDirection.rtl,
                            child: Text(
                              "$childName في",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          Text(
                            "$zoneName",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Container(
                            decoration: BoxDecoration(boxShadow: [
                              BoxShadow(
                                color: Colors.white.withOpacity(0.5),
                                spreadRadius: 1,
                                blurRadius: 22,
                                offset: Offset(5, 5),
                              )
                            ]),
                            child: ClipRRect(
                                borderRadius: BorderRadius.circular(20.0),
                                child: networkImg(
                                    childImage, ScreenWidth, ScreenHeight)),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: ScreenHeight * 0.01),
                  Row(
                    children: [
                      SizedBox(width: ScreenWidth * 0.25),
                      Directionality(
                        textDirection: TextDirection.rtl,
                        child: getAgeText(),
                      ),
                      SizedBox(width: ScreenWidth * 0.13),
                      Directionality(
                        textDirection: TextDirection.rtl,
                        child: Text(
                          "$childGender",
                          textDirection: TextDirection.rtl,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      SizedBox(width: ScreenWidth * 0.1),
                      Directionality(
                        textDirection: TextDirection.rtl,
                        child: Text(
                          "$childHeight سم",
                          textDirection: TextDirection.rtl,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  getAgeText() {
    //Convert timestamp type of data to DateTime
    DateTime childBirthday = DateTime.parse((widget.childbirthday).toString());
    //Calculate Age As years: 0, Months: 0, Days: 0
    DateDuration calcAge = AgeCalculator.age(childBirthday);

    String childAgeYears =(calcAge.toString().replaceAll(new RegExp(r'[^0-9]'), ''))[0];
    String childAgeMonths = (calcAge.toString().replaceAll(new RegExp(r'[^0-9]'), ''))[1];
    String str = '';
    try {
      if (int.parse(childAgeYears) > 10 ||
          int.parse(childAgeYears) == 1 ||
          int.parse(childAgeYears) == 2) {
        str = "$childAgeYears سنة";
      } else if (int.parse(childAgeYears) > 2 &&
          int.parse(childAgeYears) < 11) {
        str = "$childAgeYears سنوات";
      } else if (int.parse(childAgeYears) < 1) {
        if (int.parse(childAgeMonths) == 1 ||
            int.parse(childAgeMonths) == 11 ||
            int.parse(childAgeMonths) == 12 ||
            int.parse(childAgeMonths) == 0) {
          str = "$childAgeMonths شهر";
        } else {
          str = "$childAgeMonths شهور";
        }
      }
    } catch (error) {
      Text("error");
    }
    return Text(str,
        style: TextStyle(
            color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold));
  }
}

networkImg(String childImage, double ScreenWidth, double ScreenHeight) {
  try {
    return Image.network(
      childImage,
      width: ScreenWidth * 0.33,
      height: ScreenHeight * 0.15,
      fit: BoxFit.cover,
      frameBuilder:
          (BuildContext context, Widget child, int? frame, bool isAsyncLoaded) {
        return Padding(
          padding: EdgeInsets.all(1),
          child: child,
        );
      },
      loadingBuilder: (BuildContext context, Widget child,
          ImageChunkEvent? loadingProgress) {
        if (loadingProgress == null) return child;
        return Center(
          child: Text("جاري التحميل"),
        );
      },
      errorBuilder: (BuildContext context, Object error, StackTrace? st) {
        return Center(
          child: Text(
            "جاري التحميل",
            style: TextStyle(
                color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
          ),
        );
      },
    );
  } catch (error) {}
}
