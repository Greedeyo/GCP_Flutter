import 'package:flutter/material.dart';
import 'package:gcp/src/repository/authentication_repository/authentication_repository.dart';
import 'package:get/get.dart';

class SignUpController extends GetxController {
  static SignUpController get instance => Get.find();

  final email = TextEditingController();
  final password = TextEditingController();
  final fullName = TextEditingController();
  final phoneNo = TextEditingController();

  void registerUser(
      String email, String password, String fullName, String phoneNo) {
    AuthenticationRepository.instance
        .createUserWithEmailAndPassword(email, password, fullName, phoneNo);
  }
}
