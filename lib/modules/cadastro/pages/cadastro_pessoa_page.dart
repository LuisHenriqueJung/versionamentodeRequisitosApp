// ignore_for_file: prefer_const_constructors

import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:versionamentorequisitos/modules/cadastro/controller/cadastro_controller.dart';

import '../../../Components/custom_textfield.dart';
import '../../../utils/validators/app_validator.dart';

class CadastroPessoaPage extends StatelessWidget {
  CadastroPessoaPage({super.key});
  final cadastroController = Modular.get<CadastroController>();

  cadastrarPessoa() async {
    if (await cadastroController.cadastrarPessoa()) {
      Fluttertoast.showToast(msg: 'Pessoa cadastrada com sucesso!');
    } else {
      Fluttertoast.showToast(msg: 'Verifique os dados digitados!');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Cadastrar pessoa'),
        actions: [
          IconButton(onPressed: cadastrarPessoa, icon: Icon(Icons.save))
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              Observer(builder: (context) {
                return Form(
                    key: cadastroController.formKeyPessoa,
                    child: Column(
                      children: [
                        SizedBox(
                          height: 8,
                        ),
                        Column(
                          children: [
                            Row(
                              // ignore: prefer_const_literals_to_create_immutables
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 8.0),
                                  child: Text(
                                    'Dados pessoais:',
                                    style: TextStyle(
                                        decoration: TextDecoration.underline),
                                  ),
                                ),
                              ],
                            ),
                            CustomTextField(
                              validator: (valor) =>
                                  AppValidator().requiredValidator(valor),
                              controller: cadastroController.nomePessoa,
                              hint: 'Digite seu nome',
                              label: 'Nome',
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            CustomTextField(
                              validator: (cpf) =>
                                  AppValidator().cpfValidator(cpf),
                              controller: cadastroController.cpf,
                              hint: 'Digite seu CPF',
                              label: 'CPF',
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            CustomTextField(
                              validator: (valor) =>
                                  AppValidator().requiredValidator(valor),
                              controller: cadastroController.funcao,
                              hint: 'Sua função na empresa',
                              label: 'Função',
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Divider(
                          height: 2,
                        ),
                        Row(
                          // ignore: prefer_const_literals_to_create_immutables
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.only(bottom: 8.0, top: 8),
                              child: Text(
                                'Dados de acesso:',
                                style: TextStyle(
                                    decoration: TextDecoration.underline),
                              ),
                            ),
                          ],
                        ),
                        CustomTextField(
                          validator: (valor) =>
                              AppValidator().emailValidator(valor),
                          controller: cadastroController.email,
                          hint: 'Insira seu melhor e-mail',
                          label: 'E-mail',
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        CustomTextField(
                          validator: (valor) =>
                              AppValidator().requiredValidator(valor),
                          controller: cadastroController.login,
                          hint: 'Defina um login de acesso',
                          label: 'Login',
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        CustomTextField(
                          validator: (valor) =>
                              AppValidator().requiredValidator(valor),
                          controller: cadastroController.senha,
                          hint: 'Defina uma senha de acesso',
                          label: 'Senha',
                          obscure: true,
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        CustomTextField(
                          validator: (valor) => AppValidator().passwordConfirm(
                              valor, cadastroController.senha.text),
                          controller: cadastroController.confirmaSenha,
                          hint: 'Confirme sua senha',
                          label: 'Confirmação de senha',
                          obscure: true,
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            OutlinedButton(
                                onPressed: () {
                                  cadastroController.limparCamposPessoa();
                                },
                                child: const Text("Limpar campos")),
                            SizedBox(
                              width: 30,
                            ),
                            OutlinedButton(
                                onPressed: cadastrarPessoa,
                                child: const Text("Cadastrar")),
                          ],
                        ),
                      ],
                    ));
              })
            ],
          ),
        ),
      ),
    );
  }
}
