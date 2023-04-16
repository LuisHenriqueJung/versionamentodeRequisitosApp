// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:versionamentorequisitos/modules/cadastro/controller/cadastro_controller.dart';

import '../../../Components/drawer_menu.dart';
import '../components/web_view.dart';
import '../controller/listagem_controller.dart';

class ListagemProjetosPage extends StatefulWidget {
  const ListagemProjetosPage({super.key});

  @override
  State<ListagemProjetosPage> createState() => _ListagemProjetosPageState();
}

class _ListagemProjetosPageState extends State<ListagemProjetosPage> {
  bool isLoading = false;
  final listagemController = Modular.get<ListagemController>();
  final cadastroController = Modular.get<CadastroController>();

  @override
  void initState() {
    super.initState();
    refreshItens();
  }

  Future refreshItens() async {
    listagemController.isLoading = true;
    await listagemController.getProjetos();
    listagemController.isLoading = false;
  }

  @override
  Widget build(BuildContext context) {
    return Observer(builder: (context) {
      return Scaffold(
          drawer: MyDrawerMenu(),
          floatingActionButton: FloatingActionButton(
            child: Icon(Icons.add),
            onPressed: () {
              cadastroController.isEdit = false;
              Modular.to.popAndPushNamed('/cadastro/projeto');
            },
          ),
          appBar: AppBar(
            title: Text('Projetos'),
          ),
          body: isLoading
              ? Center(child: CircularProgressIndicator())
              : listagemController.listProjetos.isEmpty
                  ? Center(
                      child: Text('Nenhum projeto cadastrado!'),
                    )
                  : ListView.separated(
                      itemBuilder: (context, index) {
                        return Card(
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      listagemController
                                          .listProjetos[index].nome,
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    OutlinedButton(
                                      onPressed: () {
                                        showDialog(
                                            context: context,
                                            builder: (context) => MyWebView(
                                                  linkDocumentacao:
                                                      listagemController
                                                          .listProjetos[index]
                                                          .linkDocumentacao,
                                                ));
                                      },
                                      child: Text('Ver documentação'),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                        'Responsavel: ${listagemController.listProjetos[index].responsavel?.nome}'),
                                    Text(
                                        'Prazo: ${listagemController.listProjetos[index].prazoEntrega}'),
                                  ],
                                ),
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  TextButton.icon(
                                    onPressed: () {
                                      cadastroController.projetoEdit =
                                          listagemController
                                              .listProjetos[index];
                                      cadastroController.isEdit = true;
                                      Modular.to.pushNamed('/cadastro/projeto');
                                    },
                                    icon: Icon(
                                      Icons.mode_edit,
                                    ),
                                    label: Text('Editar'),
                                  ),
                                  TextButton(
                                      onPressed: () => Modular.to.pushNamed(
                                          '/requisito',
                                          arguments: listagemController
                                              .listProjetos[index].id),
                                      child: Text('VER REQUISITOS'))
                                ],
                              ),
                            ],
                          ),
                        );
                      },
                      separatorBuilder: (context, index) => Divider(
                            height: 2,
                          ),
                      itemCount: listagemController.listProjetos.length));
    });
  }
}
