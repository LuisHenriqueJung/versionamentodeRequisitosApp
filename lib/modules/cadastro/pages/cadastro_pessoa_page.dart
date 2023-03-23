// ignore_for_file: prefer_const_constructors

import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:versionamentorequisitos/modules/cadastro/controller/cadastro_controller.dart';

import '../../../Components/custom_textfield.dart';
import '../../../utils/validators/app_validator.dart';

class CadastroPessoaPage extends StatelessWidget {
  const CadastroPessoaPage({super.key});

  @override
  Widget build(BuildContext context) {
    final cadastroController = Modular.get<CadastroController>();
    return Scaffold(
      appBar: AppBar(title: const Text('Cadastrar pessoa')),
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
                          height: 20,
                        ),
                        CustomTextField(
                          validator: (valor) =>
                              AppValidator().requiredValidator(valor),
                          controller: cadastroController.nomePessoa,
                          hint: 'Nome',
                          label: 'Nome',
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        CustomTextField(
                          validator: (cpf) => AppValidator().cpfValidator(cpf),
                          controller: cadastroController.cpf,
                          hint: 'CPF',
                          label: 'CPF',
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        CustomTextField(
                          validator: (valor) =>
                              AppValidator().requiredValidator(valor),
                          controller: cadastroController.funcao,
                          hint: 'Função',
                          label: 'Função',
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        CustomTextField(
                          validator: (valor) =>
                              AppValidator().emailValidator(valor),
                          controller: cadastroController.email,
                          hint: 'E-mail',
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
                          label: 'Defina um login de acesso',
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        CustomTextField(
                          validator: (valor) =>
                              AppValidator().requiredValidator(valor),
                          controller: cadastroController.senha,
                          hint: 'Defina uma senha de acesso',
                          label: 'Defina uma senha de acesso',
                          obscure: true,
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        CustomTextField(
                          validator: (valor) => AppValidator().passwordConfirm(
                              valor, cadastroController.senha.text),
                          controller: cadastroController.confirmaSenha,
                          hint: 'Confirme a senha',
                          label: 'Confirme a senha',
                          obscure: true,
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        OutlinedButton(
                            onPressed: () {
                              cadastroController.cadastrarPessoa();
                            },
                            child: const Text("Cadastrar")),
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
