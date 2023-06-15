
import 'package:gcp/src/repository/user_repository/user_repository.dart';
import 'package:get/get.dart';
import '../../../repository/authentication_repository/authentication_repository.dart';

class DataController extends GetxController {
  static DataController get instance => Get.find();

  final _authRepo = Get.put(AuthenticationRepository());
  final _userRepo = Get.put(UserRepository());

  getUserData() async {
    final email = _authRepo.firebaseUser.value?.email;
    if(email != null){
      return _userRepo.getUserDetails(email);
    } else {
      Get.snackbar("에러", "로그인을 진행하세요");
    }
  }
}