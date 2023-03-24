import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';
import 'package:flutter/material.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:versionamentorequisitos/Models/pessoa.dart';
import 'package:versionamentorequisitos/Models/projeto.dart';
import 'package:versionamentorequisitos/Models/requisito.dart';
import 'package:versionamentorequisitos/db/db_conection.dart';

part 'cadastro_controller.g.dart';

class CadastroController = CadastroControllerBase with _$CadastroController;

abstract class CadastroControllerBase with Store {
  //----PROJETO---//
  @observable
  TextEditingController nomeController = TextEditingController(text: "");
  @observable
  TextEditingController prazoEntrega = TextEditingController(text: "");
  @observable
  TextEditingController responsavel = TextEditingController(text: "");
  @observable
  ObservableList<Projeto> listProjetos = ObservableList<Projeto>();
  @observable
  ObservableList<Pessoa> listPessoasResponsaveis = ObservableList<Pessoa>();
  //----PROJETO---//
  //----PESSOA---//
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
  //----PESSOA---//
  //----REQUISITO---//
  @observable
  TextEditingController descricao = TextEditingController(text: "");
  @observable
  TextEditingController prioridade = TextEditingController(text: "");
  @observable
  TextEditingController complexidade = TextEditingController(text: "");
  @observable
  TextEditingController tipo = TextEditingController(text: "");
  @observable
  TextEditingController tempoEstimado = TextEditingController(text: "");
  @observable
  TextEditingController status = TextEditingController(text: "");
  @observable
  ObservableList<Requisito> listRequisitos = ObservableList<Requisito>();
  //----REQUISITO---//

  @observable
  bool isLoading = false;

  @observable
  int responsavelId = 0;
  @observable
  int projetoId = 0;

  final formKeyProjeto = GlobalKey<FormState>();
  final formKeyPessoa = GlobalKey<FormState>();
  final formKeyRequisito = GlobalKey<FormState>();

  final registerFormGroupProjeto = fb.group({
    ProjetoFields.nome: ['', Validators.required],
    ProjetoFields.prazoEntrega: ['', Validators.required],
    'responsavel': ['', Validators.required],
  });
  //-----------------------INICIO PROJETO-----------------------------//
  @action
  limparCamposProjeto() {
    nomeController.clear();
    prazoEntrega.clear();
    responsavel.clear();
    responsavelId = 0;
    formKeyProjeto.currentState!.reset();
  }

  @action
  Future cadastrarProjeto() async {
    if (formKeyProjeto.currentState?.validate() ?? false) {
      final projeto = Projeto(
          nome: nomeController.text,
          prazoEntrega: prazoEntrega.text,
          dataInicio: DateTime.now(),
          responsavelId: responsavelId);
      try {
        await DbConection.instance.insertProjeto(projeto);
        limparCamposProjeto();
        Modular.to.popAndPushNamed('/');
        return true;
      } catch (e) {
        return false;
      }
    } else {
      return false;
    }
  }

  @action
  Future setPossiveisResponsaveis() async {
    listPessoasResponsaveis =
        ObservableList.of(await DbConection.instance.readAllPessoas());
  }

  //-----------------------FIM PROJETO-----------------------------//

//-----------------------INICIO PESSOA-----------------------------//
  @action
  limparCamposPessoa() {
    nomePessoa.clear();
    cpf.clear();
    funcao.clear();
    email.clear();
    login.clear();
    senha.clear();
    confirmaSenha.clear();
    formKeyPessoa.currentState?.reset();
  }

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

      try {
        await DbConection.instance.insertPessoa(pessoa);
        limparCamposPessoa();
        Modular.to.navigate('/pessoa');
        return true;
      } catch (e) {
        return false;
      }
    } else {
      return false;
    }
  }

  //----------------------FIM PESSOA-----------------------------//
  //-------------------INICIO REQUISITO--------------------------//

  @action
  limpaCamposRequisito() {
    descricao.clear();
    prioridade.clear();
    complexidade.clear();
    tipo.clear();
    tempoEstimado.clear();
    projetoId = 0;
    formKeyRequisito.currentState?.reset();
  }

  @action
  Future cadastrarRequisito(int idProjeto) async {
    if (formKeyRequisito.currentState?.validate() ?? false) {
      final requisito = Requisito(
          descricao: descricao.text,
          status: status.text,
          prioridade: prioridade.text,
          complexidade: complexidade.text,
          tipo: tipo.text,
          dataCadastro: DateTime.now(),
          tempoEstimadoEmDias: int.parse(tempoEstimado.text),
          projeto: idProjeto);

      try {
        await DbConection.instance.insertRequisito(requisito);

        Modular.to.popAndPushNamed('/requisito', arguments: idProjeto);
        return true;
      } catch (e) {
        return false;
      }
    } else {
      return false;
    }
  }

  //-------------------INICIO REQUISITO--------------------------//
}
