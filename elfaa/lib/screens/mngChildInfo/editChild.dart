import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:age_calculator/age_calculator.dart';
import 'package:elfaa/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart' hide TextDirection;

class editChild extends StatefulWidget {
  const editChild({super.key});

  @override
  State<editChild> createState() => _editChildState();
}

class _editChildState extends State<editChild> {
//profile image variables
  XFile? _img;
  final ImagePicker _picker = ImagePicker();
  String imgURL = '';

//globalKey
  final _formKey = GlobalKey<FormState>();

  //Loading for uploading
  bool isLoading = false;

  //Child Info to be retreived from database
  TextEditingController childName = TextEditingController();
  TextEditingController birthday = TextEditingController();
  late DateTime childBirthday;
  TextEditingController childHeight = TextEditingController();
  String childImage='';

  Future<void> getEDITABLEChild() async {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    final User? user = await _auth.currentUser;
    final uid = user!.uid;
    await FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .collection('children')
        .doc('CiQbU3gkuwde5vcBjPKf')
        .get()
        .then((DocumentSnapshot<Map<String, dynamic>> snapshot) {
      //Convert timestamp type of data to DateTime
       childBirthday =
         DateTime.parse(snapshot['birthday'].toDate().toString());
         int year =childBirthday.year;
         int month =childBirthday.month;
         int day = childBirthday.day;
      //birthday.text =(snapshot['birthday']).toString();
     
      childName.text = snapshot['name'];
      //Age numbers extraction as three digits String "000" for later presentation
      //Extract each of years and months
      //childAgeYears.text = (calcAge.toString().replaceAll(new RegExp(r'[^0-9]'), ''))[0];
      // childAgeMonths.text = (calcAge.toString().replaceAll(new RegExp(r'[^0-9]'), ''))[1];

      childHeight.text = (snapshot['height']).toString();
      childImage = snapshot['image'];
      birthday.text = '$year-$month-$day';
    });
  }

  @override
  void initState() {
    getEDITABLEChild();
    super.initState();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.transparent,
          elevation: 0,
          toolbarHeight: 90,
          leading: const BackButton(color: Colors.white),
          title: const Text(
            "تعديل بيانات الطفل",
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
          ),
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
          child: Form(
            key: _formKey,
            child: Padding(
              padding: EdgeInsets.fromLTRB(
                  20, MediaQuery.of(context).size.height * 0.04, 20, 0),
              child: Column(
                children: <Widget>[
                  childImg(),
                  const SizedBox(height: 40),
                  Directionality(
                      textDirection: TextDirection.rtl,
                      child: TextFormField(
                        textAlign: TextAlign.right,
                        controller: childName,
                        decoration: const InputDecoration(
                          suffixIcon:
                              Icon(Icons.child_care, color: Color(0xFFFD8601)),
                          labelText: "اسم الطفل",
                          hintText: "مثال: أسماء",
                        ),
                        validator: (value) {
                          if (value!.isEmpty ||
                              childName.text.trim() == "") {
                            return "الحقل مطلوب";
                          }
                          return null;
                        },
                      )),
                  const SizedBox(height: 20),
                  Directionality(
                      textDirection: TextDirection.rtl,
                      child: TextFormField(
                          textAlign: TextAlign.right,
                          controller: birthday,
                          decoration: const InputDecoration(
                            suffixIcon: Icon(Icons.calendar_today,
                                color: Color(0xFFFD8601)),
                            labelText: "تاريخ الميلاد",
                            hintText: "اختر من التقويم",
                          ),
                          validator: (value) {
                            if (value!.isEmpty ||
                                birthday.text.trim() == "") {
                              return "الحقل مطلوب";
                            }
                            return null;
                          },
                          readOnly: true,
                          onTap: () async {
                            DateTime? pickedDate = await showDatePicker(
                              context: context,
                              initialDate: DateTime(childBirthday.year, childBirthday.month, childBirthday.day),
                              firstDate: DateTime(1920),
                              lastDate: DateTime.now(),
                              builder: (context, child) {
                                return Theme(
                                  data: ThemeData.light().copyWith(
                                    primaryColor: const Color(0xFF429EB2),
                                    colorScheme: const ColorScheme.light(
                                        primary: Color(0xFF429EB2)),
                                    buttonTheme: const ButtonThemeData(
                                        textTheme: ButtonTextTheme.primary),
                                  ),
                                  child: child!,
                                );
                              },
                            );

                            if (pickedDate != null) {
                              String formattedDate =
                                  DateFormat('yyyy-MM-dd').format(pickedDate);
                              setState(() {
                                birthday.text =
                                    formattedDate; //set output date to TextField value.
                              });
                            }
                          })),
                  const SizedBox(height: 20),
                  Directionality(
                      textDirection: TextDirection.rtl,
                      child: TextFormField(
                        textAlign: TextAlign.right,
                        controller: childHeight,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          suffixIcon: Icon(Icons.accessibility_new,
                              color: Color(0xFFFD8601)),
                          labelText: "الطول",
                          hintText: "بالسنتيمترات",
                        ),
                        validator: (value) {
                          if (value!.isEmpty || childHeight.text.trim() == "") {
                            return "الحقل مطلوب";
                          }
                          return null;
                        },
                      )),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: 400,
                    child: ElevatedButton(
                        onPressed: null,
                        style: ElevatedButton.styleFrom(
                            textStyle: const TextStyle(fontSize: 22)),
                        child: const Text('تغيير جهاز التتبع')),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                      onPressed: () async {
                        if (_img == null) {
                          ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('يرجى اختيار صورة')));
                          return;
                        }

                        if (_formKey.currentState!.validate()) {
                          if (imgURL.isEmpty) {
                            setState(() {
                              isLoading = true;
                            });
                          }
                          Future.delayed(Duration(seconds: 12), () {
                            final child = Child(
                                image: imgURL,
                                name: childName.text,
                                height: int.parse(childHeight.text),
                                birthday:
                                    DateTime.parse(birthday.text));
                            addChild(child);
                            Navigator.pop(context);
                            setState(() {
                              isLoading = false;
                            });
                          });
                        }
                      },
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(const Color(0xFF429EB2)),
                      ),
                      child: isLoading
                          ? CircularProgressIndicator(
                              color: Colors.white,
                            )
                          : const Text('حفظ التعديلات')),
                          SizedBox(
                            height: 20
                          ),
                  ElevatedButton(
                      onPressed: () async {
                        if (_img == null) {
                          ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('يرجى اختيار صورة')));
                          return;
                        }
                      },
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(Color.fromARGB(255, 205, 0, 0)),
                      ),
                      child: isLoading
                          ? CircularProgressIndicator(
                              color: Colors.white,
                            )
                          : const Text(' حذف الطفل')),
                ],
              ),
            ),
          ),
        ),
      );
  //-----------------Rero's Helping Methods--------------------------------//

  //Adding child's profile picture
  childImg() {
    return Center(
      child: Stack(
        children: <Widget>[
          CircleAvatar(
              radius: 80,
              backgroundImage: _img == null
                  ? NetworkImage(childImage)
                  : FileImage(File(_img!.path)) as ImageProvider),
          Positioned(
              bottom: 15,
              right: 15,
              child: InkWell(
                  onTap: () {
                    showModalBottomSheet(
                        context: context,
                        builder: ((builder) => bottomImgPicker()));
                  },
                  child: const Icon(Icons.camera_alt,
                  color: Color.fromARGB(255, 22, 147, 193), size: 28)))
        ],
      ),
    );
  }

//bottom container of image source options
  bottomImgPicker() {
    return Container(
      height: 100,
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Column(
        children: <Widget>[
          const Text(
            "chooose image",
            style: TextStyle(fontSize: 20),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextButton.icon(
                  icon: const Icon(Icons.camera),
                  onPressed: () {
                    takePhoto(ImageSource.camera);
                  },
                  label: const Text("Camera")),
              TextButton.icon(
                  icon: const Icon(Icons.image),
                  onPressed: () {
                    takePhoto(ImageSource.gallery);
                  },
                  label: const Text("Gallary"))
            ],
          )
        ],
      ),
    );
  }

//Getting the picture from the mobile camera
  void takePhoto(ImageSource source) async {
    final image = await _picker.pickImage(source: source);
    if (image == null) return;
    String uniqueFileName = DateTime.now().millisecond.toString();

    setState(() {
      _img = image;
    });

    Reference refRoot = FirebaseStorage.instance.ref();
    Reference refDir = refRoot.child('children-images');

    Reference refImg = refDir.child(uniqueFileName);
    try {
      //store the file
      await refImg.putFile(File(_img!.path));
      //succedss: get the url
      imgURL = await refImg.getDownloadURL();
    } catch (e) {
      //error report
    }
  }

  InputDecoration decoration(String label) =>
      InputDecoration(labelText: label, border: const OutlineInputBorder());

  //adding child doc to a parent doc in the firestore database
  Future addChild(Child child) async {
    //Reference to document
    final docChild = FirebaseFirestore.instance
        .collection('users')
        .doc()
        .collection('children')
        .doc();

    final json = child.toJson();
    //Create doc and write data
    await docChild.set(json);
  }
}

//child class
class Child {
  final String image;
  final String name;
  final int height;
  final DateTime birthday;

  Child(
      {required this.image,
      required this.name,
      required this.height,
      required this.birthday});

  Map<String, dynamic> toJson() =>
      {'image': image, 'name': name, 'height': height, 'birthday': birthday};
}