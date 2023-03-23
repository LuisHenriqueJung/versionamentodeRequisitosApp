import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobx/mobx.dart';
import 'package:versionamentorequisitos/Components/sucess_dialog_widget.dart';

import 'package:versionamentorequisitos/modules/cadastro/controller/cadastro_controller.dart';
import 'package:versionamentorequisitos/utils/validators/app_validator.dart';

import '../../../Components/custom_textfield.dart';
import '../../../Models/projeto.dart';

class CadastroProjetoPage extends StatelessWidget {
  CadastroProjetoPage({super.key});
  final cadastroController = Modular.get<CadastroController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Cadastrar projeto')),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            Form(
                key: cadastroController.formKeyProjeto,
                child: Column(
                  children: [
                    CustomTextField(
                      validator: (valor) =>
                          AppValidator().requiredValidator(valor),
                      controller: cadastroController.nomeController,
                      hint: 'Nome',
                      label: 'Nome',
                    ),
                    CustomTextField(
                      validator: (valor) =>
                          AppValidator().requiredValidator(valor),
                      controller: cadastroController.prazoEntrega,
                      hint: 'Prazo de entrega',
                      label: 'Prazo de entrega',
                    ),
                    OutlinedButton(
                        onPressed: () {
                          cadastroController.cadastrarProjeto();
                        },
                        child: const Text("Cadastrar")),
                  ],
                ))
          ],
        ),
      ),
    );
  }
}
