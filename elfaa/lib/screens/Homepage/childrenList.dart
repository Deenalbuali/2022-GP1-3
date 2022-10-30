class childrenList {
  String? childImagePath;
  String? childName;
  int? zoneName;
  childrenList();
  Map<String, dynamic> toJson() =>
      {'height': zoneName, 'image': childImagePath, 'name': childName};

  childrenList.fromSnapshot(snapshot)
      : zoneName = snapshot.data()['height'],
        childName = snapshot.data()['name'],
        childImagePath = snapshot.data()['image'];
}
