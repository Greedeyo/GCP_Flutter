
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gcp/src/features/authentication/screens/login_screen/login_screen.dart';
import 'package:gcp/src/repository/authentication_repository/exceptions/signup_email_password_failure.dart';
import 'package:get/get.dart';
import '../../common_widgets/form/form_snackbar_widget.dart';
import '../../features/authentication/models/user_model.dart';
import '../../features/authentication/screens/mail_verification_screen/mail_verification_screen.dart';
import '../../features/authentication/screens/main_screen/main_screen.dart';
import '../user_repository/user_repository.dart';
import 'exceptions/login_email_password_failure.dart';

class AuthenticationRepository extends GetxController {
  static AuthenticationRepository get instance => Get.find();

  final _auth = FirebaseAuth.instance;
  late final Rx<User?> firebaseUser;
  final userRepo = Get.put(UserRepository());

  @override
  void onReady() {
    firebaseUser = Rx<User?>(_auth.currentUser);
    firebaseUser.bindStream(_auth.userChanges());
    ever(firebaseUser, setInitialScreen);
  }

  setInitialScreen(User? user) {
    user == null
      ? Get.offAll(() => const LoginScreen())
      : user.emailVerified
        ? Get.offAll(() => const MainScreen())
        : Get.offAll(() => const MailVerification());
  }

  Future<void> createUserWithEmailAndPassword(String email, String password, String fullName, String phoneNo) async {
    try {
      await _auth.createUserWithEmailAndPassword(email: email, password: password);
      await setInitialScreen(firebaseUser.value);

      final user = UserModel(
        email: email,
        password: password,
        fullName: fullName,
        phoneNo: phoneNo,
      );

      createUserDB(user);

      Get.closeAllSnackbars();

    } on FirebaseAuthException catch(e){
      final ex = SignUpWithEmailAndPasswordFailure.code(e.code);

      FormSnackbar(
          title: "ERROR",
          msg: ex.message,
          backgroundColor: Colors.red,
          icon: Icons.error,
          iconColor: Colors.white
      ).showMsg();

      throw ex;
    } catch (_){
      const ex = SignUpWithEmailAndPasswordFailure();
      throw ex;
    }
  }

  Future<void> loginWithEmailAndPassword(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      await setInitialScreen(firebaseUser.value);
    } on FirebaseAuthException catch(e){
      final ex = LoginWithEmailAndPasswordFailure.code(e.code);

      FormSnackbar(
          title: "ERROR",
          msg: ex.message,
          backgroundColor: Colors.red,
          icon: Icons.error,
          iconColor: Colors.white
      ).showMsg();

      throw ex;
    } catch (_) {
      const ex = LoginWithEmailAndPasswordFailure();
      throw ex;
    }
  }

  Future<void> sendEmailVerification() async {
    try {
      _auth.currentUser?.sendEmailVerification();
    } on FirebaseAuthException catch (e) {
      final ex = SignUpWithEmailAndPasswordFailure.code(e.code);
      throw ex.message;
    } catch (_) {
      const ex = SignUpWithEmailAndPasswordFailure();
      throw ex.message;
    }
  }

  Future<void> createUserDB(UserModel user) async {
    await userRepo.createUserDB(user);
  }

  Future<void> logout() async => await _auth.signOut();
}