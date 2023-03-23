import 'package:mobx/mobx.dart';
import 'package:versionamentorequisitos/Models/pessoa.dart';
import 'package:versionamentorequisitos/Models/requisito.dart';
import 'package:versionamentorequisitos/db/db_conection.dart';

import '../../../Models/projeto.dart';

part 'listagem_controller.g.dart';

class ListagemController = ListagemControllerBase with _$ListagemController;

abstract class ListagemControllerBase with Store {
  @observable
  ObservableList<Projeto> listProjetos = ObservableList<Projeto>();

  @observable
  ObservableList<Pessoa> listPessoas = ObservableList<Pessoa>();

  @observable
  ObservableList<Requisito> listRequisitos = ObservableList<Requisito>();
  @observable
  bool isLoading = false;

  @observable
  int projetoId = 0;

  @action
  Future<ObservableList<Pessoa>> getPessoas() async {
    return listPessoas =
        ObservableList.of(await DbConection.instance.readAllPessoas());
  }

  @action
  Future<ObservableList<Projeto>> getProjetos() async {
    return listProjetos =
        ObservableList.of(await DbConection.instance.readAllProjetos());
  }

  @action
  Future<ObservableList<Requisito>> getRequisitos() async {
    return listRequisitos = ObservableList.of(
        await DbConection.instance.readRequisitoByProjeto(projetoId));
  }
}
