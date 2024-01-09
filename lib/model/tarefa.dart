class TarefaModel {
  List<Tarefas> tarefa = [];

  TarefaModel(this.tarefa);

  TarefaModel.fromJson(Map<String, dynamic> json) {
    if (json['results'] != null) {
      tarefa = <Tarefas>[];
      json['results'].forEach((v) {
        tarefa.add(Tarefas.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['results'] = tarefa.map((v) => v.toJson()).toList();
    return data;
  }
}

class Tarefas {
  String objectId = "";
  String descricao = "";
  bool concluido = false;
  String createdAt = "";
  String updatedAt = "";

  Tarefas(this.objectId, this.descricao, this.concluido, this.createdAt,
      this.updatedAt);

  Tarefas.fromJson(Map<String, dynamic> json) {
    objectId = json['objectId'];
    descricao = json['descricao'];
    concluido = json['concluido'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Tarefas.criar(this.descricao, this.concluido);

  Tarefas.atualizar(this.objectId, this.descricao, this.concluido);

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['objectId'] = objectId;
    data['descricao'] = descricao;
    data['concluido'] = concluido;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    return data;
  }

  Map<String, dynamic> toCreateJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['descricao'] = descricao;
    data['concluido'] = concluido;
    return data;
  }

  Map<String, dynamic> toUpdateJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['descricao'] = descricao;
    data['concluido'] = concluido;
    return data;
  }
}
