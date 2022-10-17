import 'package:cloud_firestore/cloud_firestore.dart';
//import 'package:firebase_auth/firebase_auth.dart';
//import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class addChild extends StatefulWidget {
  @override
  State<addChild> createState() => _addChildState();
}
class _addChildState extends State<addChild> {
  final controllerName = TextEditingController();
  final controllerAge = TextEditingController();
  final controllerBirthday = TextEditingController();


  @override
  Widget build(BuildContext context) => Scaffold(
      backgroundColor: Color.fromARGB(255, 235, 234, 234),
      appBar: AppBar(
        title: Text(
          "Add new child",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.orange,
        centerTitle: true,
      ),
      body: ListView(
        padding: EdgeInsets.all(16),
        children: <Widget> [
          ElevatedButton(onPressed: (){},
           child: Text ("Add image")),
        TextField(
          controller: controllerName,
          decoration: decoration('Name'),
        ),
        const SizedBox(height: 24),
        TextField(
          controller: controllerAge,
          decoration: decoration('Age'),
          keyboardType: TextInputType.number,
        ),
  
        const SizedBox(height: 32,),
        ElevatedButton(
          child: Text('Add'),
          onPressed: (){
            final child = Child(
              name: controllerName.text,
              age: int.parse(controllerAge.text),
              birthday: DateTime.parse('2022-01-01')
            );

            addChild(child);

            Navigator.pop(context);
          },
        )
        ],
      ),
      );

  InputDecoration decoration(String label) =>
      InputDecoration(labelText: label, border: OutlineInputBorder());

  Future addChild (Child child) async {
    //Reference to document
    final docChild = FirebaseFirestore.instance.collection('parent').doc('Renad').collection('children').doc(child.name);


    final json = child.toJson();
    //Create doc and write data
    await docChild.set(json);
  }
}

class Child {
  final String name;
  final int age;
  final DateTime birthday;

  Child ({
    required this.name,
    required this.age,
    required this.birthday
});

Map<String, dynamic> toJson() => {
  'name':name,
  'age':age,
  'birthday':birthday
};
}
