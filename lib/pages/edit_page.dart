import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../controllers/game_controller.dart';
import '../models/game.dart';
import '../utils/hex_color.dart';

class EditPage extends StatelessWidget {
  final Game? game;

  final TextEditingController nameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController reviewController = TextEditingController();

  final TextEditingController recipientController = TextEditingController();
  final ItemController itemController = Get.find();

  EditPage({Key? key, this.game}) : super(key: key) {
    if (game != null) {
      nameController.text = game!.name;
      descriptionController.text = game!.description;
      reviewController.text = game!.review.toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    Color primary = HexColor.fromHex("#B0FE76");

    return Scaffold(
      appBar: AppBar(
          title: Text(game == null ? 'Adicionar jogo' : 'Editar jogo')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(labelText: 'Nome'),
            ),
            TextField(
              controller: descriptionController,
              decoration: const InputDecoration(labelText: 'Descrição'),
            ),
            TextField(
              controller: reviewController,
              decoration: const InputDecoration(labelText: 'Nota (1-5)'),
              keyboardType: TextInputType.number,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
              ],
              onChanged: (value) {
                final number = int.tryParse(value);
                if (Get.isSnackbarOpen) {
                  Get.closeCurrentSnackbar();
                }
                if (number == null) return;
                if (number < 1 || number > 5) {
                  Get.snackbar(
                    'Erro',
                    'Por favor, insira um número entre 1 e 5',
                    snackPosition: SnackPosition.BOTTOM,
                  );
                }
              },
            ),
            const SizedBox(height: 20),

            ElevatedButton(
              onPressed: () {
                final reviewValue = int.tryParse(reviewController.text) ?? 0;

                if (Get.isSnackbarOpen) {
                  Get.closeCurrentSnackbar();
                }
                if (reviewValue < 1 || reviewValue > 5) {
                  Get.snackbar(
                    'Erro',
                    'Por favor, insira um número entre 1 e 5',
                    snackPosition: SnackPosition.BOTTOM,
                  );
                  return;
                }

                if (game == null) {
                  itemController.addItem(
                    nameController.text,
                    descriptionController.text,
                    reviewValue,
                  );
                } else {
                  itemController.updateItem(
                    game!.id,
                    nameController.text,
                    descriptionController.text,
                    reviewValue,
                  );
                }
                Get.back();
                Get.snackbar(
                  'Sucesso',
                  game == null
                      ? 'Jogo criado! O mesmo se encontra na listagem'
                      : 'Jogo editado! O mesmo se encontra atualizado na listagem',
                  snackPosition: SnackPosition.TOP,
                );
              },
              style: ElevatedButton.styleFrom(
                 backgroundColor: primary,
                 minimumSize: const Size.fromHeight(50),
              ),
              child: Text(
                  game == null ? 'Adicionar' : 'Atualizar',
                  style: const TextStyle(fontSize: 18, color: Colors.black)
              ),
            ),
          ],
        ),
      ),
    );
  }
}