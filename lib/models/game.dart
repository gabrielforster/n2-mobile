import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';

class Game {
  String id;
  String name;
  String description;
  int review;

  Game({
    required this.id,
    required this.name,
    required this.description,
    required this.review,
  });

  factory Game.fromMap(Map<String, dynamic> data, String documentId) {
    return Game(
      id: documentId,
      name: data['name'] ?? '',
      description: data['description'] ?? '',
      review: (data['review'] as int),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'description': description,
      'review': review,
    };
  }
}