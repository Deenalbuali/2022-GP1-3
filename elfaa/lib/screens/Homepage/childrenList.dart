class childrenList {
  //String? childImagePath;
  String? childName;
  int? zoneName;
  childrenList();
  Map<String, dynamic> toJson() => {'height': zoneName, 'name': childName};

  childrenList.fromSnapshot(snapshot)
      : childName = snapshot.data()['name'],
        zoneName = snapshot.data()['height'];
}
