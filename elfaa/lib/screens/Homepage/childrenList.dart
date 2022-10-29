class childrenList {
  String? childImagePath;
  String? childName;
  String? zoneName;
  childrenList();
  Map<String, dynamic> toJson() =>
      {'height': zoneName, 'image': childImagePath, 'name': childName};

  childrenList.fromSnapshot(snapshot)
      : childImagePath = snapshot.data()['image'],
        childName = snapshot.data()['name'],
        zoneName = snapshot.data()['height'];
}
