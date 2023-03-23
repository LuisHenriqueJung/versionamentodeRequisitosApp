// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_modular/flutter_modular.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('O que você que fazer?'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            OutlinedButton.icon(
                onPressed: () {
                  Modular.to.pushNamed('/cadastro/pessoa');
                },
                icon: Icon(Icons.people),
                label: Text('Cadastrar pessoa')),
            OutlinedButton.icon(
                onPressed: () {
                  Modular.to.pushNamed('/cadastro/projeto');
                },
                icon: Icon(Icons.people),
                label: Text('Cadastrar projeto')),
            OutlinedButton.icon(
                onPressed: () {
                  Modular.to.pushNamed('/listagem/pessoas');
                },
                icon: Icon(Icons.people),
                label: Text('Listar pessoas')),
            OutlinedButton.icon(
                onPressed: () {
                  Modular.to.pushNamed('/listagem/projetos');
                },
                icon: Icon(Icons.people),
                label: Text('Listar projetos')),
          ],
        ),
      ),
    );
  }
}
