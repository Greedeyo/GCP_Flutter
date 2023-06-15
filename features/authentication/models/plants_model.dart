import 'package:cloud_firestore/cloud_firestore.dart';

class PlantsModel {
  final String? id;
  final String krName;
  final String enName;
  final String scientificName;
  final String family;
  final String info;
  final String interior;
  final String interiorIcon;
  final String watering;
  final String wateringIcon;
  final String sunlight;
  final String sunlightIcon;
  final String grow;
  final String precaution;
  final String repotting;
  final String fertilizer;
  final String fertilizerIcon;
  final Map<String, dynamic> toxic;

  const PlantsModel({
    this.id,
    required this.krName,
    required this.enName,
    required this.scientificName,
    required this.family,
    required this.info,
    required this.interior,
    required this.interiorIcon,
    required this.watering,
    required this.wateringIcon,
    required this.sunlight,
    required this.sunlightIcon,
    required this.grow,
    required this.precaution,
    required this.repotting,
    required this.fertilizer,
    required this.fertilizerIcon,
    required this.toxic,
  });

  toJson() {
    return {
      "kr_name": krName,
      "en_name": enName,
      "scientific_name": scientificName,
      "family": family,
      "info": info,
      "interior": interior,
      "interior_icon": interiorIcon,
      "watering": watering,
      "watering_icon": wateringIcon,
      "sunlight": sunlight,
      "sunlight_icon": sunlightIcon,
      "grow": grow,
      "precaution": precaution,
      "repotting": repotting,
      "fertilizer": fertilizer,
      "fertilizer_icon": fertilizerIcon,
      "toxic": toxic,
    };
  }

  factory PlantsModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data()!;
    return PlantsModel(
      id: document.id,
      krName: data["kr_name"],
      enName: data["en_name"],
      scientificName: data["scientific_name"],
      family: data["family"],
      info: data["info"],
      interior: data["interior"],
      interiorIcon: data["interior_icon"],
      watering: data["watering"],
      wateringIcon: data["watering_icon"],
      sunlight: data["sunlight"],
      sunlightIcon: data["sunlight_icon"],
      grow: data["grow"],
      precaution: data["precaution"],
      repotting: data["repotting"],
      fertilizer: data["fertilizer"],
      fertilizerIcon: data["fertilizer_icon"],
      toxic: data["toxic"],
    );
  }
}
