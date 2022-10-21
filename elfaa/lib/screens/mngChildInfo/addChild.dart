import 'dart:ffi';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

//import 'package:firebase_auth/firebase_auth.dart';
//import 'package:firebase_core/firebase_core.dart';
class addChild extends StatefulWidget {
  @override
  State<addChild> createState() => _addChildState();
}

class _addChildState extends State<addChild> {
//profile image variables
  PickedFile? _imgFile;
  final ImagePicker _picker = ImagePicker();
//information form controllers
  final controllerName = TextEditingController();
  final controllerBirthday = TextEditingController();
  final controllerHeight = TextEditingController();

  TextEditingController email = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: const Color(0xFFf5f5f5),
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.transparent,
          elevation: 0,
          toolbarHeight: 90,
          leading: BackButton(color: Colors.white),
          title: Text(
            "إضافة طفل جديد",
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
          ),
          centerTitle: true,
          flexibleSpace: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(28),
                      bottomRight: Radius.circular(28)),
                  gradient: LinearGradient(
                    colors: [
                      Color(0xFF429EB2),
                      Color.fromARGB(255, 131, 165, 173)
                    ],
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                  ))),
        ),
        body: Container(
          child: SingleChildScrollView(
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
                          controller: controllerName,
                          decoration: const InputDecoration(
                            suffixIcon: Icon(Icons.child_care,
                                color: Color(0xFFFD8601)),
                            labelText: "اسم الطفل",
                          ),
                          validator: (value) {
                            if (value!.isEmpty ||
                                controllerName.text.trim() == "") {
                              return "الحقل مطلوب";
                            }
                          },
                        )),
                    const SizedBox(height: 20),
                    Directionality(
                        textDirection: TextDirection.rtl,
                        child: TextFormField(
                          textAlign: TextAlign.right,
                          controller: email,
                          decoration: const InputDecoration(
                            suffixIcon:
                                Icon(Icons.event, color: Color(0xFFFD8601)),
                            labelText: "تاريخ الميلاد",
                            hintText: "00-00-0000",
                          ),
                          validator: (value) {
                            if (value!.isEmpty || email.text.trim() == "") {
                              return "الحقل مطلوب";
                            } else if (value.length != 10) {
                              return "يجب ادخال 10 خانات ";
                            }
                          },
                        )),
                    const SizedBox(height: 20),
                    Directionality(
                        textDirection: TextDirection.rtl,
                        child: TextFormField(
                          textAlign: TextAlign.right,
                          controller: controllerHeight,
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                            suffixIcon: Icon(Icons.accessibility_new,
                                color: Color(0xFFFD8601)),
                            labelText: "الطول",
                          ),
                          validator: (value) {
                            if (value!.isEmpty ||
                                controllerHeight.text.trim() == "") {
                              return "الحقل مطلوب";
                            }
                          },
                        )),
                    const SizedBox(height: 40),
                    ElevatedButton(
                      child: const Text('إضافة'),
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          final child = Child(
                              name: controllerName.text,
                              height: int.parse(controllerHeight.text),
                              birthday: DateTime.parse('2022-01-01'));

                          addChild(child);

                          Navigator.pop(context);
                        }
                      },
                    ),
                  ],
                ),
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
              backgroundImage: _imgFile == null
                  ? const AssetImage("assets/images/child-img.jpg")
                  : FileImage(File(_imgFile!.path)) as ImageProvider),
          Positioned(
              bottom: 15,
              right: 15,
              child: InkWell(
                  onTap: () {
                    showModalBottomSheet(
                        context: context,
                        builder: ((builder) => bottomImgPicker()));
                  },
                  child: Icon(Icons.camera_alt,
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
    final pickedFile = await _picker.getImage(source: source);
    setState(() {
      _imgFile = pickedFile;
    });
  }

  InputDecoration decoration(String label) =>
      InputDecoration(labelText: label, border: const OutlineInputBorder());

  //adding child doc to a parent doc in the firestore database
  Future addChild(Child child) async {
    //Reference to document
    final docChild = FirebaseFirestore.instance
        .collection('parent')
        .doc('Renad')
        .collection('children')
        .doc();

    final json = child.toJson();
    //Create doc and write data
    await docChild.set(json);
  }
}

//child class
class Child {
  final String name;
  final int height;
  final DateTime birthday;

  Child({required this.name, required this.height, required this.birthday});

  Map<String, dynamic> toJson() =>
      {'name': name, 'height': height, 'birthday': birthday};
}
