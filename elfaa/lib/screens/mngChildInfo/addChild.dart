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
  

  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: const Color.fromARGB(255, 235, 234, 234),
        appBar: AppBar(
          title: const Text(
            "إضافة طفل جديد",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          backgroundColor: Colors.orange,
          centerTitle: true,
        ),
        body: ListView(
          padding: const EdgeInsets.all(16),
          children: <Widget>[
            const SizedBox(height: 30),
            childImg(),
            const SizedBox(height: 70),
            Directionality(
                textDirection: TextDirection.rtl,
                child: TextFormField(
                  textAlign: TextAlign.right,
                  controller: controllerName,
                  decoration: const InputDecoration(
                    suffixIcon:
                        Icon(Icons.child_care, color: Color(0xFFFD8601)),
                    labelText: "اسم الطفل",
                  ),
                  validator: (value) {
                    if (value!.isEmpty || controllerName.text.trim() == "") {
                      return "الحقل مطلوب";
                    }
                  },
                )),
                const SizedBox(height: 20),
                Directionality(
                textDirection: TextDirection.rtl,
                child: TextFormField(
                  textAlign: TextAlign.right,
                  controller: controllerBirthday,
                  decoration: const InputDecoration(
                    suffixIcon:
                        Icon(Icons.event, color: Color(0xFFFD8601)),
                    labelText: "تاريخ الميلاد",
                  ),
                  validator: (value) {
                    if (value!.isEmpty || controllerBirthday.text.trim() == "") {
                      return "الحقل مطلوب";
                    }
                  },
                )),
            const SizedBox(height: 20),
            Directionality(
                textDirection: TextDirection.rtl,
                child: TextFormField(
                  textAlign: TextAlign.right,
                  controller: controllerHeight,
                  decoration: const InputDecoration(
                    suffixIcon:
                        Icon(Icons.accessibility_new, color: Color(0xFFFD8601)),
                    labelText: "الطول",
                  ),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value!.isEmpty || controllerHeight.text.trim() == "") {
                      return "الحقل مطلوب";
                    }
                  },
                )),
            const SizedBox(
              height: 32,
            ),
            ElevatedButton(
              child: const Text('إضافة'),
              onPressed: () {
                final child = Child(
                    name: controllerName.text,
                    age: int.parse(controllerHeight.text),
                    birthday: DateTime.parse('2022-01-01'));

                addChild(child);

                Navigator.pop(context);
              },
            )
          ],
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
                  ? const AssetImage("assets/images/elfaa.png")
                  : FileImage(File(_imgFile!.path)) as ImageProvider),
          Positioned(
              bottom: 15,
              right: 15,
              child: InkWell(
                  onTap: () {
                    showModalBottomSheet(
                        context: context, builder: ((builder) => bottomImgPicker()));
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
        .doc(child.name);

    final json = child.toJson();
    //Create doc and write data
    await docChild.set(json);
  }
}

//child object
class Child {
  final String name;
  final int age;
  final DateTime birthday;

  Child({required this.name, required this.age, required this.birthday});

  Map<String, dynamic> toJson() =>
      {'name': name, 'age': age, 'birthday': birthday};
}
