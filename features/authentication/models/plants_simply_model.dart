import 'package:cloud_firestore/cloud_firestore.dart';

class PlantsSimplyModel {
  final String? id;
  final String krName;
  final String enName;
  final String family;

  const PlantsSimplyModel({
    this.id,
    required this.krName,
    required this.enName,
    required this.family,
  });

  toJson() {
    return {
      "kr_name": krName,
      "en_name": enName,
      "family": family,
    };
  }

  factory PlantsSimplyModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data()!;
    return PlantsSimplyModel(
      id: document.id,
      krName: data["kr_name"],
      enName: data["en_name"],
      family: data["family"],
    );
  }
}
