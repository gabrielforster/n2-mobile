import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import '../models/game.dart';

class ItemController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  var items = <Game>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchItems();
  }

  void fetchItems() {
    _firestore.collection('games').snapshots().listen((snapshot) {
      items.value =
          snapshot.docs.map((doc) => Game.fromMap(doc.data(), doc.id)).toList();
    });
  }

  Future<void> addItem(String name, String description, int review) async {
    await _firestore.collection('games').add({
      'name': name,
      'description': description,
      'review': review,
    });
  }

  Future<void> updateItem(String id, String name, String description, int review) async {
    await _firestore.collection('games').doc(id).update({
      'name': name,
      'description': description,
      'review': review,
    });
  }

  Future<void> deleteItem(String id) async {
    await _firestore.collection('games').doc(id).delete();
  }
}