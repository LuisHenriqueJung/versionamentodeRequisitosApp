// ignore_for_file: public_member_api_docs, sort_constructors_first
// ignore_for_file: prefer_const_constructors

import 'dart:io';

import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:image/image.dart' as ImageProcess;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:versionamentorequisitos/Models/projeto.dart';
import 'package:versionamentorequisitos/Models/requisito.dart';
import 'package:versionamentorequisitos/db/db_conection.dart';
import 'package:versionamentorequisitos/modules/cadastro/controller/cadastro_controller.dart';

import '../../../Components/custom_textfield.dart';
import '../../../Components/input_dropdowns.dart';
import '../../../Components/sucess_dialog_widget.dart';
import '../../../utils/validators/app_validator.dart';
import 'package:camera_camera/camera_camera.dart';
import 'package:path_provider/path_provider.dart';

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
  @override
  void initState() {
    if (cadastroController.isEdit) {
      popularCampos();
    }
    super.initState();
  }

  final cadastroController = Modular.get<CadastroController>();
  late Requisito requisitoEdit;
  late File imagem;
  String? dropDownTipoValue;
  String? dropDownComplexidadeValue;
  String? dropDownPrioridadeValue;
  String? dropDownStatusValue;

  popularCampos() {
    requisitoEdit = cadastroController.requisitoEdit;
    cadastroController.descricao.text = requisitoEdit.descricao;
    cadastroController.prioridade.text = requisitoEdit.prioridade;
    cadastroController.complexidade.text = requisitoEdit.complexidade;
    cadastroController.tipo.text = requisitoEdit.tipo;
    cadastroController.tempoEstimado.text =
        requisitoEdit.tempoEstimadoEmDias.toString();
    cadastroController.status.text = requisitoEdit.status;
    cadastroController.imagemPath = requisitoEdit.imgURL.path;
    cadastroController.imagemPath2 = requisitoEdit.imgURL2.path;
  }

  editarRequisito() async {
    setState(() {
      cadastroController.isLoading = true;
    });

    await cadastroController.editarRequisito(requisitoEdit);
    cadastroController.isLoading = false;
    setState(() {
      cadastroController.isLoading = false;
    });
  }

  cadastrarRequisito(int projetoId) async {
    setState(() {
      cadastroController.isLoading = true;
    });

    await cadastroController.cadastrarRequisito(projetoId);

    setState(() {
      cadastroController.isLoading = false;
    });
  }

  inserirFoto() {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (_) => CameraCamera(
                  onFile: (file) async {
                    Navigator.pop(context);
                    String imgString = file.path;

                    if (cadastroController.imagemPath.isEmpty) {
                      (cadastroController.isEdit)
                          ? requisitoEdit.imgURL = file
                          : cadastroController.imagem1 = file;
                      cadastroController.imagemPath = imgString;
                    } else if (cadastroController.imagemPath2.isEmpty) {
                      (cadastroController.isEdit)
                          ? requisitoEdit.imgURL2 = file
                          : cadastroController.imagem2 = file;
                      cadastroController.imagemPath2 = imgString;
                    } else {
                      Fluttertoast.showToast(
                          msg: 'Só é possivel cadastrar 2 imagens');
                    }

                    setState(() {});
                  },
                )));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: (cadastroController.isEdit)
              ? Text('Editar requisito')
              : Text('Cadastrar Requisito'),
          actions: [
            IconButton(
                onPressed: () => (cadastroController.isEdit)
                    ? editarRequisito()
                    : cadastrarRequisito(widget.projetoId),
                icon: Icon(Icons.save))
          ],
        ),
        body: (cadastroController.isLoading)
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Center(
                    child: CircularProgressIndicator(),
                  ),
                ],
              )
            : SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Form(
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
                            value: (cadastroController.isEdit)
                                ? requisitoEdit.prioridade
                                : dropDownPrioridadeValue,
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
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
                                (cadastroController.isEdit)
                                    ? requisitoEdit.prioridade = newValue!
                                    : dropDownPrioridadeValue = newValue!;
                              });

                              cadastroController.prioridade.text = newValue!;
                            },
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          DropdownButtonFormField<String>(
                            decoration: MyInputDecoration('Complexidade')
                                .getDecoration(),
                            hint: Text('Selecione a complexidade'),
                            isDense: true,
                            isExpanded: true,
                            validator: (value) =>
                                AppValidator().requiredValidatorDropDown(value),
                            value: (cadastroController.isEdit)
                                ? requisitoEdit.complexidade
                                : dropDownComplexidadeValue,
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
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
                                (cadastroController.isEdit)
                                    ? requisitoEdit.complexidade = newValue!
                                    : dropDownComplexidadeValue = newValue!;
                              });

                              cadastroController.complexidade.text = newValue!;
                            },
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          DropdownButtonFormField<String>(
                            decoration:
                                MyInputDecoration('Tipo').getDecoration(),
                            hint: Text('Selecione o tipo'),
                            isDense: true,
                            isExpanded: true,
                            validator: (value) =>
                                AppValidator().requiredValidatorDropDown(value),
                            value: (cadastroController.isEdit)
                                ? requisitoEdit.tipo
                                : dropDownTipoValue,
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
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
                                (cadastroController.isEdit)
                                    ? requisitoEdit.tipo = newValue!
                                    : dropDownTipoValue = newValue!;
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
                            value: (cadastroController.isEdit)
                                ? requisitoEdit.status
                                : dropDownStatusValue,
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
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
                                (cadastroController.isEdit)
                                    ? requisitoEdit.status = newValue!
                                    : dropDownStatusValue = newValue!;
                              });

                              cadastroController.status.text = newValue!;
                            },
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [Text('Imagens')],
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              (cadastroController.imagemPath.isNotEmpty)
                                  ? Observer(builder: (context) {
                                      return Stack(
                                          alignment: Alignment.topRight,
                                          children: [
                                            SizedBox(
                                              height: 150,
                                              child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(12),
                                                child: Image.file(
                                                    (cadastroController.isEdit)
                                                        ? requisitoEdit.imgURL
                                                        : cadastroController
                                                            .imagem1),
                                              ),
                                            ),
                                            IconButton(
                                              onPressed: () {
                                                //print(requisitoEdit.imgURL.path);
                                                cadastroController.imagemPath =
                                                    '';
                                                cadastroController.isEdit
                                                    ? requisitoEdit.imgURL =
                                                        File('file.txt')
                                                    : cadastroController
                                                            .imagem1 =
                                                        File('file.txt');
                                                setState(() {});
                                              },
                                              icon: Icon(
                                                Icons.delete,
                                                color: Colors.red,
                                                size: 36,
                                              ),
                                            ),
                                          ]);
                                    })
                                  : InkWell(
                                      onTap: inserirFoto,
                                      child: Container(
                                        height: 150,
                                        width: 85,
                                        decoration: BoxDecoration(
                                            border: Border.all(),
                                            borderRadius:
                                                BorderRadius.circular(12)),
                                        child: Icon(Icons.add_a_photo_outlined),
                                      ),
                                    ),
                              SizedBox(
                                width: 30,
                              ),
                              (cadastroController.imagemPath2.isNotEmpty)
                                  ? Observer(builder: (context) {
                                      return Stack(
                                          alignment: Alignment.topRight,
                                          children: [
                                            SizedBox(
                                              height: 150,
                                              child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(12),
                                                child: Image.file(
                                                    (cadastroController.isEdit)
                                                        ? requisitoEdit.imgURL2
                                                        : cadastroController
                                                            .imagem2),
                                              ),
                                            ),
                                            IconButton(
                                              onPressed: () {
                                                //print(requisitoEdit.imgURL.path);
                                                cadastroController.imagemPath2 =
                                                    '';
                                                cadastroController.isEdit
                                                    ? requisitoEdit.imgURL2 =
                                                        File('file.txt')
                                                    : cadastroController
                                                            .imagem2 =
                                                        File('file.txt');
                                                setState(() {});
                                              },
                                              icon: Icon(
                                                Icons.delete,
                                                color: Colors.red,
                                                size: 36,
                                              ),
                                            ),
                                          ]);
                                    })
                                  : InkWell(
                                      onTap: inserirFoto,
                                      child: Container(
                                        height: 150,
                                        width: 85,
                                        decoration: BoxDecoration(
                                            border: Border.all(),
                                            borderRadius:
                                                BorderRadius.circular(12)),
                                        child: Icon(Icons.add_a_photo_outlined),
                                      ),
                                    )
                            ],
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
                                  onPressed: () => (cadastroController.isEdit)
                                      ? editarRequisito()
                                      : cadastrarRequisito(widget.projetoId),
                                  child: Text((cadastroController.isEdit)
                                      ? 'Salvar alterações'
                                      : "Cadastrar")),
                            ],
                          ),
                        ],
                      )),
                ),
              ));
  }
}
