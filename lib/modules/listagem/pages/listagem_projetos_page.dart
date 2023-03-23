// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_modular/flutter_modular.dart';

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
    setState(() {
      isLoading = true;
    });
    await listagemController.getProjetos();
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: isLoading
            ? Center(child: CircularProgressIndicator())
            : listagemController.listProjetos.isEmpty
                ? Center(
                    child: Text('Nenhum projeto cadastrada!'),
                  )
                : ListView.separated(
                    itemBuilder: (context, index) {
                      return ListTile(
                        title:
                            Text(listagemController.listProjetos[index].nome),
                      );
                    },
                    separatorBuilder: (context, index) => Divider(),
                    itemCount: listagemController.listProjetos.length));
  }
}
