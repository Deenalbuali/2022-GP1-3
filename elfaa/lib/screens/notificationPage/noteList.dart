import 'package:cloud_firestore/cloud_firestore.dart';

class noteList {
  String? childImagePath;
  String? childName;
  String? zone_name;
  DateTime? time;
  GeoPoint? location;
  noteList();
  Map<String, dynamic> toJson() => {
        'image': childImagePath,
        'name': childName,
        'time': time,
        'location': location,
        'zone_name': zone_name
      };

  noteList.fromSnapshot(snapshot)
      : zone_name = snapshot.data()['zone_name'],
        childName = snapshot.data()['name'],
        childImagePath = snapshot.data()['image'],
        time = snapshot.data()['time'].toDate(),
        location = snapshot.data()['location'];
}