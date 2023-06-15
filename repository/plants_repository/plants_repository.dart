import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import '../../features/authentication/models/plants_model.dart';
import '../../features/authentication/models/plants_simply_model.dart';

class PlantsRepository extends GetxController {
  static PlantsRepository get instance => Get.find();

  final _db = FirebaseFirestore.instance;

  Future<PlantsModel> getPlantsDetails(String krName) async {
    final snapshot = await _db.collection("Plants").where("kr_name", isEqualTo: krName).get();
    final plantsData = snapshot.docs.map((e) => PlantsModel.fromSnapshot(e)).single;
    return plantsData;
  }

  Future<List<PlantsSimplyModel>> getAllPlants() async {
    final snapshot = await _db.collection("Plants").orderBy("kr_name", descending: false).get();
    final plantsData = snapshot.docs.map((e) => PlantsSimplyModel.fromSnapshot(e)).toList();
    return plantsData;
  }
}