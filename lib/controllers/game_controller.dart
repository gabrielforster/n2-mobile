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
    // Metodo responsavel pela listagem e atualizacao em tempo real da colecao de jogos
    _firestore
        .collection('games')
        .orderBy('created_at', descending: false)
        .snapshots()
        .listen((snapshot) {
      items.value =
          snapshot.docs.map((doc) => Game.fromMap(doc.data(), doc.id)).toList();
    });
  }

  Future<void> addItem(String name, String description, int review) async {
    // Metodo resposavel pela criacao de um novo jogo
    await _firestore.collection('games').add({
      'name': name,
      'description': description,
      'review': review,
      'created_at': FieldValue.serverTimestamp(),
    });
  }

  Future<void> updateItem(String id, String name, String description, int review) async {
    // Metodo responsavel pela edicao de um jogo
    await _firestore.collection('games').doc(id).update({
      'name': name,
      'description': description,
      'review': review,
    });
  }

  Future<void> deleteItem(String id) async {
    // Metodo responsavel pela delecao de um jogo
    await _firestore.collection('games').doc(id).delete();
  }
}