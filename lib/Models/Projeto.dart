import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
part 'Projeto.g.dart';

class Projeto = _Projeto with _$Projeto;

abstract class _Projeto with Store {
  @observable
  String nome = '';
  @observable
  String dataInicio = '';
  @observable
  String dataEntregaEstimada = '';
  @observable
  TextEditingController tecNome = TextEditingController();
  @observable
  TextEditingController tecInicio = TextEditingController();
  @observable
  TextEditingController tecEntregaEstimada = TextEditingController();
}
