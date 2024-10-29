import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../controllers/game_controller.dart';
import 'edit_page.dart';

class HomePage extends StatelessWidget {
  final ItemController itemController = Get.put(ItemController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Obx(() => Text('GameTracker - ${itemController.items.length} jogos registrados')),
      ),
      body: Obx(() {
        return ListView.builder(
          padding: const EdgeInsets.only(bottom: 80.0),
          itemCount: itemController.items.length,
          itemBuilder: (context, index) {
            final item = itemController.items[index];
            return ListTile(
              title: Text(item.name),
              subtitle: Text('${item.description}\nNota: ${item.review}'),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: const Icon(Icons.edit),
                    onPressed: () {
                      Get.to(() => EditPage(game: item));
                    },
                  ),
                  IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Text('Confirmar Exclusão'),
                            content: const Text('Deseja excluir esse jogo?'),
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.of(context).pop(),
                                child: const Text('Não'),
                              ),
                              TextButton(
                                onPressed: () {
                                  itemController.deleteItem(item.id);
                                  Navigator.of(context).pop();
                                },
                                child: const Text('Sim'),
                              ),
                            ],
                          );
                        },
                      );
                    },
                  ),
                ],
              ),
            );
          },
        );
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Get.to(() => EditPage(game: null)),
        child: const Icon(Icons.gamepad_outlined),
      ),
    );
  }
}
