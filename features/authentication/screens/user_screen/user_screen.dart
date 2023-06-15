
import 'package:flutter/material.dart';
import 'package:gcp/src/common_widgets/form/form_loading_widget.dart';
import 'package:gcp/src/constants/sizes.dart';
import 'package:gcp/src/constants/text_strings.dart';
import 'package:gcp/src/features/authentication/models/user_model.dart';
import 'package:gcp/src/repository/authentication_repository/authentication_repository.dart';
import 'package:gcp/src/utils/theme/widget_themes/ebutton_theme.dart';
import 'package:gcp/src/utils/theme/widget_themes/text_theme.dart';
import 'package:get/get.dart';
import '../../../../common_widgets/form/form_copyright_widget.dart';
import '../../../../common_widgets/form/form_error_widget.dart';
import '../../../core/controllers/data_controller.dart';

class UserScreen extends StatelessWidget{
  const UserScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
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
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(tDefaultSize),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('${userData.fullName} 님', style: Theme.of(context).textTheme.inside.copyWith(fontSize: 20)),
                              ],
                            ),
                            SizedBox(
                              width: 100,
                              height: 40,
                              child: ElevatedButton(
                                  style: Theme.of(context).elevatedButtonTheme.green,
                                  onPressed: () {
                                    AuthenticationRepository.instance.logout();
                                  },
                                  child: const Text("로그아웃")
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: tFormHeight - 5.0),
                      // 개발자 정보
                      Container(
                        width: MediaQuery.of(context).size.width,
                        padding: const EdgeInsets.symmetric(vertical: 30.0, horizontal: 25.0),
                        decoration: const BoxDecoration(
                          color: Colors.white,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("개발자 정보", style: Theme.of(context).textTheme.inside),
                            const SizedBox(height: tFormHeight - 15.0),
                            Text('딥러닝 AI, 웹서버 개발 : 차현욱', style: Theme.of(context).textTheme.inside.copyWith(fontSize: 15.0)),
                            const SizedBox(height: tFormHeight - 25.0),
                            Text('어플리케이션 구현, 디자인 : 박 환', style: Theme.of(context).textTheme.inside.copyWith(fontSize: 15.0)),
                          ]
                        ),
                      ),
                      const SizedBox(height: tFormHeight - 5.0),
                      // 식물 정보 출처
                      Container(
                        width: MediaQuery.of(context).size.width,
                        padding: const EdgeInsets.symmetric(vertical: 30.0, horizontal: 25.0),
                        decoration: const BoxDecoration(
                          color: Colors.white,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("식물 정보 출처", style: Theme.of(context).textTheme.inside),
                            const SizedBox(height: tFormHeight - 15.0),
                            Text('PictureThis, 두산 백과사전, 네이버 백과사전, 농림수산식품교육문화정보원_공기정화식물', style: Theme.of(context).textTheme.inside.copyWith(fontSize: 15.0)),
                          ]
                        ),
                      ),
                      const SizedBox(height: tFormHeight * 1),
                      const FormCopyright(),
                      const SizedBox(height: tFormHeight * 2),
                    ],
                  );
                } else if (snapshot.hasError) {
                  return const FormError(errorMsg: tLoadingLoginError);
                } else {
                  return const FormError(errorMsg: tError);
                }
              } else {
                return const FormLoading(loadingMsg: tLoadingLogin);
              }
            }
          ),
        ),
      )
    );
  }
}