import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:elfaa/alert_dialog.dart';
import 'package:elfaa/screens/Homepage/navPage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:elfaa/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart' hide TextDirection;
import 'package:flutter/services.dart';

class editChild extends StatefulWidget {
  const editChild(
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
  State<editChild> createState() => _editChildState();
}

class _editChildState extends State<editChild> {
  @override
  void initState() {
    childBirthday = DateTime.parse((widget.childbirthday).toString());
    year = childBirthday.year;
    month = childBirthday.month;
    day = childBirthday.day;
    birthday.text = '$year-$month-$day';
    childName.text = widget.childname;
    childHeight.text = (widget.childHeight).toString();
    childImage = widget.childImage;

    super.initState();
    getParent();
  }

  //profile image variables
  XFile? _img;
  final ImagePicker _picker = ImagePicker();
  String imgURL = '';

//globalKey
  final _formKey = GlobalKey<FormState>();

  //Loading for uploading
  bool isLoading = false;
  bool isProcessing = false;

  //Child Info to be retreived from database
  TextEditingController childName = TextEditingController();
  TextEditingController birthday = TextEditingController();
  String selectedGender = 'أنثى';
  TextEditingController childHeight = TextEditingController();
  late DateTime childBirthday;
  String childImage = '';
  int year = 0;
  int month = 0;
  int day = 0;

  //alert dialuge
  bool tappedYes = false;

  //get parent  ID
  String uid = '';
  Future<void> getParent() async {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    final User? user = await _auth.currentUser;

    setState(() {
      uid = user!.uid;
    });
  }

  @override
  Widget build(BuildContext context) {
    final double ScreenHeight = MediaQuery.of(context).size.height;
    final double ScreenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.arrow_forward_ios,
              color: Colors.white,
            ),
            onPressed: () => Navigator.of(context).pop(),
          )
        ],
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        elevation: 0,
        toolbarHeight: 90,
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
                SizedBox(height: ScreenHeight * 0.03),
                Directionality(
                    textDirection: TextDirection.rtl,
                    child: TextFormField(
                      textAlign: TextAlign.right,
                      controller: childName,
                      decoration: const InputDecoration(
                        suffixIcon:
                            Icon(Icons.child_care, color: kOrangeColor),
                        labelText: "اسم الطفل",
                        hintText: "مثال: أسماء",
                      ),
                      validator: (value) {
                        if (value!.isEmpty || childName.text.trim() == "") {
                          return "الحقل مطلوب";
                        }
                        return null;
                      },
                    )),
                SizedBox(height: ScreenHeight * 0.02),
                Directionality(
                    textDirection: TextDirection.rtl,
                    child: TextFormField(
                      textAlign: TextAlign.right,
                      controller: childHeight,
                      keyboardType: TextInputType.number,
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.digitsOnly
                      ],
                      decoration: const InputDecoration(
                        suffixIcon: Icon(Icons.accessibility_new,
                            color: kOrangeColor),
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
                SizedBox(height: ScreenHeight * 0.02),
                Directionality(
                  textDirection: TextDirection.rtl,
                  child: DropdownButtonFormField(
                    decoration: const InputDecoration(
                      suffixIcon: Icon(Icons.escalator_warning,
                          color: kOrangeColor),
                      labelText: "الجنس",
                    ),
                    onChanged: (val) {
                      setState(() {
                        selectedGender = val.toString();
                      });
                    },
                    value: selectedGender,
                    items: const [
                      DropdownMenuItem(
                        child: Text("ذكر"),
                        value: 'ذكر',
                      ),
                      DropdownMenuItem(
                        child: Text("أنثى"),
                        value: "أنثى",
                      )
                    ],
                    validator: (value) {
                      if (value!.isEmpty || childHeight.text.trim() == "") {
                        return "الحقل مطلوب";
                      }
                      return null;
                    },
                  ),
                ),
                SizedBox(height: ScreenHeight * 0.02),
                Directionality(
                    textDirection: TextDirection.rtl,
                    child: TextFormField(
                        textAlign: TextAlign.right,
                        controller: birthday,
                        decoration: const InputDecoration(
                          suffixIcon: Icon(Icons.calendar_today,
                              color: kOrangeColor),
                          labelText: "تاريخ الميلاد",
                          hintText: "اختر من التقويم",
                        ),
                        validator: (value) {
                          if (value!.isEmpty || birthday.text.trim() == "") {
                            return "الحقل مطلوب";
                          }
                          return null;
                        },
                        readOnly: true,
                        onTap: () async {
                          DateTime? pickedDate = await showDatePicker(
                            context: context,
                            initialDate: DateTime(childBirthday.year,
                                childBirthday.month, childBirthday.day),
                            firstDate: DateTime(1920),
                            lastDate: DateTime.now(),
                            builder: (context, child) {
                              return Theme(
                                data: ThemeData.light().copyWith(
                                  primaryColor: kPrimaryColor,
                                  colorScheme: const ColorScheme.light(
                                      primary: kPrimaryColor),
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
                SizedBox(height: ScreenHeight * 0.02),
                SizedBox(height: ScreenHeight * 0.02),
                SizedBox(
                  width: ScreenWidth,
                  child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.grey,
                          textStyle: const TextStyle(
                            fontSize: 22,
                            color: Color.fromARGB(255, 255, 255, 255),
                          )),
                      child: const Text('تغيير جهاز التتبع')),
                ),
                SizedBox(height: ScreenHeight * 0.02),
                ElevatedButton(
                    onPressed: isProcessing
                        ? null
                        : () async {
                            final action = await AlertDialogs.yesCancelDialog(
                                context,
                                ' بيانات الطفل ',
                                'هل أنت متأكد من تعديل بيانات الطفل؟');
                            if (!mounted) return;
                            if (action == DialogsAction.yes) {
                              setState(() => tappedYes = true);
                              if (!mounted) return;
                              //if yes
                              if (_formKey.currentState!.validate()) {
                                setState(() {
                                  isLoading = true;
                                  isProcessing = true;
                                });
                                Future.delayed(Duration(seconds: 12), () {
                                  try {
                                    final docChild = FirebaseFirestore.instance
                                        .collection('users')
                                        .doc(uid)
                                        .collection('children')
                                        .doc(widget.childID);
                                    //update child info
                                    docChild.update({
                                      'image':
                                          imgURL.isEmpty ? childImage : imgURL,
                                      'name': childName.text,
                                      'gender': selectedGender,
                                      'height': int.parse(childHeight.text),
                                      'birthday': DateTime.parse(birthday.text)
                                    });
                                  } on FirebaseException catch (e) {
                                    // Caught an exception from Firebase.
                                    print(
                                        "Failed with error '${e.code}': ${e.message}");
                                  }
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => NavPage()),
                                  );
                                  setState(() {
                                    isLoading = false;
                                    isProcessing = false;
                                  });
                                });
                              }
                            } else {
                              setState(() => tappedYes = false);
                              if (!mounted) return;
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
                SizedBox(height: ScreenHeight * 0.02),
                Directionality(
                  textDirection: TextDirection.rtl,
                  child: ElevatedButton.icon(
                    icon: Icon(
                      Icons.delete,
                      color: Color(0xFF9C0000),
                    ),
                    style: ElevatedButton.styleFrom(
                      textStyle: TextStyle(fontSize: 22),
                      shadowColor: Color.fromARGB(255, 0, 0, 0),
                      elevation: 0,
                      backgroundColor: Color(0xFFFFEEEE),
                      shape: const StadiumBorder(),
                      maximumSize: const Size(180, 56),
                      minimumSize: const Size(180, 56),
                    ),
                    label: Text(
                      '  حذف الطفل  ',
                      style: TextStyle(color: Color(0xFF9C0000), fontSize: 20),
                    ),
                    onPressed: () async {
                      final action = await AlertDialogs.yesCancelDialog(
                          context, 'حذف الطفل', 'هل أنت متأكد من حذف الطفل؟');
                      if (!mounted) return;
                      if (action == DialogsAction.yes) {
                        setState(() => tappedYes = true);
                        if (!mounted) return;
                        //delete child here
                        final docChild = FirebaseFirestore.instance
                            .collection('users')
                            .doc(uid)
                            .collection('children')
                            .doc(widget.childID);
                        docChild.delete();
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => NavPage()),
                        );
                      } else {
                        setState(() => tappedYes = false);
                        if (!mounted) return;
                      }
                    },
                  ),
                ),
                SizedBox(height: ScreenHeight * 0.04),
              ],
            ),
          ),
        ),
      ),
    );
  }
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
            "choose image",
            style: TextStyle(fontSize: 20),
          ),
          SizedBox(height: 20),
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
}
