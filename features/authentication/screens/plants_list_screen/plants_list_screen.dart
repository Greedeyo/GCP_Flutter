import 'package:flutter/material.dart';
import 'package:gcp/src/common_widgets/form/form_loading_widget.dart';
import 'package:gcp/src/constants/sizes.dart';
import 'package:gcp/src/constants/text_strings.dart';
import 'package:gcp/src/features/authentication/models/plants_simply_model.dart';
import 'package:gcp/src/utils/theme/widget_themes/ebutton_theme.dart';
import 'package:gcp/src/utils/theme/widget_themes/text_theme.dart';
import 'package:get/get.dart';
import '../../../../common_widgets/form/form_copyright_widget.dart';
import '../../../../common_widgets/form/form_error_widget.dart';
import '../../../../repository/plants_repository/plants_repository.dart';
import '../plants_result_screen/plants_result_screen.dart';
import '../plants_shopping_list_screen/plants_shopping_list_screen.dart';

class PlantsListScreen extends StatelessWidget {
  const PlantsListScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final plantsSimplyController = Get.put(PlantsRepository());

    return SafeArea(
        child: Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: tDefaultSize),
          child: FutureBuilder<List<PlantsSimplyModel>>(
              future: plantsSimplyController.getAllPlants(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  if (snapshot.hasData) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                              vertical: tDefaultSize),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('식물 구경하고 싶을 땐',
                                  style: Theme.of(context).textTheme.inside),
                              const SizedBox(height: tFormHeight - 25.0),
                              Text('식물 리스트',
                                  style: Theme.of(context)
                                      .textTheme
                                      .inside
                                      .copyWith(fontWeight: FontWeight.w800)),
                            ],
                          ),
                        ),
                        GridView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: snapshot.data!.length,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 20.0,
                            childAspectRatio: 1 / 2.0,
                          ),
                          itemBuilder: (BuildContext context, int index) {
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    Get.to(() => PlantsResultScreen(
                                        plantsName:
                                            snapshot.data![index].krName));
                                  },
                                  child: Container(
                                      width: 150,
                                      height: 250,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(25),
                                          color: Colors.white),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
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
                                                        'assets/images/plants/${snapshot.data![index].enName}.jpg'))),
                                          ),
                                          const SizedBox(
                                              height: tFormHeight - 20.0),
                                          Text(snapshot.data![index].krName,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .inside
                                                  .copyWith(fontSize: 15)),
                                          Text(snapshot.data![index].family,
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
                                                          plantsName: snapshot
                                                              .data![index]
                                                              .krName));
                                                },
                                                child: const Text("구매하기")),
                                          ),
                                        ],
                                      )),
                                ),
                              ],
                            );
                          },
                        ),
                        const FormCopyright(),
                        const SizedBox(height: tFormHeight * 1.0),
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
