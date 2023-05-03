import 'package:aerocode/controllers/space_controller.dart';
import 'package:aerocode/models/space_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

import 'package:aerocode/models/code_model.dart';

final _spaceCtr = Get.put(spaceController());
final _firestore = FirebaseFirestore.instance.collection("codes");

class codeController extends GetxController {
  Future<void> createCode({required String spaceID}) async {
    final codeData = codeModel(
      spaceID: spaceID,
      code: "// Start typing from here ...",
    );
    await _firestore.doc(spaceID).set(codeData.toMap());
  }

  Future<String> getCode({required String spaceID}) async {
    final codeDataMap = await _firestore.doc(spaceID).get();
    final codeDataModel = codeModel.fromMap(codeDataMap.data()!);
    if (codeDataMap.exists) {
      return codeDataModel.code;
    }
    return ('Unable to fetch code');
  }

  Future<void> updateContent(
      {required String newContent, required String spaceID}) async {
    final docRef = await _firestore.doc(spaceID);
    await docRef.update({'code': newContent});
  }
}