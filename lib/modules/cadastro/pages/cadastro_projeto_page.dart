// ignore_for_file: prefer_const_constructors

import 'package:flutter/foundation.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:intl/src/intl/date_format.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobx/mobx.dart';
import 'package:versionamentorequisitos/Components/sucess_dialog_widget.dart';

import 'package:versionamentorequisitos/modules/cadastro/controller/cadastro_controller.dart';
import 'package:versionamentorequisitos/utils/validators/app_validator.dart';

import '../../../Components/custom_textfield.dart';
import '../../../Components/input_dropdowns.dart';
import '../../../Models/pessoa.dart';
import '../../../Models/projeto.dart';

class CadastroProjetoPage extends StatefulWidget {
  CadastroProjetoPage({super.key});

  @override
  State<CadastroProjetoPage> createState() => _CadastroProjetoPageState();
}

class _CadastroProjetoPageState extends State<CadastroProjetoPage> {
  final cadastroController = Modular.get<CadastroController>();
  Pessoa? dropDownValue;

  @override
  void initState() {
    setResponsaveis();
    if (cadastroController.isEdit) {
      setValoresCampos();
    }
    super.initState();
  }

  setValoresCampos() async {
    cadastroController.nomeController.text =
        cadastroController.projetoEdit.nome;
    cadastroController.responsavel.text =
        cadastroController.projetoEdit.responsavel!.nome;
    cadastroController.prazoEntrega.text =
        cadastroController.projetoEdit.prazoEntrega;
  }

  setResponsaveis() async {
    cadastroController.isLoading = true;
    await cadastroController.setPossiveisResponsaveis();

    cadastroController.isLoading = false;
  }

  updateProjeto() async {
    cadastroController.isLoading = true;

    if (await cadastroController.editarProjeto()) {
      Fluttertoast.showToast(msg: 'Projeto cadastrado com sucesso!');
    } else {
      Fluttertoast.showToast(msg: 'Verifique os dados do projeto!');
    }
    cadastroController.isLoading = false;
  }

  cadastrarProjeto() async {
    cadastroController.isLoading = true;

    if (await cadastroController.cadastrarProjeto()) {
      Fluttertoast.showToast(msg: 'Projeto cadastrado com sucesso!');
    } else {
      Fluttertoast.showToast(msg: 'Verifique os dados do projeto!');
    }
    cadastroController.isLoading = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: (cadastroController.isEdit)
            ? Text('Editar projeto')
            : Text('Cadastrar projeto'),
        actions: [
          IconButton(
              onPressed: () => (cadastroController.isEdit)
                  ? updateProjeto()
                  : cadastrarProjeto(),
              icon: Icon(Icons.save))
        ],
      ),
      body: Observer(builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(12.0),
          child: (cadastroController.isLoading)
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Center(
                      child: CircularProgressIndicator(),
                    ),
                  ],
                )
              : SingleChildScrollView(
                  child: Form(
                      key: cadastroController.formKeyProjeto,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          CustomTextField(
                            validator: (valor) =>
                                AppValidator().requiredValidator(valor),
                            controller: cadastroController.nomeController,
                            hint: 'Insira o nome do projeto',
                            label: 'Nome',
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          DropdownButtonFormField<Pessoa>(
                            decoration: MyInputDecoration('Responsavel')
                                .getDecoration(),
                            hint: Text('Selecione o responsavel'),
                            isDense: true,
                            isExpanded: true,
                            validator: (value) =>
                                AppValidator().requiredResponsavel(value),
                            value: (cadastroController.isEdit)
                                ? cadastroController.projetoEdit.responsavel
                                : dropDownValue,
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            items: cadastroController.listPessoasResponsaveis
                                .map<DropdownMenuItem<Pessoa>>((Pessoa value) {
                              return DropdownMenuItem<Pessoa>(
                                value: value,
                                child: Text(
                                  value.nome,
                                  style: TextStyle(fontSize: 14),
                                ),
                              );
                            }).toList(),
                            onChanged: (Pessoa? newValue) {
                              setState(() {
                                (cadastroController.isEdit)
                                    ? cadastroController.projetoEdit
                                        .responsavelId = newValue!.id!
                                    : dropDownValue = newValue!;
                              });

                              cadastroController.responsavel.text =
                                  newValue!.nome;
                              cadastroController.responsavelId = newValue.id!;
                            },
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Observer(builder: (context) {
                            return DateTimeField(
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              validator: (value) =>
                                  AppValidator().requiredDate(value),
                              style: TextStyle(fontSize: 14),
                              textAlign: TextAlign.left,
                              resetIcon: null,
                              decoration: InputDecoration(
                                  suffixIcon: Icon(Icons.arrow_drop_down),
                                  contentPadding: EdgeInsets.symmetric(
                                      vertical: 0, horizontal: 5),
                                  border: OutlineInputBorder(),
                                  label: Text('Prazo de entrega'),
                                  hintText: 'Selecione uma data'),
                              controller: cadastroController.prazoEntrega,
                              format: DateFormat('dd/MM/yyyy'),
                              onShowPicker: (context, currentValue) {
                                cadastroController.prazoEntrega.text =
                                    currentValue.toString();
                                return showDatePicker(
                                    context: context,
                                    firstDate: DateTime(2021),
                                    initialDate: currentValue ?? DateTime.now(),
                                    lastDate: DateTime(2100));
                              },
                            );
                          }),
                          SizedBox(
                            height: 20,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              OutlinedButton(
                                  onPressed: () =>
                                      cadastroController.limparCamposProjeto(),
                                  child: Text('Limpar campos')),
                              SizedBox(
                                width: 20,
                              ),
                              OutlinedButton(
                                  onPressed: (cadastroController.isEdit)
                                      ? updateProjeto
                                      : cadastrarProjeto,
                                  child: (cadastroController.isEdit)
                                      ? Text("Salvar alterações")
                                      : Text("Cadastrar")),
                            ],
                          ),
                        ],
                      )),
                ),
        );
      }),
    );
  }
}
