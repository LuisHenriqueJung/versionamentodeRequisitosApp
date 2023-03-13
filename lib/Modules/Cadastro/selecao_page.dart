import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_modular/flutter_modular.dart';

class SelecaoCadastroPage extends StatelessWidget {
  const SelecaoCadastroPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cadastrar'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(28.0),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      Modular.to.pushNamed('/projeto');
                    },
                    child: Text('Novo Projeto'),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      Modular.to.pushNamed('/requisito');
                    },
                    child: Text('Novo Requisito'),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
