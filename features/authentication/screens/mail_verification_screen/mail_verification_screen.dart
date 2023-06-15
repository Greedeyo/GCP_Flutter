import 'package:flutter/material.dart';
import 'package:gcp/src/constants/text_strings.dart';
import 'package:gcp/src/utils/theme/widget_themes/ebutton_theme.dart';
import 'package:gcp/src/utils/theme/widget_themes/text_theme.dart';
import 'package:get/get.dart';
import '../../../../common_widgets/form/form_error_widget.dart';
import '../../../../common_widgets/form/form_header_widget.dart';
import '../../../../common_widgets/form/form_loading_widget.dart';
import '../../../../constants/image_strings.dart';
import '../../../../constants/sizes.dart';
import '../../../../repository/authentication_repository/authentication_repository.dart';
import '../../../core/controllers/data_controller.dart';
import '../../controllers/mail_verification_controller.dart';
import '../../models/user_model.dart';

class MailVerification extends StatefulWidget {
  const MailVerification({Key? key}) : super(key: key);

  @override
  State<MailVerification> createState() => _MailVerificationForm();
}

class _MailVerificationForm extends State<MailVerification> {
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(MailVerificationController());
    final dataController = Get.put(DataController());

    return SafeArea(
      child: Scaffold(
          body: SingleChildScrollView(
        child: FutureBuilder(
            future: dataController.getUserData(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.hasData) {
                  UserModel userData = snapshot.data as UserModel;
                  return Stack(
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
                              Text("Verification",
                                  style: Theme.of(context)
                                      .textTheme
                                      .copyright
                                      .copyWith(
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
                      Container(
                        padding: const EdgeInsets.symmetric(vertical: 5.0),
                        margin: const EdgeInsets.only(
                            top: 155.0, left: 45.0, right: 45.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const FormHeader(
                              image: tForgetPasswordImage,
                              crossAxisAlignment: CrossAxisAlignment.center,
                            ),
                            const SizedBox(height: 30.0),
                            Text("${userData.email} 로",
                                style: Theme.of(context)
                                    .textTheme
                                    .content
                                    .copyWith(
                                        fontWeight: FontWeight.w800,
                                        color: Colors.white,
                                        fontSize: 18.0,
                                        shadows: <Shadow>[
                                      const Shadow(
                                        offset: Offset(3.0, 3.0),
                                        blurRadius: 10.0,
                                        color: Color.fromARGB(255, 0, 0, 0),
                                      )
                                    ])),
                            Text("인증 링크를 보냈습니다",
                                style: Theme.of(context)
                                    .textTheme
                                    .content
                                    .copyWith(
                                        fontWeight: FontWeight.w800,
                                        color: Colors.white,
                                        fontSize: 18.0,
                                        shadows: <Shadow>[
                                      const Shadow(
                                        offset: Offset(3.0, 3.0),
                                        blurRadius: 10.0,
                                        color: Color.fromARGB(255, 0, 0, 0),
                                      )
                                    ])),
                            const SizedBox(height: 20.0),
                            Text("링크 확인후 '이메일 확인' 버튼을",
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
                                    ])),
                            Text("클릭해주세요",
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
                                    ])),
                            const SizedBox(height: 30.0),
                            SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                  style: Theme.of(context)
                                      .elevatedButtonTheme
                                      .green
                                      .copyWith(
                                        elevation:
                                            const MaterialStatePropertyAll<
                                                double>(20.0),
                                        shadowColor:
                                            const MaterialStatePropertyAll<
                                                Color>(Colors.black),
                                      ),
                                  onPressed: () {
                                    controller
                                        .manuallyCheckEmailverificationStatus();
                                  },
                                  child: const Text("이메일 확인")),
                            ),
                            SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                  style: Theme.of(context)
                                      .elevatedButtonTheme
                                      .green
                                      .copyWith(
                                        elevation:
                                            const MaterialStatePropertyAll<
                                                double>(20.0),
                                        shadowColor:
                                            const MaterialStatePropertyAll<
                                                Color>(Colors.black),
                                      ),
                                  onPressed: () {
                                    controller.sendVerificationEmail();
                                  },
                                  child: const Text("이메일 재요청")),
                            ),
                            const SizedBox(height: 30.0),
                            TextButton(
                                onPressed: () {
                                  AuthenticationRepository.instance.logout();
                                },
                                child: Text("로그인 화면으로 돌아가기",
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
                          ],
                        ),
                      ),
                    ],
                  );
                } else if (snapshot.hasError) {
                  return const FormError(errorMsg: tLoadingDataError);
                } else {
                  return const FormError(errorMsg: tError);
                }
              } else {
                return const FormLoading(loadingMsg: tLoadingData);
              }
            }),
      )),
    );
  }
}
