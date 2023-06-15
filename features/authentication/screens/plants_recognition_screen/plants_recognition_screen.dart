import 'dart:io';
import 'package:flutter/material.dart';
import 'package:gcp/src/constants/text_strings.dart';
import 'package:get/get.dart';
import '../../../../common_widgets/form/form_error_widget.dart';
import '../../../../common_widgets/form/form_loading_widget.dart';
import '../../../core/controllers/http_controller.dart';
import '../plants_result_screen/plants_result_screen.dart';

class PlantsRecognitionScreen extends StatelessWidget {
  const PlantsRecognitionScreen({
    required this.imageFile,
    super.key,
  });

  final File? imageFile;

  @override
  Widget build(BuildContext context) {
    final httpController = Get.put(HttpController());

    return SafeArea(
      child: Scaffold(
        body: Center(
          child: FutureBuilder(
            future: httpController.getImagePredictionResults(imageFile),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.hasData) {
                  Map<String, dynamic> jsonData = snapshot.data;
                  return PlantsResultScreen(plantsName: jsonData['kr_name']);
                } else if (snapshot.hasError) {
                  return const FormError(
                      errorMsg: tLoadingPlantsRecognitionError);
                } else {
                  return const FormError(errorMsg: tError);
                }
              } else {
                return const FormLoading(loadingMsg: tLoadingPlantsRecognition);
              }
            }
          ),
        ),
      )
    );
  }
}
