import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gcp/src/common_widgets/form/form_loading_widget.dart';
import 'package:gcp/src/constants/sizes.dart';
import 'package:gcp/src/constants/text_strings.dart';
import 'package:gcp/src/utils/theme/widget_themes/ebutton_theme.dart';
import 'package:gcp/src/utils/theme/widget_themes/text_theme.dart';
import 'package:get/get.dart';
import '../../../../common_widgets/form/form_copyright_widget.dart';
import '../../../../common_widgets/form/form_error_widget.dart';
import '../../../../repository/plants_repository/plants_repository.dart';
import '../../models/plants_model.dart';

class PlantsResultScreen extends StatefulWidget {
  const PlantsResultScreen({Key? key, required this.plantsName})
      : super(key: key);

  final String plantsName;

  @override
  State<PlantsResultScreen> createState() => _PlantsResultScreen();
}

class _PlantsResultScreen extends State<PlantsResultScreen> {
  bool moreContentVisible = false;
  double saveScrollOffset = 0.0;
  ScrollController scrollController = ScrollController();

  void _toggle() {
    setState(() {
      moreContentVisible = !moreContentVisible;
      saveScrollOffset = scrollController.offset;
    });
  }

  @override
  Widget build(BuildContext context) {
    final plantsController = Get.put(PlantsRepository());
    String plantsName = widget.plantsName;

    return SafeArea(
        child: Scaffold(
      resizeToAvoidBottomInset: false,
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) => [
          const SliverAppBar(
            title: Text("식물"),
            titleTextStyle: TextStyle(
                fontFamily: "Suite",
                fontWeight: FontWeight.w500,
                fontSize: 20,
                color: Color(0xff343644)),
            centerTitle: true,
            leading: BackButton(color: Colors.black),
            elevation: 0,
            backgroundColor: Colors.white,
          ),
        ],
        body: SingleChildScrollView(
          controller: scrollController,
          child: FutureBuilder(
              future: plantsController.getPlantsDetails(plantsName),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  if (snapshot.hasData) {
                    PlantsModel plantsData = snapshot.data as PlantsModel;
                    scrollController.animateTo(saveScrollOffset,
                        duration: const Duration(milliseconds: 500),
                        curve: Curves.easeIn);
                    return Column(
                      children: [
                        // 식물 사진
                        Container(
                          height: 420,
                          clipBehavior: Clip.hardEdge,
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.only(
                              bottomRight: Radius.circular(30),
                              bottomLeft: Radius.circular(30),
                            ),
                          ),
                          child: Image.asset(
                              'assets/images/plants/${plantsData.enName}.jpg',
                              fit: BoxFit.fill),
                        ),
                        const SizedBox(height: tFormHeight - 15.0),
                        // 아이콘 사용 설명
                        Text("아이콘을 눌러보세요!",
                            style: Theme.of(context)
                                .textTheme
                                .inside
                                .copyWith(fontSize: 15)),
                        const SizedBox(height: tFormHeight - 25.0),
                        // 식물 아이콘
                        Container(
                          margin: const EdgeInsets.symmetric(horizontal: 10.0),
                          child: Column(
                            children: [
                              if (plantsData.toxic['text'] == "없음") ...[
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    SizedBox(
                                      width: 85,
                                      child: Column(children: [
                                        IconButton(
                                            onPressed: () {
                                              Get.dialog(AlertDialog(
                                                shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(25.0))),
                                                title: Center(child: Text("햇빛", style: Theme.of(context).textTheme.content)),
                                                content: Text(plantsData.sunlight, style: Theme.of(context).textTheme.inside.copyWith(fontSize: 15, color: const Color(0xffB3B3B3))),
                                                actionsAlignment:
                                                    MainAxisAlignment.center,
                                                actions: [
                                                  SizedBox(
                                                    width: 100,
                                                    height: 40,
                                                    child: ElevatedButton(style: Theme.of(context).elevatedButtonTheme.green,
                                                        onPressed: Get.back,
                                                        child:
                                                            const Text("확인")),
                                                  )
                                                ],
                                              ));
                                            },
                                            icon: const Icon(Icons.light_mode),
                                            color: Colors.orange,
                                            iconSize: 35.0),
                                        const SizedBox(
                                            height: tFormHeight - 25.0),
                                        Text(plantsData.sunlightIcon,
                                            style: Theme.of(context)
                                                .textTheme
                                                .inside
                                                .copyWith(fontSize: 15)),
                                      ]),
                                    ),
                                    SizedBox(
                                      width: 85,
                                      child: Column(children: [
                                        IconButton(
                                            onPressed: () {
                                              Get.dialog(AlertDialog(
                                                shape:
                                                    const RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius.all(
                                                                Radius.circular(
                                                                    25.0))),
                                                title: Center(
                                                    child: Text("물주기",
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .content)),
                                                content: Text(
                                                    plantsData.watering,
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .inside
                                                        .copyWith(
                                                            fontSize: 15,
                                                            color: const Color(
                                                                0xffB3B3B3))),
                                                actionsAlignment:
                                                    MainAxisAlignment.center,
                                                actions: [
                                                  SizedBox(
                                                    width: 100,
                                                    height: 40,
                                                    child: ElevatedButton(
                                                        style: Theme.of(context)
                                                            .elevatedButtonTheme
                                                            .green,
                                                        onPressed: Get.back,
                                                        child:
                                                            const Text("확인")),
                                                  )
                                                ],
                                              ));
                                            },
                                            icon: const Icon(Icons.water_drop),
                                            color: Colors.blue,
                                            iconSize: 35.0),
                                        const SizedBox(
                                            height: tFormHeight - 25.0),
                                        Text(plantsData.wateringIcon,
                                            style: Theme.of(context)
                                                .textTheme
                                                .inside
                                                .copyWith(fontSize: 15)),
                                      ]),
                                    ),
                                    SizedBox(
                                      width: 85,
                                      child: Column(children: [
                                        IconButton(
                                            onPressed: () {
                                              Get.dialog(AlertDialog(
                                                shape:
                                                    const RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius.all(
                                                                Radius.circular(
                                                                    25.0))),
                                                title: Center(
                                                    child: Text("비료",
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .content)),
                                                content: Text(
                                                    plantsData.fertilizer,
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .inside
                                                        .copyWith(
                                                            fontSize: 15,
                                                            color: const Color(
                                                                0xffB3B3B3))),
                                                actionsAlignment:
                                                    MainAxisAlignment.center,
                                                actions: [
                                                  SizedBox(
                                                    width: 100,
                                                    height: 40,
                                                    child: ElevatedButton(
                                                        style: Theme.of(context)
                                                            .elevatedButtonTheme
                                                            .green,
                                                        onPressed: Get.back,
                                                        child:
                                                            const Text("확인")),
                                                  )
                                                ],
                                              ));
                                            },
                                            icon: const Icon(Icons.inventory),
                                            color: Colors.green,
                                            iconSize: 35.0),
                                        const SizedBox(
                                            height: tFormHeight - 25.0),
                                        Text(plantsData.fertilizerIcon,
                                            style: Theme.of(context)
                                                .textTheme
                                                .inside
                                                .copyWith(fontSize: 15)),
                                      ]),
                                    ),
                                    SizedBox(
                                      width: 85,
                                      child: Column(children: [
                                        IconButton(
                                            onPressed: () {
                                              Get.dialog(AlertDialog(
                                                shape:
                                                    const RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius.all(
                                                                Radius.circular(
                                                                    25.0))),
                                                title: Center(
                                                    child: Text("인테리어",
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .content)),
                                                content: Text(
                                                    plantsData.interior,
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .inside
                                                        .copyWith(
                                                            fontSize: 15,
                                                            color: const Color(
                                                                0xffB3B3B3))),
                                                actionsAlignment:
                                                    MainAxisAlignment.center,
                                                actions: [
                                                  SizedBox(
                                                    width: 100,
                                                    height: 40,
                                                    child: ElevatedButton(
                                                        style: Theme.of(context)
                                                            .elevatedButtonTheme
                                                            .green,
                                                        onPressed: Get.back,
                                                        child:
                                                            const Text("확인")),
                                                  )
                                                ],
                                              ));
                                            },
                                            icon: const Icon(Icons.countertops),
                                            color: Colors.grey,
                                            iconSize: 35.0),
                                        const SizedBox(
                                            height: tFormHeight - 25.0),
                                        Text(plantsData.interiorIcon,
                                            style: Theme.of(context)
                                                .textTheme
                                                .inside
                                                .copyWith(fontSize: 15)),
                                      ]),
                                    ),
                                  ],
                                ),
                              ] else ...[
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    SizedBox(
                                      width: 85,
                                      child: Column(children: [
                                        IconButton(
                                            onPressed: () {
                                              Get.dialog(AlertDialog(
                                                shape:
                                                    const RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius.all(
                                                                Radius.circular(
                                                                    25.0))),
                                                title: Center(
                                                    child: Text("햇빛",
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .content)),
                                                content: Text(
                                                    plantsData.sunlight,
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .inside
                                                        .copyWith(
                                                            fontSize: 15,
                                                            color: const Color(
                                                                0xffB3B3B3))),
                                                actionsAlignment:
                                                    MainAxisAlignment.center,
                                                actions: [
                                                  SizedBox(
                                                    width: 100,
                                                    height: 40,
                                                    child: ElevatedButton(
                                                        style: Theme.of(context)
                                                            .elevatedButtonTheme
                                                            .green,
                                                        onPressed: Get.back,
                                                        child:
                                                            const Text("확인")),
                                                  )
                                                ],
                                              ));
                                            },
                                            icon: const Icon(Icons.light_mode),
                                            color: Colors.orange,
                                            iconSize: 35.0),
                                        const SizedBox(
                                            height: tFormHeight - 25.0),
                                        Text(plantsData.sunlightIcon,
                                            style: Theme.of(context)
                                                .textTheme
                                                .inside
                                                .copyWith(fontSize: 15)),
                                      ]),
                                    ),
                                    SizedBox(
                                      width: 85,
                                      child: Column(children: [
                                        IconButton(
                                            onPressed: () {
                                              Get.dialog(AlertDialog(
                                                shape:
                                                    const RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius.all(
                                                                Radius.circular(
                                                                    25.0))),
                                                title: Center(
                                                    child: Text("물주기",
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .content)),
                                                content: Text(
                                                    plantsData.watering,
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .inside
                                                        .copyWith(
                                                            fontSize: 15,
                                                            color: const Color(
                                                                0xffB3B3B3))),
                                                actionsAlignment:
                                                    MainAxisAlignment.center,
                                                actions: [
                                                  SizedBox(
                                                    width: 100,
                                                    height: 40,
                                                    child: ElevatedButton(
                                                        style: Theme.of(context)
                                                            .elevatedButtonTheme
                                                            .green,
                                                        onPressed: Get.back,
                                                        child:
                                                            const Text("확인")),
                                                  )
                                                ],
                                              ));
                                            },
                                            icon: const Icon(Icons.water_drop),
                                            color: Colors.blue,
                                            iconSize: 35.0),
                                        const SizedBox(
                                            height: tFormHeight - 25.0),
                                        Text(plantsData.wateringIcon,
                                            style: Theme.of(context)
                                                .textTheme
                                                .inside
                                                .copyWith(fontSize: 15)),
                                      ]),
                                    ),
                                    SizedBox(
                                      width: 85,
                                      child: Column(children: [
                                        IconButton(
                                            onPressed: () {
                                              Get.dialog(AlertDialog(
                                                shape:
                                                    const RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius.all(
                                                                Radius.circular(
                                                                    25.0))),
                                                title: Center(
                                                    child: Text("비료",
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .content)),
                                                content: Text(
                                                    plantsData.fertilizer,
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .inside
                                                        .copyWith(
                                                            fontSize: 15,
                                                            color: const Color(
                                                                0xffB3B3B3))),
                                                actionsAlignment:
                                                    MainAxisAlignment.center,
                                                actions: [
                                                  SizedBox(
                                                    width: 100,
                                                    height: 40,
                                                    child: ElevatedButton(
                                                        style: Theme.of(context)
                                                            .elevatedButtonTheme
                                                            .green,
                                                        onPressed: Get.back,
                                                        child:
                                                            const Text("확인")),
                                                  )
                                                ],
                                              ));
                                            },
                                            icon: const Icon(Icons.inventory),
                                            color: Colors.green,
                                            iconSize: 35.0),
                                        const SizedBox(
                                            height: tFormHeight - 25.0),
                                        Text(plantsData.fertilizerIcon,
                                            style: Theme.of(context)
                                                .textTheme
                                                .inside
                                                .copyWith(fontSize: 15)),
                                      ]),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: tFormHeight - 25.0),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    SizedBox(
                                      width: 85,
                                      child: Column(children: [
                                        IconButton(
                                            onPressed: () {
                                              Get.dialog(AlertDialog(
                                                shape:
                                                    const RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius.all(
                                                                Radius.circular(
                                                                    25.0))),
                                                title: Center(
                                                    child: Text("인테리어",
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .content)),
                                                content: Text(
                                                    plantsData.interior,
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .inside
                                                        .copyWith(
                                                            fontSize: 15,
                                                            color: const Color(
                                                                0xffB3B3B3))),
                                                actionsAlignment:
                                                    MainAxisAlignment.center,
                                                actions: [
                                                  SizedBox(
                                                    width: 100,
                                                    height: 40,
                                                    child: ElevatedButton(
                                                        style: Theme.of(context)
                                                            .elevatedButtonTheme
                                                            .green,
                                                        onPressed: Get.back,
                                                        child:
                                                            const Text("확인")),
                                                  )
                                                ],
                                              ));
                                            },
                                            icon: const Icon(Icons.countertops),
                                            color: Colors.grey,
                                            iconSize: 35.0),
                                        const SizedBox(
                                            height: tFormHeight - 25.0),
                                        Text(plantsData.interiorIcon,
                                            style: Theme.of(context)
                                                .textTheme
                                                .inside
                                                .copyWith(fontSize: 15)),
                                      ]),
                                    ),
                                    SizedBox(
                                      width: 85,
                                      child: Column(children: [
                                        IconButton(
                                            onPressed: () {
                                              Get.dialog(AlertDialog(
                                                shape:
                                                    const RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius.all(
                                                                Radius.circular(
                                                                    25.0))),
                                                title: Center(
                                                    child: Text("주의",
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .content)),
                                                content: Column(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  children: [
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceEvenly,
                                                      children: [
                                                        if (plantsData
                                                                .toxic['cat'] !=
                                                            0)
                                                          SizedBox(
                                                              width: 75,
                                                              child: Column(
                                                                  children: [
                                                                    const FaIcon(
                                                                        FontAwesomeIcons
                                                                            .cat,
                                                                        color: Colors
                                                                            .orange,
                                                                        size:
                                                                            35.0),
                                                                    const SizedBox(
                                                                        height: tFormHeight -
                                                                            15.0),
                                                                    Text("고양이",
                                                                        style: Theme.of(context)
                                                                            .textTheme
                                                                            .inside
                                                                            .copyWith(fontSize: 15)),
                                                                  ])),
                                                        if (plantsData
                                                                .toxic['dog'] !=
                                                            0)
                                                          SizedBox(
                                                              width: 75,
                                                              child: Column(
                                                                  children: [
                                                                    const FaIcon(
                                                                        FontAwesomeIcons
                                                                            .dog,
                                                                        color: Colors
                                                                            .orange,
                                                                        size:
                                                                            35.0),
                                                                    const SizedBox(
                                                                        height: tFormHeight -
                                                                            15.0),
                                                                    Text("개",
                                                                        style: Theme.of(context)
                                                                            .textTheme
                                                                            .inside
                                                                            .copyWith(fontSize: 15)),
                                                                  ])),
                                                        if (plantsData.toxic[
                                                                'person'] !=
                                                            0)
                                                          SizedBox(
                                                              width: 75,
                                                              child: Column(
                                                                  children: [
                                                                    const FaIcon(
                                                                        FontAwesomeIcons
                                                                            .person,
                                                                        color: Colors
                                                                            .orange,
                                                                        size:
                                                                            35.0),
                                                                    const SizedBox(
                                                                        height: tFormHeight -
                                                                            15.0),
                                                                    Text("사람",
                                                                        style: Theme.of(context)
                                                                            .textTheme
                                                                            .inside
                                                                            .copyWith(fontSize: 15)),
                                                                  ])),
                                                      ],
                                                    ),
                                                    const SizedBox(
                                                        height:
                                                            tFormHeight - 10.0),
                                                    Text(
                                                        plantsData
                                                            .toxic['text'],
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .inside
                                                            .copyWith(
                                                                fontSize: 15,
                                                                color: const Color(
                                                                    0xffB3B3B3))),
                                                  ],
                                                ),
                                                actionsAlignment:
                                                    MainAxisAlignment.center,
                                                actions: [
                                                  SizedBox(
                                                    width: 100,
                                                    height: 40,
                                                    child: ElevatedButton(
                                                        style: Theme.of(context)
                                                            .elevatedButtonTheme
                                                            .green,
                                                        onPressed: Get.back,
                                                        child:
                                                            const Text("확인")),
                                                  )
                                                ],
                                              ));
                                            },
                                            icon: const Icon(Icons.warning),
                                            color: Colors.red,
                                            iconSize: 35.0),
                                        const SizedBox(
                                            height: tFormHeight - 25.0),
                                        Text("주의",
                                            style: Theme.of(context)
                                                .textTheme
                                                .inside
                                                .copyWith(fontSize: 15)),
                                      ]),
                                    ),
                                  ],
                                ),
                              ]
                            ],
                          ),
                        ),
                        const SizedBox(height: tFormHeight - 5.0),
                        // 식물 국문, 영문 이름
                        Container(
                            width: MediaQuery.of(context).size.width,
                            padding: const EdgeInsets.symmetric(
                                vertical: 30.0, horizontal: 25.0),
                            decoration: const BoxDecoration(
                              color: Colors.white,
                            ),
                            child: Column(children: [
                              Text(plantsData.krName,
                                  style: Theme.of(context).textTheme.content),
                              Text(plantsData.enName,
                                  style: Theme.of(context)
                                      .textTheme
                                      .content
                                      .copyWith(fontSize: 15)),
                              const SizedBox(height: tFormHeight - 25.0),
                              Text(plantsData.scientificName,
                                  style: Theme.of(context)
                                      .textTheme
                                      .inside
                                      .copyWith(
                                          fontSize: 16,
                                          color: const Color(0xffB3B3B3))),
                              const SizedBox(height: tFormHeight - 25.0),
                              Text(plantsData.family,
                                  style: Theme.of(context)
                                      .textTheme
                                      .inside
                                      .copyWith(
                                          fontSize: 15,
                                          color: const Color(0xffB3B3B3))),
                            ])),
                        const SizedBox(height: tFormHeight - 5.0),
                        // 식물 설명
                        Container(
                            width: MediaQuery.of(context).size.width,
                            padding: const EdgeInsets.symmetric(
                                vertical: 30.0, horizontal: 25.0),
                            decoration: const BoxDecoration(
                              color: Colors.white,
                            ),
                            child: Column(children: [
                              Text(tPlantsInfo,
                                  style: Theme.of(context).textTheme.content),
                              const SizedBox(height: tFormHeight - 15.0),
                              Text(plantsData.info,
                                  style: Theme.of(context)
                                      .textTheme
                                      .inside
                                      .copyWith(
                                          fontSize: 15,
                                          color: const Color(0xffB3B3B3))),
                            ])),
                        const SizedBox(height: tFormHeight - 5.0),
                        // 식물 자세히 보기
                        if (moreContentVisible == true)
                          Column(
                            children: [
                              Container(
                                  width: MediaQuery.of(context).size.width,
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 30.0, horizontal: 25.0),
                                  decoration: const BoxDecoration(
                                    color: Colors.white,
                                  ),
                                  child: Column(children: [
                                    Text(tPlantsGrow,
                                        style: Theme.of(context)
                                            .textTheme
                                            .content),
                                    const SizedBox(height: tFormHeight - 15.0),
                                    Text(plantsData.grow,
                                        style: Theme.of(context)
                                            .textTheme
                                            .inside
                                            .copyWith(
                                                fontSize: 15,
                                                color:
                                                    const Color(0xffB3B3B3))),
                                  ])),
                              const SizedBox(height: tFormHeight - 5.0),
                              Container(
                                  width: MediaQuery.of(context).size.width,
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 30.0, horizontal: 25.0),
                                  decoration: const BoxDecoration(
                                    color: Colors.white,
                                  ),
                                  child: Column(children: [
                                    Text(tPlantsRepotting,
                                        style: Theme.of(context)
                                            .textTheme
                                            .content),
                                    const SizedBox(height: tFormHeight - 15.0),
                                    Text(plantsData.repotting,
                                        style: Theme.of(context)
                                            .textTheme
                                            .inside
                                            .copyWith(
                                                fontSize: 15,
                                                color:
                                                    const Color(0xffB3B3B3))),
                                  ])),
                              const SizedBox(height: tFormHeight - 5.0),
                            ],
                          ),
                        TextButton(
                          onPressed: _toggle,
                          child: Text(moreContentVisible
                              ? tSimplyContentPlants
                              : tMoreContentPlants),
                        ),
                        const SizedBox(height: tFormHeight * 1),
                        const FormCopyright(),
                        const SizedBox(height: tFormHeight * 2),
                      ],
                    );
                  } else if (snapshot.hasError) {
                    return const FormError(errorMsg: tLoadingPlantsError);
                  } else {
                    return const FormError(errorMsg: tError);
                  }
                } else {
                  return const FormLoading(loadingMsg: tLoadingPlants);
                }
              }),
        ),
      ),
    ));
  }
}
