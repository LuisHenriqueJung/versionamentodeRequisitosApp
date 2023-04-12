// ignore_for_file: public_member_api_docs, sort_constructors_first
// ignore_for_file: prefer_const_constructors

import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:versionamentorequisitos/Models/requisito.dart';
import 'package:image_picker/image_picker.dart';
import 'package:versionamentorequisitos/modules/cadastro/controller/cadastro_controller.dart';

import 'package:versionamentorequisitos/modules/listagem/controller/listagem_controller.dart';

class ListagemRequisitosPage extends StatefulWidget {
  final int projetoId;
  const ListagemRequisitosPage({
    Key? key,
    required this.projetoId,
  }) : super(key: key);

  @override
  State<ListagemRequisitosPage> createState() => ListagemRequisitosPageState();
}

class ListagemRequisitosPageState extends State<ListagemRequisitosPage> {
  bool isLoading = false;
  final listagemController = Modular.get<ListagemController>();
  final cadastroController = Modular.get<CadastroController>();

  @override
  void initState() {
    super.initState();
    refreshItens();
  }

  Future refreshItens() async {
    listagemController.projetoId = widget.projetoId;
    listagemController.isLoading = true;
    await listagemController.getRequisitos();
    listagemController.isLoading = false;
  }

  navegarNovoRequisito() async {
    cadastroController.isEdit = false;
    await cadastroController.limpaCamposRequisito();
    Modular.to.pushNamed('/cadastro/requisito', arguments: widget.projetoId);
  }

  @override
  Widget build(BuildContext context) {
    return Observer(builder: (context) {
      return Scaffold(
        floatingActionButton: FloatingActionButton(
            onPressed: navegarNovoRequisito, child: Icon(Icons.add)),
        appBar: AppBar(
          title: Text('Requisitos'),
        ),
        body: isLoading
            ? Center(child: CircularProgressIndicator())
            : listagemController.listRequisitos.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Flexible(
                          child: Text(
                            'Ainda não foram cadastrados requisitos para esse projeto!',
                            style: TextStyle(
                              fontSize: 18,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        OutlinedButton(
                            onPressed: () => Modular.to.popAndPushNamed(
                                '/cadastro/requisito',
                                arguments: widget.projetoId),
                            child: Text('Cadastrar o primeiro requisito'))
                      ],
                    ),
                  )
                : Column(
                    children: [
                      Expanded(
                        child: ListView.builder(
                          itemCount: listagemController.listRequisitos.length,
                          itemBuilder: (context, index) {
                            final color = (listagemController
                                        .listRequisitos[index].status ==
                                    RequisitosFields.statusValues[0])
                                ? Colors.yellow[100]
                                : (listagemController
                                            .listRequisitos[index].status ==
                                        RequisitosFields.statusValues[1])
                                    ? Colors.green[100]
                                    : (listagemController
                                                .listRequisitos[index].status ==
                                            RequisitosFields.statusValues[2])
                                        ? Colors.red[50]
                                        : (listagemController
                                                    .listRequisitos[index]
                                                    .status ==
                                                RequisitosFields
                                                    .statusValues[3])
                                            ? Colors.white
                                            : Colors.grey[50];

                            return ListTile(
                              onTap: () => Fluttertoast.showToast(
                                  msg: 'Toque e segure para editar o item.'),
                              onLongPress: () {
                                cadastroController.isEdit = true;
                                cadastroController.requisitoEdit =
                                    listagemController.listRequisitos[index];
                                Modular.to.pushNamed('/cadastro/requisito/',
                                    arguments: listagemController
                                        .listRequisitos[index].projeto);
                              },
                              tileColor: color,
                              isThreeLine: true,
                              dense: true,
                              trailing: Text(listagemController
                                  .listRequisitos[index].tipo),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                      'Prioridade: ${listagemController.listRequisitos[index].prioridade}'),
                                  Text(
                                    'Status: ${listagemController.listRequisitos[index].status}',
                                    style: TextStyle(color: color),
                                  )
                                ],
                              ),
                              title: Text(listagemController
                                  .listRequisitos[index].descricao),
                            );
                          },
                        ),
                      ),
                      Container(
                        color: Colors.black26,
                        height: 50,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Text('Não iniciados:'),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Container(
                                    color: Colors.yellow[100],
                                    height: 10,
                                    width: 10,
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text('| Em andamento:'),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Container(
                                    color: Colors.green[100],
                                    height: 10,
                                    width: 10,
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Text('Parados'),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Container(
                                    color: Colors.red[100],
                                    height: 10,
                                    width: 10,
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text('| Finalizados:'),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Container(
                                    color: Colors.white,
                                    height: 10,
                                    width: 10,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
      );
    });
  }
}
