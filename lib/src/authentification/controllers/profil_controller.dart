import 'package:flutter_application_1/src/authentification/models/user_model.dart';
import 'package:flutter_application_1/src/repository/authentification_repository/authentification_repository.dart';
import 'package:flutter_application_1/src/repository/user_repository/user_repository.dart';
import 'package:get/get.dart';

class ProfileController extends GetxController {
  static ProfileController get instance => Get.find();

  final _authRepo = Get.put(AuthentificationRepository());
  final _userRepo = Get.put(UserRepository());

  getUserData() async {
    final email = _authRepo.firebaseUser.value!.email;
    if (email != null) {
      return _userRepo.getUserDetails(email);
    } else {
      Get.snackbar("Error", "Login to continue");
    }
  }

  updatedatapassword(String password, String userId) async {
    await _userRepo.updateUserpassworddata(password, userId);
  }

  updatedataEmail(String newEmail, String userId) async {
    await _userRepo.updateUserEmaildata(newEmail, userId);
  }

  updatedata(UserModel user, String userID) async {
    await _userRepo.updateUserdata(user, userID);
  }

  getUserStat(String date, String id) async {
    final email = _authRepo.firebaseUser.value!.email;
    if (email != null) {
      return _userRepo.getStatsForDay(id, date);
    } else {
      Get.snackbar("Error", "Login to continue");
      return null;
    }
  }
}
