import 'dart:ffi';

class childrenList {
  String? childImagePath;
  String? childName;
  String? childID;
  DateTime? childbirthday;
  int? childHeight;
  String? childGender;
  List? nots;
  childrenList();
  Map<String, dynamic> toJson() => {
        'image': childImagePath,
        'name': childName,
        'birthday': childbirthday,
        'height': childHeight,
        'gender': childGender,
        'notifications':nots
      };

  childrenList.fromSnapshot(snapshot)
      : childHeight = snapshot.data()['height'],
        childName = snapshot.data()['name'],
        childID = snapshot.id,
        childImagePath = snapshot.data()['image'],
        childbirthday = snapshot.data()['birthday'].toDate(),
        childGender = snapshot.data()['gender'],
        nots = snapshot.data()['notifications'];
}
