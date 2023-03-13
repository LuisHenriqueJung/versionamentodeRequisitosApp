import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:versionamentorequisitos/Models/Projeto.dart';

import '../../Components/sucess_dialog_widget.dart';

const List<String> listProjeto = <String>[
  'Selecione o projeto',
  'Projeto 2',
  ' Projeto 3',
  ' Projeto 4'
];
const List<String> listPrioridade = <String>[
  'Prioridade do requisito',
  'Alta',
  'Média',
  'Baixa'
];
const List<String> complexidade = <String>[
  'Complexidade do requisito',
  'Alta',
  'Média',
  'Baixa'
];

class CadastroRequisitoPage extends StatefulWidget {
  const CadastroRequisitoPage({super.key});

  @override
  State<CadastroRequisitoPage> createState() => _CadastroRequisitoPageState();
}

class _CadastroRequisitoPageState extends State<CadastroRequisitoPage> {
  String dropdownProjetoValue = listProjeto.first;
  String dropdownPrioridadeoValue = listPrioridade.first;
  String dropdownComplexidadeValue = complexidade.first;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cadastrar requisito'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Container(
              width: MediaQuery.of(context).size.width * 0.95,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(
                    color: Colors.black45,
                  )),
              child: DropdownButton(
                  icon: Container(),
                  underline: Container(),
                  value: dropdownProjetoValue,
                  items:
                      listProjeto.map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 12, right: 28.0),
                        child: Text(value),
                      ),
                    );
                  }).toList(),
                  onChanged: ((String? value) {
                    setState(() {
                      dropdownProjetoValue = value!;
                    });
                  })),
            ),
            const SizedBox(
              height: 12,
            ),
            Container(
              width: MediaQuery.of(context).size.width * 0.95,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(
                    color: Colors.black45,
                  )),
              child: DropdownButton(
                  icon: Container(),
                  alignment: AlignmentDirectional.centerStart,
                  underline: Container(),
                  value: dropdownPrioridadeoValue,
                  items: listPrioridade
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 12, right: 28.0),
                        child: Text(value),
                      ),
                    );
                  }).toList(),
                  onChanged: ((String? value) {
                    setState(() {
                      dropdownPrioridadeoValue = value!;
                    });
                  })),
            ),
            const SizedBox(
              height: 12,
            ),
            Container(
              width: MediaQuery.of(context).size.width * 0.95,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(
                    color: Colors.black45,
                  )),
              child: DropdownButton(
                  icon: Container(),
                  alignment: AlignmentDirectional.centerStart,
                  underline: Container(),
                  value: dropdownComplexidadeValue,
                  items: complexidade
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 12, right: 28.0),
                        child: Text(value),
                      ),
                    );
                  }).toList(),
                  onChanged: ((String? value) {
                    setState(() {
                      dropdownComplexidadeValue = value!;
                    });
                  })),
            ),
            const SizedBox(
              height: 12,
            ),
            OutlinedButton(
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return const ShowSuccesDialog(projeto: false);
                      });
                  setState(() {
                    dropdownProjetoValue = listProjeto.first;
                    dropdownPrioridadeoValue = listPrioridade.first;
                    dropdownComplexidadeValue = complexidade.first;
                  });
                },
                child: const Text("Salvar")),
          ],
        ),
      ),
    );
  }
}
