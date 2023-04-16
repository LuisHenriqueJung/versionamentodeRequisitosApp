import 'dart:io';

import 'package:flutter_modular/flutter_modular.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mobx/mobx.dart';
import 'package:flutter/material.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:versionamentorequisitos/Models/pessoa.dart';
import 'package:versionamentorequisitos/Models/projeto.dart';
import 'package:versionamentorequisitos/Models/requisito.dart';
import 'package:versionamentorequisitos/db/db_conection.dart';
import 'package:geolocator/geolocator.dart';

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
  TextEditingController linkDocumentacao = TextEditingController(text: "");
  @observable
  ObservableList<Projeto> listProjetos = ObservableList<Projeto>();
  @observable
  ObservableList<Pessoa> listPessoasResponsaveis = ObservableList<Pessoa>();

  @observable
  Projeto projetoEdit = Projeto(
      nome: 'nome',
      prazoEntrega: 'prazoEntrega',
      dataInicio: DateTime.now(),
      responsavelId: 0,
      linkDocumentacao: '');
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
  @observable
  bool isLogin = false;
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
  @observable
  File imagem1 = File('file.txt');
  @observable
  File imagem2 = File('file.txt');
  @observable
  String imagemPath = '';
  @observable
  String imagemPath2 = '';
  @observable
  Requisito requisitoEdit = Requisito(
    descricao: 'descricao',
    status: 'status',
    prioridade: 'prioridade',
    complexidade: 'complexidade',
    tipo: 'tipo',
    dataCadastro: DateTime.now(),
    tempoEstimadoEmDias: 1,
    projeto: 1,
    coordenadas: 'coordenadas',
    imgURL: File('imgURL'),
    imgURL2: File('imgURL2'),
  );
  //----REQUISITO---//

  @observable
  bool isLoading = false;
  @observable
  bool isEdit = false;

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
    nomeController.text = '';
    nomeController.clear();
    prazoEntrega.clear();
    responsavel.clear();
    linkDocumentacao.clear();
    responsavelId = 0;
    formKeyProjeto.currentState?.reset();
  }

  @action
  Future cadastrarProjeto() async {
    if (formKeyProjeto.currentState?.validate() ?? false) {
      final projeto = Projeto(
          nome: nomeController.text,
          prazoEntrega: prazoEntrega.text,
          dataInicio: DateTime.now(),
          linkDocumentacao: linkDocumentacao.text,
          responsavelId: responsavelId);
      try {
        await DbConection.instance.insertProjeto(projeto);
        limparCamposProjeto();
        Modular.to.popAndPushNamed('/listagem');
        return true;
      } catch (e) {
        return false;
      }
    } else {
      return false;
    }
  }

  @action
  Future editarProjeto() async {
    if (formKeyProjeto.currentState?.validate() ?? false) {
      projetoEdit.nome = nomeController.text;
      projetoEdit.prazoEntrega = prazoEntrega.text;
      projetoEdit.linkDocumentacao = linkDocumentacao.text;

      try {
        await DbConection.instance.updateProjeto(projetoEdit);
        isEdit = false;
        limparCamposProjeto();
        Modular.to.popAndPushNamed('/listagem');
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
        if (isLogin) {
          isLogin = false;
          Modular.to.navigate('/');
        } else {
          Modular.to.navigate('/listagem/pessoa');
        }

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
  limpaCamposRequisito() async {
    descricao.text = '';
    prioridade.clear();
    complexidade.clear();
    tipo.clear();
    tempoEstimado.clear();
    projetoId = 0;
    formKeyRequisito.currentState?.reset();
    imagemPath = '';
    imagemPath2 = '';
    imagem1 = File('');
    imagem2 = File('');
  }

  @action
  Future cadastrarRequisito(int idProjeto) async {
    if (formKeyRequisito.currentState?.validate() ?? false) {
      LocationPermission permission = await Geolocator.requestPermission();

      Position posicao = await Geolocator.getCurrentPosition();

      final coordenadas = '${posicao.latitude},${posicao.longitude}';
      final requisito = Requisito(
          descricao: descricao.text,
          status: status.text,
          prioridade: prioridade.text,
          complexidade: complexidade.text,
          tipo: tipo.text,
          dataCadastro: DateTime.now(),
          tempoEstimadoEmDias: int.parse(tempoEstimado.text),
          projeto: idProjeto,
          coordenadas: coordenadas,
          imgURL: imagem1,
          imgURL2: imagem2);

      try {
        await DbConection.instance.insertRequisito(requisito);
        await limpaCamposRequisito();

        Modular.to.pop();
        Modular.to.popAndPushNamed('/listagem/requisito', arguments: idProjeto);
        return true;
      } catch (e) {
        return false;
      }
    } else {
      return false;
    }
  }

  @action
  Future editarRequisito(Requisito requisito) async {
    if (formKeyRequisito.currentState?.validate() ?? false) {
      LocationPermission permission = await Geolocator.requestPermission();

      Position posicao = await Geolocator.getCurrentPosition();

      final coordenadas = '${posicao.latitude},${posicao.longitude}';
      requisito.descricao = descricao.text;
      requisito.status = status.text;
      requisito.prioridade = prioridade.text;
      requisito.complexidade = complexidade.text;
      requisito.tipo = tipo.text;
      requisito.tempoEstimadoEmDias = int.parse(tempoEstimado.text);
      requisito.coordenadas = coordenadas;

      try {
        await DbConection.instance.updateRequisito(requisito);
        isEdit = false;
        await limpaCamposRequisito();

        Fluttertoast.showToast(msg: 'Alterações salvas com sucesso!');

        Modular.to.pop();
        Modular.to.popAndPushNamed('/listagem/requisito',
            arguments: requisito.projeto);
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
