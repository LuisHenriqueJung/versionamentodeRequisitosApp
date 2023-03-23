// ignore_for_file: public_member_api_docs, sort_constructors_first
// ignore_for_file: prefer_const_constructors

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'package:versionamentorequisitos/Models/projeto.dart';
import 'package:versionamentorequisitos/Models/requisito.dart';
import 'package:versionamentorequisitos/db/db_conection.dart';
import 'package:versionamentorequisitos/modules/cadastro/controller/cadastro_controller.dart';

import '../../../Components/custom_textfield.dart';
import '../../../Components/input_dropdowns.dart';
import '../../../Components/sucess_dialog_widget.dart';
import '../../../utils/validators/app_validator.dart';

class CadastroRequisitoPage extends StatefulWidget {
  final int projetoId;
  const CadastroRequisitoPage({
    Key? key,
    required this.projetoId,
  }) : super(key: key);

  @override
  State<CadastroRequisitoPage> createState() => _CadastroRequisitoPageState();
}

class _CadastroRequisitoPageState extends State<CadastroRequisitoPage> {
  final cadastroController = Modular.get<CadastroController>();
  String? dropDownTipoValue;
  String? dropDownComplexidadeValue;
  String? dropDownPrioridadeValue;
  String? dropDownStatusValue;

  cadastrarRequisito(int projetoId) async {
    cadastroController.isLoading = true;
    await cadastroController.cadastrarRequisito(projetoId);
    cadastroController.isLoading = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Cadastrar Requisito'),
          actions: [
            IconButton(
                onPressed: () => cadastrarRequisito(widget.projetoId),
                icon: Icon(Icons.save))
          ],
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: (cadastroController.isLoading)
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : Form(
                    key: cadastroController.formKeyRequisito,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        CustomTextField(
                          validator: (valor) =>
                              AppValidator().requiredValidator(valor),
                          controller: cadastroController.descricao,
                          hint: 'Descreva o requisito',
                          label: 'Descrição',
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        DropdownButtonFormField<String>(
                          decoration:
                              MyInputDecoration('Prioridade').getDecoration(),
                          hint: Text('Selecione a prioridade'),
                          isDense: true,
                          isExpanded: true,
                          validator: (value) =>
                              AppValidator().requiredValidatorDropDown(value),
                          value: dropDownPrioridadeValue,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          items: RequisitosFields.niveisValues
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(
                                value,
                                style: TextStyle(fontSize: 14),
                              ),
                            );
                          }).toList(),
                          onChanged: (String? newValue) {
                            setState(() {
                              dropDownPrioridadeValue = newValue!;
                            });

                            cadastroController.prioridade.text = newValue!;
                          },
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        DropdownButtonFormField<String>(
                          decoration:
                              MyInputDecoration('Complexidade').getDecoration(),
                          hint: Text('Selecione a complexidade'),
                          isDense: true,
                          isExpanded: true,
                          validator: (value) =>
                              AppValidator().requiredValidatorDropDown(value),
                          value: dropDownComplexidadeValue,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          items: RequisitosFields.niveisValues
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(
                                value,
                                style: TextStyle(fontSize: 14),
                              ),
                            );
                          }).toList(),
                          onChanged: (String? newValue) {
                            setState(() {
                              dropDownComplexidadeValue = newValue!;
                            });

                            cadastroController.complexidade.text = newValue!;
                          },
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        DropdownButtonFormField<String>(
                          decoration: MyInputDecoration('Tipo').getDecoration(),
                          hint: Text('Selecione o tipo'),
                          isDense: true,
                          isExpanded: true,
                          validator: (value) =>
                              AppValidator().requiredValidatorDropDown(value),
                          value: dropDownTipoValue,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          items: RequisitosFields.tiposValues
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(
                                value,
                                style: TextStyle(fontSize: 14),
                              ),
                            );
                          }).toList(),
                          onChanged: (String? newValue) {
                            setState(() {
                              dropDownTipoValue = newValue!;
                            });

                            cadastroController.tipo.text = newValue!;
                          },
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        CustomTextField(
                          keyboardType: TextInputType.number,
                          validator: (valor) =>
                              AppValidator().requiredValidator(valor),
                          controller: cadastroController.tempoEstimado,
                          hint: 'Tempo estimado em dias',
                          label: 'Tempo estimado',
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        DropdownButtonFormField<String>(
                          decoration:
                              MyInputDecoration('Status').getDecoration(),
                          hint: Text('Selecione o status do requisito'),
                          isDense: true,
                          isExpanded: true,
                          validator: (value) =>
                              AppValidator().requiredValidatorDropDown(value),
                          value: dropDownStatusValue,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          items: RequisitosFields.statusValues
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(
                                value,
                                style: TextStyle(fontSize: 14),
                              ),
                            );
                          }).toList(),
                          onChanged: (String? newValue) {
                            setState(() {
                              dropDownStatusValue = newValue!;
                            });

                            cadastroController.status.text = newValue!;
                          },
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            OutlinedButton(
                                onPressed: () =>
                                    cadastroController.limpaCamposRequisito(),
                                child: Text('Limpar campos')),
                            SizedBox(
                              width: 20,
                            ),
                            OutlinedButton(
                                onPressed: () =>
                                    cadastrarRequisito(widget.projetoId),
                                child: const Text("Cadastrar")),
                          ],
                        ),
                      ],
                    )),
          ),
        ));
  }
}
