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
        title: Obx(() => Text('GameTracker - ${itemController.items.length} jogos registrados')), // Titulo da pagina
      ),
      body: Obx(() {
        return ListView.builder(
          padding: const EdgeInsets.only(bottom: 80.0),
          itemCount: itemController.items.length,
          itemBuilder: (context, index) {
            final item = itemController.items[index];
            return ListTile(
              title: Text(item.name), // Exibicao do nome do jogo
              subtitle: Text('${item.description}\nNota: ${item.review}'), // Exibicao da descricao junto a nota, separados por uma quebra de linha
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: const Icon(Icons.edit), // Icone de edicao
                    onPressed: () {
                      Get.to(() => EditPage(game: item)); // Abrindo a tela de edicao ao clicar no icone
                    },
                  ),
                  IconButton(
                    icon: const Icon(Icons.delete), // Icone de delecao
                    onPressed: () { // Abrindo modal de confirmacao para delecao de um jogo
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog( // O modal de confirmacao
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
      floatingActionButton: FloatingActionButton( // Botao flutuante para abertura da tela de adicao de novos jogos
        onPressed: () => Get.to(() => EditPage(game: null)),
        child: const Icon(Icons.gamepad_outlined),
      ),
    );
  }
}
