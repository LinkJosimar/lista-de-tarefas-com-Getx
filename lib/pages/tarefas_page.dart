import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/lista_tarefa_controller.dart';

class TarefaPage extends GetView<ListaTarefasController> {
  var descricaoContoller = TextEditingController();
  final controller = Get.put(ListaTarefasController());
  TarefaPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            title: const Text("Lista de tarefas"),
            centerTitle: true,
          ),
          floatingActionButton: FloatingActionButton(
            child: const Icon(Icons.add),
            onPressed: () {
              descricaoContoller.text = "";
              showDialog(
                  context: context,
                  builder: (BuildContext bc) {
                    return AlertDialog(
                      title: const Text("Adicionar tarefa"),
                      content: TextField(
                        controller: descricaoContoller,
                      ),
                      actions: [
                        TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: const Text("Cancelar")),
                        TextButton(
                            onPressed: () {
                              controller.adicionar(descricaoContoller.text);
                              Navigator.pop(context);
                            },
                            child: const Text("Salvar"))
                      ],
                    );
                  });
            },
          ),
          body: Container(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Column(
              children: [
                Container(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Apenas não concluídos",
                        style: TextStyle(fontSize: 18),
                      ),
                      Obx(() {
                        return Switch(
                            value: controller.apenasNaoConcluidos,
                            onChanged: controller.setApenasNaoconcluidos);
                      })
                    ],
                  ),
                ),
                Expanded(
                  child: Obx(() {
                    if (controller.loading.isTrue) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    return ListView.builder(
                        itemCount: controller.tarefas.length,
                        itemBuilder: (BuildContext bc, int index) {
                          var tarefa = controller.tarefas[index];
                          return Dismissible(
                            onDismissed:
                                (DismissDirection dismissDirection) async {
                              await controller.excluir(tarefa.objectId);
                            },
                            key: Key(tarefa.objectId),
                            child: ListTile(
                              title: Text(tarefa.descricao),
                              trailing: Switch(
                                onChanged: (bool value) async {
                                  tarefa.concluido = value;
                                  await controller.alterar(tarefa.objectId,
                                      tarefa.descricao, tarefa.concluido);
                                },
                                value: tarefa.concluido,
                              ),
                            ),
                          );
                        });
                  }),
                ),
              ],
            ),
          )),
    );
  }
}
