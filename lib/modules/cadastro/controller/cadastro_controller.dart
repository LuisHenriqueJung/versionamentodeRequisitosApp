import 'package:mobx/mobx.dart';
import 'package:flutter/material.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:versionamentorequisitos/Models/pessoa.dart';
import 'package:versionamentorequisitos/Models/projeto.dart';
import 'package:versionamentorequisitos/db/db_conection.dart';

part 'cadastro_controller.g.dart';

class CadastroController = CadastroControllerBase with _$CadastroController;

abstract class CadastroControllerBase with Store {
  @observable
  TextEditingController nomeController = TextEditingController(text: "");
  @observable
  TextEditingController prazoEntrega = TextEditingController(text: "");
  @observable
  TextEditingController responsavel = TextEditingController(text: "");
  @observable
  TextEditingController nomePessoa = TextEditingController(text: "");
  @observable
  TextEditingController cpf = TextEditingController();
  @observable
  TextEditingController funcao = TextEditingController(text: "");
  @observable
  TextEditingController login = TextEditingController(text: "");
  @observable
  TextEditingController senha = TextEditingController(text: "");
  @observable
  TextEditingController confirmaSenha = TextEditingController(text: "");
  @observable
  TextEditingController email = TextEditingController(text: "");

  @observable
  ObservableList<Projeto> listProjetos = ObservableList<Projeto>();

  @observable
  ObservableList<Pessoa> listPessoas = ObservableList<Pessoa>();

  final formKeyProjeto = GlobalKey<FormState>();
  final formKeyPessoa = GlobalKey<FormState>();

  final registerFormGroupProjeto = fb.group({
    ProjetoFields.nome: ['', Validators.required],
    ProjetoFields.prazoEntrega: ['', Validators.required],
    'responsavel': ['', Validators.required],
  });
  //-----------------------INICIO PROJETO-----------------------------//
  @action
  Future cadastrarProjeto() async {
    if (formKeyProjeto.currentState?.validate() ?? false) {
      final projeto = Projeto(
          nome: nomeController.text,
          prazoEntrega: prazoEntrega.text,
          dataInicio: DateTime.now(),
          responsavelId: 1);
      await DbConection.instance.insertProjeto(projeto);
    }
  }
  //-----------------------FIM PROJETO-----------------------------//

//-----------------------INICIO PESSOA-----------------------------//
  @action
  Future cadastrarPessoa() async {
    if (formKeyPessoa.currentState?.validate() ?? false) {
      final pessoa = Pessoa(
          nome: nomePessoa.text,
          cpf: cpf.text,
          funcao: funcao.text,
          login: login.text,
          senha: senha.text,
          email: email.text,
          situacao: true,
          dataCadastro: DateTime.now());
      await DbConection.instance.insertPessoa(pessoa);
    }
  }
  //----------------------FIM PESSOA-----------------------------//
}
