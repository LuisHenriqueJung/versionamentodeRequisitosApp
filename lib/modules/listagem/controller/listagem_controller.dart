import 'package:mobx/mobx.dart';
import 'package:versionamentorequisitos/Models/pessoa.dart';
import 'package:versionamentorequisitos/db/db_conection.dart';

import '../../../Models/projeto.dart';

part 'listagem_controller.g.dart';

class ListagemController = ListagemControllerBase with _$ListagemController;

abstract class ListagemControllerBase with Store {
  @observable
  ObservableList<Projeto> listProjetos = ObservableList<Projeto>();

  @observable
  ObservableList<Pessoa> listPessoas = ObservableList<Pessoa>();

  @action
  Future<ObservableList<Pessoa>> getPessoas() async {
    listPessoas =
        ObservableList.of(await DbConection.instance.readAllPessoas());
    return listPessoas;
  }

  @action
  Future<ObservableList<Projeto>> getProjetos() async {
    listProjetos =
        ObservableList.of(await DbConection.instance.readAllProjetos());
    return listProjetos;
  }
}
