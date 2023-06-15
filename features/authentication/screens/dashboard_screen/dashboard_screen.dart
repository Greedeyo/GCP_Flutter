import 'dart:io';
import 'package:flutter/material.dart';
import 'package:gcp/src/common_widgets/form/form_loading_widget.dart';
import 'package:gcp/src/constants/image_strings.dart';
import 'package:gcp/src/constants/sizes.dart';
import 'package:gcp/src/constants/text_strings.dart';
import 'package:gcp/src/features/authentication/models/user_model.dart';
import 'package:gcp/src/utils/theme/widget_themes/ebutton_theme.dart';
import 'package:gcp/src/utils/theme/widget_themes/text_theme.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../../../../common_widgets/form/form_copyright_widget.dart';
import '../../../../common_widgets/form/form_error_widget.dart';
import '../../../../repository/ments_repository/ments_repository.dart';
import '../../../../repository/plants_repository/plants_repository.dart';
import '../../../core/controllers/camera_controller.dart';
import '../../../core/controllers/data_controller.dart';
import '../plants_recognition_screen/plants_recognition_screen.dart';
import '../plants_result_screen/plants_result_screen.dart';
import '../plants_shopping_list_screen/plants_shopping_list_screen.dart';

class DashBoard extends StatelessWidget {
  const DashBoard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final dataController = Get.put(DataController());
    final cameraController = Get.put(CameraController());
    final plantsSimplyController = Get.put(PlantsRepository());
    final mentsController = Get.put(MentsRepository());

    Future<dynamic> sendData() async {
      final data1 = await dataController.getUserData();
      final data2 = await mentsController.getAllMents();
      final data3 = await plantsSimplyController.getAllPlants();
      return [data1, data2, data3];
    }

    return SafeArea(
        child: Scaffold(
      body: SingleChildScrollView(
        child: FutureBuilder(
          future: sendData(),
          builder: (context, AsyncSnapshot<dynamic> snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasData) {
                UserModel userData = snapshot.data[0] as UserModel;
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // 환영 메세지
                    Container(
                      padding: const EdgeInsets.all(tDefaultSize),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('${userData.fullName} 님 환영합니다!',
                                  style: Theme.of(context)
                                      .textTheme
                                      .inside
                                      .copyWith(fontSize: 20)),
                              const SizedBox(height: tFormHeight - 25.0),
                              Text('식물 인식 & 추천 앱 GCP입니다',
                                  style: Theme.of(context)
                                      .textTheme
                                      .inside
                                      .copyWith(fontSize: 15)),
                            ],
                          ),
                        ],
                      ),
                    ),
                    // 식물 검색창
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 25.0),
                      child: TextFormField(
                        decoration: InputDecoration(
                          prefixIcon: const Icon(Icons.search_rounded),
                          contentPadding:
                              const EdgeInsets.symmetric(vertical: 15.0),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25),
                            borderSide: BorderSide.none,
                          ),
                          hintText: "식물을 검색해보세요!",
                          filled: true,
                          fillColor: Colors.white,
                        ),
                        onFieldSubmitted: (String value) {
                          Get.to(() => PlantsResultScreen(plantsName: value));
                        },
                      ),
                    ),
                    const SizedBox(height: tFormHeight - 15.0),
                    // 하루 멘트
                    Container(
                      padding: const EdgeInsets.only(
                          left: 20.0, top: 6.0, bottom: 6.0),
                      margin: const EdgeInsets.symmetric(horizontal: 25.0),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25),
                          color: Colors.white),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            SizedBox(
                              width: 200,
                              child: ListView.builder(
                                shrinkWrap: true,
                                itemCount: 1,
                                itemBuilder:
                                    (BuildContext context, int index) {
                                  final dailyMents = snapshot.data[1]![index];
                                  return Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(dailyMents.quote,
                                          style: Theme.of(context)
                                              .textTheme
                                              .inside
                                              .copyWith(fontSize: 17)),
                                      const SizedBox(
                                          height: tFormHeight - 25.0),
                                      Text(dailyMents.author,
                                          style: Theme.of(context)
                                              .textTheme
                                              .inside
                                              .copyWith(
                                                  fontSize: 15,
                                                  color: const Color(
                                                      0xffB3B3B3))),
                                    ],
                                  );
                                },
                              ),
                            ),
                            Container(
                              width: 80,
                              height: 80,
                              decoration: const BoxDecoration(
                                  image: DecorationImage(
                                      image: AssetImage(tContentImage))),
                            ),
                          ]),
                    ),
                    const SizedBox(height: tFormHeight - 5.0),
                    // 식물 인식
                    Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 30.0, horizontal: 25.0),
                      decoration: const BoxDecoration(
                        color: Colors.white,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('이름 모를 식물엔',
                                    style:
                                        Theme.of(context).textTheme.inside),
                                const SizedBox(height: tFormHeight - 25.0),
                                Text('식물 인식하기',
                                    style: Theme.of(context)
                                        .textTheme
                                        .inside
                                        .copyWith(
                                            fontWeight: FontWeight.w800)),
                              ]),
                          const SizedBox(height: tFormHeight - 10.0),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Obx(() {
                                return cameraController.imagePath.isNotEmpty
                                    ? Container(
                                        width: MediaQuery.of(context)
                                                .size
                                                .width /
                                            2,
                                        height: 200,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            color: const Color(0xffF8F8F8),
                                            image: DecorationImage(
                                              image: FileImage(File(
                                                  cameraController.imagePath
                                                      .toString())),
                                            )),
                                      )
                                    : Container(
                                        width: MediaQuery.of(context)
                                                .size
                                                .width /
                                            2,
                                        height: 200,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            color: const Color(0xffF8F8F8),
                                            image: const DecorationImage(
                                              image: AssetImage(
                                                  'assets/images/no_image.png'),
                                            )),
                                      );
                              }),
                              Column(
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      cameraController
                                          .getImage(ImageSource.camera);
                                    },
                                    child: Container(
                                      width: 100,
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 10.0),
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              const BorderRadius.only(
                                                  topLeft:
                                                      Radius.circular(10),
                                                  topRight:
                                                      Radius.circular(10)),
                                          color: Colors.white,
                                          border: Border.all(
                                              color:
                                                  const Color(0xffF1F1F1))),
                                      child: Column(children: [
                                        const Icon(Icons.add_a_photo_outlined,
                                            size: 25.0,
                                            color: Color(0xff343644)),
                                        const SizedBox(
                                            height: tFormHeight - 20.0),
                                        Text("사진 촬영",
                                            style: Theme.of(context)
                                                .textTheme
                                                .inside
                                                .copyWith(fontSize: 15))
                                      ]),
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      cameraController
                                          .getImage(ImageSource.gallery);
                                    },
                                    child: Container(
                                      width: 100,
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 10.0),
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              const BorderRadius.only(
                                                  bottomLeft:
                                                      Radius.circular(10),
                                                  bottomRight:
                                                      Radius.circular(10)),
                                          color: Colors.white,
                                          border: Border.all(
                                              color:
                                                  const Color(0xffF1F1F1))),
                                      child: Column(children: [
                                        const Icon(Icons.upload_file,
                                            size: 25.0,
                                            color: Color(0xff343644)),
                                        const SizedBox(
                                            height: tFormHeight - 25.0),
                                        Text("사진 업로드",
                                            style: Theme.of(context)
                                                .textTheme
                                                .inside
                                                .copyWith(fontSize: 15))
                                      ]),
                                    ),
                                  ),
                                  const SizedBox(height: tFormHeight - 20.0),
                                  SizedBox(
                                    width: 100,
                                    height: 40,
                                    child: ElevatedButton(
                                        style: Theme.of(context)
                                            .elevatedButtonTheme
                                            .green,
                                        onPressed: () {
                                          if (cameraController
                                              .imagePath.isEmpty) {
                                            if (Get.isSnackbarOpen == false) {
                                              Get.snackbar(
                                                "",
                                                "",
                                                titleText: const Text("ERROR",
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.white,
                                                        fontSize: 20)),
                                                messageText: const Text(
                                                    "사진을 촬영하거나 업로드 하세요",
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 15)),
                                                duration: const Duration(
                                                    seconds: 3),
                                                icon: const Icon(
                                                  Icons.error,
                                                  color: Colors.white,
                                                  size: 45.0,
                                                ),
                                                shouldIconPulse: true,
                                                padding: const EdgeInsets
                                                        .symmetric(
                                                    horizontal: 30.0,
                                                    vertical: 10.0),
                                                margin: const EdgeInsets.all(
                                                    25.0),
                                                backgroundColor: Colors.red,
                                              );
                                            }
                                          } else {
                                            Get.to(() =>
                                                PlantsRecognitionScreen(
                                                    imageFile: File(
                                                        cameraController
                                                            .imagePath
                                                            .value)));
                                          }
                                        },
                                        child: const Text("인식하기")),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: tFormHeight - 5.0),
                    // 식물 추천 리스트
                    Container(
                      padding: const EdgeInsets.symmetric(vertical: 30.0),
                      decoration: const BoxDecoration(color: Colors.white),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 25.0),
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('이런 식물은 어때요?',
                                      style:
                                          Theme.of(context).textTheme.inside),
                                  const SizedBox(height: tFormHeight - 25.0),
                                  Text('식물 추천 리스트',
                                      style: Theme.of(context)
                                          .textTheme
                                          .inside
                                          .copyWith(
                                              fontWeight: FontWeight.w800)),
                                ]),
                          ),
                          const SizedBox(height: tFormHeight - 10.0),
                          SizedBox(
                            height: 220,
                            child: ListView.builder(
                              shrinkWrap: true,
                              scrollDirection: Axis.horizontal,
                              itemCount: 3,
                              itemBuilder: (BuildContext context, int index) {
                                final recommendPlants =
                                    snapshot.data[2]![index];
                                return GestureDetector(
                                  onTap: () {
                                    Get.to(() => PlantsResultScreen(
                                        plantsName: recommendPlants.krName));
                                  },
                                  child: Container(
                                    padding: EdgeInsets.only(
                                        left: index == 0 ? 25.0 : 0.0,
                                        right: index ==
                                                snapshot.data[2]!.length - 1
                                            ? 25.0
                                            : 20.0),
                                    height: 175,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Container(
                                          width: 120,
                                          height: 120,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              border: Border.all(
                                                  color: Colors.black12),
                                              image: DecorationImage(
                                                  image: AssetImage(
                                                      'assets/images/plants/${recommendPlants.enName}.jpg'))),
                                        ),
                                        const SizedBox(
                                            height: tFormHeight - 20.0),
                                        Text(recommendPlants.krName,
                                            style: Theme.of(context)
                                                .textTheme
                                                .inside
                                                .copyWith(fontSize: 15)),
                                        Text(recommendPlants.family,
                                            style: Theme.of(context)
                                                .textTheme
                                                .inside
                                                .copyWith(
                                                    fontSize: 15,
                                                    color: const Color(
                                                        0xffB3B3B3))),
                                        const SizedBox(
                                            height: tFormHeight - 20.0),
                                        SizedBox(
                                          width: 100,
                                          height: 40,
                                          child: ElevatedButton(
                                              style: Theme.of(context)
                                                  .elevatedButtonTheme
                                                  .green,
                                              onPressed: () {
                                                Get.to(() =>
                                                    PlantsShoppingListScreen(
                                                        plantsName:
                                                            recommendPlants
                                                                .krName));
                                              },
                                              child: const Text("구매하기")),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: tFormHeight * 1),
                    const FormCopyright(),
                    const SizedBox(height: tFormHeight * 2),
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
      ),
    ));
  }
}
