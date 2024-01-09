import 'package:lista_tarefas/data/custom_dio.dart';
import '../model/tarefa.dart';

class TarefaRepository {
  final _customDio = TarefasCustomDio();

  Future<TarefaModel> listar() async {
    var url = "/tarefas";
    var result = await _customDio.dio.get(url);
    return TarefaModel.fromJson(result.data);
  }

  Future<void> salvar(Tarefas tarefa) async {
    try {
      await _customDio.dio.post("/tarefas", data: tarefa.toCreateJson());
    } catch (e) {
      rethrow;
    }
  }

  Future<void> remover(String objectId) async {
    try {
      await _customDio.dio.delete("/tarefas/$objectId");
    } catch (e) {
      rethrow;
    }
  }

  Future<void> atualizar(Tarefas tarefa) async {
    try {
      await _customDio.dio
          .put("/tarefas/${tarefa.objectId}", data: tarefa.toUpdateJson());
    } catch (e) {
      rethrow;
    }
  }

  // final List<Tarefa> _tarefas = [];

  //   Future<List<Tarefa>> listar() async {
  //   await Future.delayed(const Duration(milliseconds: 100));
  //   return _tarefas;
  // }

  // Future<void> adicionar(Tarefa tarefa) async {
  //   await Future.delayed(const Duration(milliseconds: 100));
  //   _tarefas.add(tarefa);
  // }

  // Future<void> alterar(String id, bool concluido) async {
  //   await Future.delayed(const Duration(milliseconds: 100));
  //   _tarefas.where((tarefa) => tarefa.id == id).first.concluido = concluido;
  // }

  // Future<void> remove(String id) async {
  //   await Future.delayed(const Duration(milliseconds: 100));
  //   _tarefas.remove(_tarefas.where((tarefa) => tarefa.id == id).first);
  // }

  // Future<List<Tarefa>> listarNaoConcluidas() async {
  //   await Future.delayed(const Duration(milliseconds: 100));
  //   return _tarefas.where((tarefa) => !tarefa.concluido).toList();
  // }
}
