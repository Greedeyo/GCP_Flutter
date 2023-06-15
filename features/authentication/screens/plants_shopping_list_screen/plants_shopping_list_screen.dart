
import 'package:flutter/material.dart';
import 'package:gcp/src/common_widgets/form/form_loading_widget.dart';
import 'package:gcp/src/constants/sizes.dart';
import 'package:gcp/src/constants/text_strings.dart';
import 'package:gcp/src/utils/theme/widget_themes/text_theme.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher_string.dart';
import '../../../../common_widgets/form/form_copyright_widget.dart';
import '../../../../common_widgets/form/form_error_widget.dart';
import '../../../core/controllers/http_controller.dart';

class PlantsShoppingListScreen extends StatelessWidget{
  const PlantsShoppingListScreen({
    required this.plantsName,
    super.key,
  });

  final String plantsName;

  @override
  Widget build(BuildContext context) {
    final httpController = Get.put(HttpController());

    return SafeArea(
      child: Scaffold(
      resizeToAvoidBottomInset: false,

      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) => [
          const SliverAppBar(
            title: Text("쇼핑"),
            titleTextStyle: TextStyle(fontFamily: "Suite", fontWeight: FontWeight.w500, fontSize: 20, color: Color(0xff343644)),
            centerTitle: true,
            leading: BackButton(
                color: Colors.black
            ),
            elevation: 0,
            backgroundColor: Colors.white,
          ),
        ],
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: tDefaultSize),
            child: FutureBuilder (
                future: httpController.getPlantsShoppingListResults(plantsName),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    if (snapshot.hasData) {
                      Map<String, dynamic> jsonData = snapshot.data;
                      List<dynamic> jsonitemsData = jsonData['items'].where((element)
                      => int.parse(element['lprice']) <= tLimitPlantsPrice).toList();

                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(vertical: tDefaultSize),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('네이버 쇼핑', style: Theme.of(context).textTheme.inside),
                                const SizedBox(height: tFormHeight - 25.0),
                                Text('$plantsName 검색 결과입니다', style: Theme.of(context).textTheme.inside.copyWith(fontWeight: FontWeight.w800)),
                              ],
                            ),
                          ),
                          GridView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: jsonitemsData.length,
                            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 1,
                              childAspectRatio: 1.5,
                            ),
                            itemBuilder: (BuildContext context, int index) {
                              final item = jsonitemsData[index];
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  GestureDetector(
                                    onTap: () async {
                                      launchUrlString(item['link'], mode: LaunchMode.externalApplication);
                                    },
                                    child: Container(
                                    padding: const EdgeInsets.all(25.0),
                                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(25), color: Colors.white),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                                      children: [
                                          Container(
                                            width: 120,
                                            height: 120,
                                            decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(10),
                                                border: Border.all(color: Colors.black12),
                                                image: DecorationImage(
                                                    image: NetworkImage(item['image']),
                                                )
                                            ),
                                          ),
                                          Column(
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            children: [
                                              SizedBox(
                                                width: 120,
                                                child: Text(item['title'].replaceAll("<b>", "").replaceAll("</b>", "")
                                                    , style: Theme.of(context).textTheme.content.copyWith(fontSize: 15)),
                                              ),
                                              const SizedBox(height: tFormHeight - 25.0),
                                              SizedBox(
                                                  width: 120,
                                                  child: Text("${NumberFormat('###,###,###,###').format(int.parse(item['lprice'])).replaceAll(' ', '')} 원"
                                                      , style: Theme.of(context).textTheme.content.copyWith(color: Colors.red, fontSize: 15)),
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
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
                }
              ),
            ),
          ),
        )
      )
    );
  }
}