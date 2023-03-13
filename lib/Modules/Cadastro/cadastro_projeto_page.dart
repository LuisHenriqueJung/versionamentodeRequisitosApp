import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobx/mobx.dart';
import 'package:versionamentorequisitos/Components/sucess_dialog_widget.dart';

import '../../Models/Projeto.dart';

class CadastroProjetoPage extends StatelessWidget {
  CadastroProjetoPage({super.key});
  final projeto = Modular.get<Projeto>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Cadastrar projeto')),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            TextFormField(
              controller: projeto.tecNome,
              onChanged: ((value) {
                projeto.nome = value;
              }),
              decoration: const InputDecoration(
                  contentPadding: EdgeInsets.all(4),
                  border: OutlineInputBorder(),
                  hintText: 'Nome do projeto'),
            ),
            const SizedBox(
              height: 12,
            ),
            TextFormField(
              controller: projeto.tecInicio,
              onChanged: ((value) {}),
              decoration: const InputDecoration(
                  contentPadding: EdgeInsets.all(4),
                  border: OutlineInputBorder(),
                  hintText: 'Data de inicio'),
            ),
            const SizedBox(
              height: 12,
            ),
            TextFormField(
              controller: projeto.tecEntregaEstimada,
              decoration: const InputDecoration(
                  contentPadding: EdgeInsets.all(4),
                  border: OutlineInputBorder(),
                  hintText: 'Entrega estimada'),
            ),
            const SizedBox(
              height: 12,
            ),
            OutlinedButton(
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return const ShowSuccesDialog(projeto: true);
                      });
                  projeto.tecEntregaEstimada.clear();
                  projeto.tecInicio.clear();
                  projeto.tecNome.clear();
                },
                child: const Text("Salvar")),
          ],
        ),
      ),
    );
  }
}
