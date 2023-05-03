import 'package:aerocode/models/space_model.dart';
import 'package:get/get.dart';

class spaceController extends GetxController {
  
  late spaceModel _spaceInstance;
  late String _spaceID;

  bool _isAuthenticated = false;

  String get getSpaceID => _spaceID;
  bool get getAuthStatus => _isAuthenticated;

  void setSpaceID(String code) {
    _spaceID = code;
    update();
  }

  spaceModel get getSpaceData => _spaceInstance;

  void setSpaceData(spaceModel spaceInst) {
    _spaceInstance = spaceInst;
    update();
  }

  void setAuthStatus(bool value) {
    _isAuthenticated = value;
    update();
  }
}