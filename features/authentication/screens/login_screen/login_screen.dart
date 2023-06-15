import 'package:flutter/material.dart';
import 'package:gcp/src/common_widgets/form/form_snackbar_widget.dart';
import 'package:gcp/src/constants/text_strings.dart';
import 'package:gcp/src/utils/theme/widget_themes/ebutton_theme.dart';
import 'package:gcp/src/utils/theme/widget_themes/text_theme.dart';
import 'package:get/get.dart';
import '../../../../common_widgets/form/form_footer_widget.dart';
import '../../../../constants/sizes.dart';
import '../../controllers/login_controller.dart';
import '../signup_screen/signup_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginForm();
}

class _LoginForm extends State<LoginScreen> {
  bool passwordVisible = false;
  final formKey = GlobalKey<FormState>();

  void _toggle() {
    setState(() {
      passwordVisible = !passwordVisible;
    });
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(LoginController());

    return SafeArea(
      child: Scaffold(
          body: SingleChildScrollView(
        child: Stack(
          children: [
            SizedBox(
                height: MediaQuery.of(context).size.height,
                child: Image.asset('assets/images/login_image.png',
                    fit: BoxFit.cover,
                    color: Colors.black12,
                    colorBlendMode: BlendMode.darken)),
            Container(
                margin: const EdgeInsets.only(top: 65.0, left: 45.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("LOGIN",
                        style: Theme.of(context).textTheme.copyright.copyWith(
                            fontWeight: FontWeight.w800,
                            color: const Color(0xffF8F8F8),
                            fontSize: 50.0,
                            shadows: <Shadow>[
                              const Shadow(
                                offset: Offset(3.0, 3.0),
                                blurRadius: 10.0,
                                color: Color.fromARGB(255, 0, 0, 0),
                              )
                            ])),
                  ],
                )),
            const SizedBox(height: tFormHeight - 10),
            Container(
                padding: const EdgeInsets.symmetric(vertical: 5.0),
                margin: const EdgeInsets.only(top: 130.0, left: 45.0, right: 45.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        const SizedBox(height: tFormHeight - 15),
                        PhysicalModel(
                          borderRadius: BorderRadius.circular(15),
                          color: Colors.green,
                          elevation: 20.0,
                          shadowColor: Colors.black,
                          child: TextFormField(
                            controller: controller.email,
                            decoration: InputDecoration(
                              errorStyle: const TextStyle(fontSize: 0.01),
                              filled: true,
                              fillColor: const Color(0xffF8F8F8),
                              prefixIcon: const Icon(Icons.email_outlined),
                              hintText: tEmail,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide: BorderSide.none,
                              ),
                            ),
                            validator: (String? value) {
                              if (value!.isEmpty) {
                                const FormSnackbar(
                                        title: "ERROR",
                                        msg: "이메일을 입력해주세요",
                                        backgroundColor: Colors.red,
                                        icon: Icons.error,
                                        iconColor: Colors.white)
                                    .showMsg();
                                return "";
                              }
                              return null;
                            },
                          ),
                        ),
                        const SizedBox(height: tFormHeight - 15),
                        PhysicalModel(
                          borderRadius: BorderRadius.circular(15),
                          color: Colors.green,
                          elevation: 20.0,
                          shadowColor: Colors.black,
                          child: TextFormField(
                            controller: controller.password,
                            obscureText: !passwordVisible,
                            decoration: InputDecoration(
                              errorStyle: const TextStyle(fontSize: 0.01),
                              filled: true,
                              fillColor: const Color(0xffF8F8F8),
                              prefixIcon: const Icon(Icons.password_outlined),
                              hintText: tPassword,
                              suffixIcon: IconButton(
                                icon: Icon(passwordVisible
                                    ? Icons.visibility
                                    : Icons.visibility_off),
                                onPressed: _toggle,
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide: BorderSide.none,
                              ),
                            ),
                            validator: (String? value) {
                              if (value!.isEmpty) {
                                const FormSnackbar(
                                        title: "ERROR",
                                        msg: "비밀번호를 입력해주세요",
                                        backgroundColor: Colors.red,
                                        icon: Icons.error,
                                        iconColor: Colors.white)
                                    .showMsg();
                                return "";
                              }
                              return null;
                            },
                          ),
                        ),
                        TextButton(
                            onPressed: () {
                              // ForgetPasswordScreen.buildShowModalBottomSheet(context);
                            },
                            child: Text(tForgetPassword,
                                style: Theme.of(context)
                                    .textTheme
                                    .content
                                    .copyWith(
                                        fontWeight: FontWeight.w800,
                                        color: Colors.white,
                                        fontSize: 15.0,
                                        shadows: <Shadow>[
                                      const Shadow(
                                        offset: Offset(3.0, 3.0),
                                        blurRadius: 10.0,
                                        color: Color.fromARGB(255, 0, 0, 0),
                                      )
                                    ]))),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                              style: Theme.of(context)
                                  .elevatedButtonTheme
                                  .green
                                  .copyWith(
                                    elevation:
                                        const MaterialStatePropertyAll<double>(
                                            20.0),
                                    shadowColor:
                                        const MaterialStatePropertyAll<Color>(
                                            Colors.black),
                                  ),
                              onPressed: () {
                                if (formKey.currentState!.validate()) {
                                  LoginController.instance.loginUser(
                                      controller.email.text.trim(),
                                      controller.password.text.trim());
                                }
                              },
                              child: Text(tLogin.toUpperCase())),
                        ),
                        const SizedBox(height: tFormHeight),
                        FormFooter(
                          explain: tLoginExplain,
                          title: tLoginInWithGoogle,
                          onTap: () {},
                        ),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                              style: Theme.of(context)
                                  .elevatedButtonTheme
                                  .green
                                  .copyWith(
                                    backgroundColor:
                                        const MaterialStatePropertyAll<Color>(
                                            Colors.orange),
                                    elevation:
                                        const MaterialStatePropertyAll<double>(
                                            20.0),
                                    shadowColor:
                                        const MaterialStatePropertyAll<Color>(
                                            Colors.black),
                                  ),
                              onPressed: () {
                                Get.to(() => const SignUpScreen());
                              },
                              child: const Text("회원가입")),
                        ),
                        const SizedBox(height: tFormHeight * 1),
                        Container(
                            alignment: const Alignment(0.0, 0.9),
                            child: Text(tAppCopyright,
                                style: Theme.of(context)
                                    .textTheme
                                    .copyright
                                    .copyWith(
                                        fontWeight: FontWeight.w800,
                                        color: Colors.white,
                                        shadows: <Shadow>[
                                      const Shadow(
                                        offset: Offset(2.0, 2.0),
                                        blurRadius: 10.0,
                                        color: Color.fromARGB(255, 0, 0, 0),
                                      )
                                    ]))),
                        const SizedBox(height: tFormHeight * 2),
                      ],
                    ))),
          ],
        ),
      )),
    );
  }
}
