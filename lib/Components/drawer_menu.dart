// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_modular/flutter_modular.dart';

class MyDrawerMenu extends StatelessWidget {
  const MyDrawerMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Drawer(
        child: Column(
          children: [
            Expanded(
              child: ListView(
                children: [
                  Container(
                    padding: EdgeInsets.only(top: 10, bottom: 5),
                    child: Center(
                      child: Text(
                        'Menu',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  Divider(
                    height: 2,
                  ),
                  ListTile(
                    selectedTileColor: Colors.grey.shade300,
                    selectedColor: Colors.black,
                    leading: const Icon(Icons.list),
                    onTap: () {
                      Modular.to.popAndPushNamed('/');
                    },
                    title: const Text('Listar projetos'),
                  ),
                  Divider(
                    height: 2,
                  ),
                  ListTile(
                    dense: true,
                    selectedTileColor: Colors.grey.shade300,
                    selectedColor: Colors.black,
                    leading: const Icon(Icons.playlist_add_rounded),
                    onTap: () {
                      Modular.to.pushNamed('/cadastro/projeto');
                    },
                    title: const Text('Cadastrar Projeto'),
                  ),
                  Divider(
                    height: 2,
                  ),
                  ListTile(
                    dense: true,
                    selectedTileColor: Colors.grey.shade300,
                    selectedColor: Colors.black,
                    leading: const Icon(Icons.groups_outlined),
                    onTap: () {
                      Modular.to.pushNamed('/pessoa');
                    },
                    title: const Text('Listar pessoas'),
                  ),
                  Divider(
                    height: 4,
                  ),
                  ListTile(
                    dense: true,
                    selectedTileColor: Colors.grey.shade300,
                    selectedColor: Colors.black,
                    leading: const Icon(Icons.person_add_alt_1_outlined),
                    onTap: () {
                      Modular.to.pushNamed('/cadastro/pessoa');
                    },
                    title: const Text('Cadastrar Pessoa'),
                  ),
                ],
              ),
            ),
            Container(
                height: 100,
                child: Column(
                  // ignore: prefer_const_literals_to_create_immutables
                  children: [
                    Divider(
                      height: 2,
                    ),
                    ListTile(
                      onTap: () {
                        Modular.to.popAndPushNamed('/');
                      },
                      dense: true,
                      leading: Icon(
                        Icons.exit_to_app,
                        color: Colors.black,
                      ),
                      title: Text('Inicio'),
                    ),
                    Divider(
                      height: 2,
                    ),
                  ],
                )),
          ],
        ),
      ),
    );
  }
}
