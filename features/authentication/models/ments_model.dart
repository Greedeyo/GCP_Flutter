import 'package:cloud_firestore/cloud_firestore.dart';

class MentsModel {
  final String? id;
  final String author;
  final String quote;

  const MentsModel({
    this.id,
    required this.author,
    required this.quote,
  });

  toJson() {
    return {
      "author": author,
      "quote": quote,
    };
  }

  factory MentsModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data()!;
    return MentsModel(
      id: document.id,
      author: data["author"],
      quote: data["quote"],
    );
  }
}
