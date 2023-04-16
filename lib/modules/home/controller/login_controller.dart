import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mobx/mobx.dart';
import 'package:versionamentorequisitos/db/db_conection.dart';
import 'package:versionamentorequisitos/modules/cadastro/controller/cadastro_controller.dart';

import '../../../Models/pessoa.dart';

part 'login_controller.g.dart';

class LoginController = LoginControllerBase with _$LoginController;

abstract class LoginControllerBase with Store {
  @observable
  TextEditingController login = TextEditingController();

  @observable
  TextEditingController senha = TextEditingController();

  @observable
  ObservableList<Pessoa> listPessoas = ObservableList();
  @observable
  bool existes = false;

  final formKeyLogin = GlobalKey<FormState>();

  @action
  logar() async {
    if (formKeyLogin.currentState?.validate() ?? false) {
      try {
        listPessoas =
            ObservableList.of(await DbConection.instance.readAllPessoas());

        for (var pessoa in listPessoas) {
          if (pessoa.login == login.text && pessoa.senha == senha.text) {
            existes = true;
          }
        }
        if (!existes) {
          Fluttertoast.showToast(
              msg: 'Usuário não encontrado, verifique os dados');
        } else {
          existes = false;
          login.clear();
          senha.clear();
          Modular.to.navigate('/listagem');
        }
      } catch (e) {
        Fluttertoast.showToast(msg: 'Erro ao fazer login');
      }
    } else {
      Fluttertoast.showToast(msg: 'Verifique os dados');
    }
  }
}
