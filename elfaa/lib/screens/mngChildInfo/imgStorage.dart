// ignore_for_file: avoid_print
//import 'package:firebase_storage/firebase_storage.dart';
import 'dart:io';
import 'package:firebase_core/firebase_core.dart' as firebase_core;

class Storage {
//final storage = FirebaseStorage.instance;

Future<void> uploadFile(String filePath, String fileName) async {
File file = File(filePath);

try {
 // await storage.ref('/children-images/$fileName').putFile(file);
} on firebase_core.FirebaseException catch (e) {
  print(e);
  }
}

}
