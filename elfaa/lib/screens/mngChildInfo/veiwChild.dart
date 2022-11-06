import 'package:age_calculator/age_calculator.dart';
import 'package:flutter/material.dart';
import 'package:elfaa/constants.dart';
import 'package:elfaa/screens/mngChildInfo/editChild.dart';

class viewChild extends StatefulWidget {
  const viewChild(
      {super.key,
      required this.childID,
      required this.childImage,
      required this.childname,
      required this.childbirthday,
      required this.childHeight,
      required this.childGender});
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
    final String childName = widget.childname;
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
        title: Text(
          childName,
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
                        childGender: childGender)),
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
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: ScreenHeight * 0.53,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
                  image: DecorationImage(
                      image: AssetImage("assets/images/oneChild.jpg"),
                      fit: BoxFit.cover)),
            ),
            Container(
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(28),
                    topRight: Radius.circular(28)),
                color: kPrimaryColor,
              ),
              child: Padding(
                padding: const EdgeInsets.only(top: 15, bottom: 50),
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
                        SizedBox(width: ScreenWidth * 0.1),
                      ],
                    ),
                    SizedBox(height: ScreenHeight * 0.03),
                    Directionality(
                      textDirection: TextDirection.rtl,
                      child: ElevatedButton.icon(
                        icon: Icon(
                          Icons.campaign,
                          color: Color.fromARGB(255, 255, 255, 255),
                        ),
                        style: ElevatedButton.styleFrom(
                          textStyle: TextStyle(fontSize: 22),
                          shadowColor: Color.fromARGB(255, 0, 0, 0),
                          elevation: 0,
                          backgroundColor: Colors.grey,
                          shape: const StadiumBorder(),
                          maximumSize: const Size(180, 56),
                          minimumSize: const Size(180, 56),
                        ),
                        label: Text(
                          ' إنشاء بلاغ   ',
                          style: TextStyle(
                              color: Color.fromARGB(255, 255, 255, 255),
                              fontSize: 20),
                        ),
                        onPressed: () {},
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  getAgeText() {
    //Convert timestamp type of data to DateTime
    DateTime childBirthday = DateTime.parse((widget.childbirthday).toString());
    //Calculate Age As years: 0, Months: 0, Days: 0
    DateDuration calcAge = AgeCalculator.age(childBirthday);

    int childAgeYears = calcAge.years;
    int childAgeMonths =calcAge.months;
    String str = '';
    try {
      if (childAgeYears > 10 ||
          childAgeYears == 1 ||
          childAgeYears == 2) {
        str = "$childAgeYears سنة";
      } else if (childAgeYears > 2 &&
          childAgeYears < 11){
        str = "$childAgeYears سنوات";
      } else if (childAgeYears < 1) {
        if (childAgeMonths == 1 ||
            childAgeMonths == 11 ||
            childAgeMonths == 12 ||
            childAgeMonths == 0) {
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
          child: Text("جاري التحميل",
          style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),),
          
        );
      },
      errorBuilder: (BuildContext context, Object error, StackTrace? st) {
        return Container(
          width: ScreenWidth * 0.33,
          height: ScreenHeight * 0.15,
          child: Center(
            child: Text(
              "حدث خطأ",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
          ),
        );
      },
    );
  } catch (error) {}
}
