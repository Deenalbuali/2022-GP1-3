class childrenList {
  String? childImagePath;
  String? childName;
  String? childID;
  int? zoneName;
  childrenList();
  Map<String, dynamic> toJson() =>
      {'height': zoneName, 'image': childImagePath, 'name': childName};

  childrenList.fromSnapshot(snapshot)
      : zoneName = snapshot.data()['height'],
        childName = snapshot.data()['name'],
        childID = snapshot.id,
        childImagePath = snapshot.data()['image'];
}
