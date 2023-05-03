import 'package:aerocode/controllers/space_controller.dart';
import 'package:aerocode/models/space_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

final _spaceCtr = Get.put(spaceController());
final _firestore = FirebaseFirestore.instance;

class backendController extends GetxController {

  Future<void> createSpaceInst(String _name, String _pass) async {
    final spaceData = spaceModel(
      spaceID: _name,
      spacePass: _pass,
      timeStamp: DateTime.now().toIso8601String(),
    );
    _spaceCtr.setSpaceData(spaceData);
    await _firestore.collection("space").doc(_name).set(spaceData.toMap());
  }

  // Future<dynamic> joinSpaceInst(String _name, String _pass) async {
  //   final spaceData = await _firestore.collection("space").doc(_name).get();
  //   final spaceInst = spaceModel.fromMap(spaceData.data()!);
  //   _spaceCtr.setSpaceData(spaceInst);
  //   if (spaceData.exists) {
  //     bool isAuth = (spaceInst.spacePass == _pass);
  //     return isAuth;
  //   }
  //   return "No such space has been created";
  // }

   Future<dynamic> joinSpaceInst(String _name, String _pass) async {
    final spaceData = await _firestore.collection("space").doc(_name).get();
    if (spaceData.exists) {
      final spaceInst = spaceModel.fromMap(spaceData.data()!);
      _spaceCtr.setSpaceData(spaceInst);
      bool isAuth = (spaceInst.spacePass == _pass);
      return isAuth;
    }
    else {
      return "No such space has been created";
    }
  }
}