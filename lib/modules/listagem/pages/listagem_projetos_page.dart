// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../Components/drawer_menu.dart';
import '../controller/listagem_controller.dart';

class ListagemProjetosPage extends StatefulWidget {
  const ListagemProjetosPage({super.key});

  @override
  State<ListagemProjetosPage> createState() => _ListagemProjetosPageState();
}

class _ListagemProjetosPageState extends State<ListagemProjetosPage> {
  bool isLoading = false;
  final listagemController = Modular.get<ListagemController>();

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
              onPressed: () => Modular.to.popAndPushNamed('/cadastro/projeto')),
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
                        return ListTile(
                          dense: true,
                          subtitle: Text(
                              'Id responsavel: ${listagemController.listProjetos[index].responsavelId}'),
                          trailing: Text(
                              'Prazo: ${listagemController.listProjetos[index].prazoEntrega}'),
                          onTap: () {
                            Modular.to.pushNamed('/requisito',
                                arguments:
                                    listagemController.listProjetos[index].id);
                          },
                          title: Text(
                            listagemController.listProjetos[index].nome,
                            style: TextStyle(fontSize: 16),
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
