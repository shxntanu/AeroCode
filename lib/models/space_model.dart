import 'dart:convert';

class spaceModel {
  
  final String spaceID;
  final String spacePass;
  final String timeStamp;

  spaceModel({required this.spaceID, required this.spacePass, required this.timeStamp});

  Map<String, dynamic> toMap() {
    return {
      "spaceID": spaceID,
      "spacePass": spacePass,
      "timeStamp": timeStamp,
    };
  }

  factory spaceModel.fromMap(Map<String, dynamic> iMap) {
    return spaceModel(
      spaceID: iMap['spaceID'],
      spacePass: iMap['spacePass'],
      timeStamp: iMap['timeStamp'],
    );
  }

  String toJson() => json.encode(toMap());
  factory spaceModel.from(String source) =>
      spaceModel.fromMap(json.decode(source));

}