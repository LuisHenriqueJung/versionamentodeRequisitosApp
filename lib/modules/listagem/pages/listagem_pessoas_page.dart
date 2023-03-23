// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:versionamentorequisitos/modules/listagem/controller/listagem_controller.dart';

class ListagemPessoasPage extends StatefulWidget {
  const ListagemPessoasPage({super.key});

  @override
  State<ListagemPessoasPage> createState() => _ListagemPessoasPageState();
}

class _ListagemPessoasPageState extends State<ListagemPessoasPage> {
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
    await listagemController.getPessoas();
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
            : listagemController.listPessoas.isEmpty
                ? Center(
                    child: Text('Nenhum pessoa cadastrada!'),
                  )
                : ListView.separated(
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(listagemController.listPessoas[index].nome),
                      );
                    },
                    separatorBuilder: (context, index) => Divider(),
                    itemCount: listagemController.listPessoas.length));
  }
}
