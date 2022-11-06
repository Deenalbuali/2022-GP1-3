import 'package:cloud_firestore/cloud_firestore.dart';

class noteList {
  String? zone_name;
  DateTime? time;
  GeoPoint? location;
  String? childID;
  noteList();
  Map<String, dynamic> toJson() => {
        'child_ID': childID,
        'time': time,
        'location': location,
        'zone_name': zone_name
      };

  noteList.fromSnapshot(snapshot)
      : zone_name = snapshot.data()['zone_name'],
        childID = snapshot.data()['child_ID'],
        time = snapshot.data()['time'].toDate(),
        location = snapshot.data()['location'];
}
