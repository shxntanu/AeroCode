import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';

class codeModel {
  late String spaceID;
  late String code;

  codeModel({
    required this.spaceID,
    required this.code,
  });

  Map<String, dynamic> toMap() {
    return {
      'spaceID': spaceID,
      'code': code,
    };
  }

  factory codeModel.fromMap(Map<String, dynamic> iMap) {
    return codeModel(
      spaceID: iMap['spaceID'] ?? '',
      code: iMap['code'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory codeModel.fromJson(String source) =>
      codeModel.fromMap(json.decode(source));
}