import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import '../../features/authentication/models/ments_model.dart';

class MentsRepository extends GetxController {
  static MentsRepository get instance => Get.find();

  final _db = FirebaseFirestore.instance;

  Future<List<MentsModel>> getAllMents() async {
    final snapshot = await _db.collection("DailyMent").get();
    final mentsData = snapshot.docs.map((e) => MentsModel.fromSnapshot(e)).toList();
    return mentsData;
  }
}