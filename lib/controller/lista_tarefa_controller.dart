import 'package:get/get.dart';
import 'package:lista_tarefas/model/tarefa.dart';
import '../data/tarefa_repository.dart';

class ListaTarefasController extends GetxController {
  RxList<Tarefas> _tarefas = <Tarefas>[].obs;
  var tarefaRepository = TarefaRepository();
  RxBool loading = false.obs;
  final _apenasNaoConcluidos = false.obs;
  bool get apenasNaoConcluidos => _apenasNaoConcluidos.value;
  void setApenasNaoconcluidos(bool value) {
    _apenasNaoConcluidos.value = value;
  }

  @override
  void onInit() async {
    listaTarefas();
    super.onInit();
  }

  listaTarefas() async {
    loading(true);
    var tarefa = await tarefaRepository.listar();
    _tarefas = tarefa.tarefa.obs;
    loading(false);
  }

  adicionar(String descricao) async {
    await TarefaRepository().salvar(Tarefas.criar(descricao, false));
    listaTarefas();
  }

  List<Tarefas> get tarefas => _apenasNaoConcluidos.value
      ? _tarefas.where((element) => !element.concluido).toList().obs
      : _tarefas.toList().obs;

  Future<void> alterar(
      String objectId, String descricao, bool concluido) async {
    var tarefa = _tarefas.firstWhere((element) => element.objectId == objectId);
    tarefa.descricao = descricao;
    tarefa.concluido = concluido;
    _tarefas.refresh();
    await TarefaRepository().atualizar(tarefa);
  }

  Future<void> excluir(String objectId) async {
    _tarefas.removeWhere((element) => element.objectId == objectId);
    await TarefaRepository().remover(objectId);
  }
}
