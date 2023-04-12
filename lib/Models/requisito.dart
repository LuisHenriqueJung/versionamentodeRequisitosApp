// ignore_for_file: public_member_api_docs, sort_constructors_first, unnecessary_this
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';

import 'package:versionamentorequisitos/Models/Projeto.dart';
import 'package:versionamentorequisitos/Models/pessoa.dart';

class RequisitosFields {
  static final List<String> niveisValues = ['Baixa', 'Média', 'Alta'];
  static final List<String> tiposValues = ['Funcional', 'Não funcional'];
  static final List<String> statusValues = [
    'Não iniciado',
    'Em andamento',
    'Parado',
    'Finalizado',
  ];

  static final List<String> values = [
    id,
    descricao,
    status,
    prioridade,
    complexidade,
    tipo,
    dataCadastro,
    tempoEstimadoEmDias,
    projetoId,
    imgUrl,
    imgUrl2,
    coordenadas
  ];

  static const String tabelaRequisito = 'requisitos';
  static const String id = '_id';
  static const String descricao = 'descricao';
  static const String status = 'status';
  static const String prioridade = 'prioridade';
  static const String complexidade = 'complexidade';
  static const String tipo = 'tipo';
  static const String dataCadastro = 'data_cadastro';
  static const String tempoEstimadoEmDias = 'tempo_estimado_em_dias';
  static const String projetoId = 'projeto_id';
  static const String coordenadas = 'coordenadas';
  static const String imgUrl = 'img_url';
  static const String imgUrl2 = 'img_url2';
}

class Requisito {
  int? id;
  String descricao;
  String status;
  String prioridade;
  String complexidade;
  String tipo;
  DateTime dataCadastro;
  int tempoEstimadoEmDias;
  int projeto;
  String coordenadas;
  File imgURL;
  File imgURL2;

  Requisito({
    this.id,
    required this.descricao,
    required this.status,
    required this.prioridade,
    required this.complexidade,
    required this.tipo,
    required this.dataCadastro,
    required this.tempoEstimadoEmDias,
    required this.projeto,
    required this.coordenadas,
    required this.imgURL,
    required this.imgURL2,
  });

  Requisito copyWith(
      {int? id,
      String? descricao,
      String? status,
      String? prioridade,
      String? complexidade,
      String? tipo,
      DateTime? dataCadastro,
      int? tempoEstimadoEmDias,
      int? projeto,
      String? coordenadas,
      File? imgURL,
      File? imgURL2}) {
    return Requisito(
        id: id ?? this.id,
        descricao: descricao ?? this.descricao,
        status: status ?? this.status,
        prioridade: prioridade ?? this.prioridade,
        complexidade: complexidade ?? this.complexidade,
        tipo: tipo ?? this.tipo,
        dataCadastro: dataCadastro ?? this.dataCadastro,
        tempoEstimadoEmDias: tempoEstimadoEmDias ?? this.tempoEstimadoEmDias,
        projeto: projeto ?? this.projeto,
        coordenadas: coordenadas ?? this.coordenadas,
        imgURL: imgURL ?? this.imgURL,
        imgURL2: imgURL2 ?? this.imgURL2);
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      RequisitosFields.id: id,
      RequisitosFields.descricao: descricao,
      RequisitosFields.status: status,
      RequisitosFields.prioridade: prioridade,
      RequisitosFields.complexidade: complexidade,
      RequisitosFields.tipo: tipo,
      RequisitosFields.dataCadastro: dataCadastro.toIso8601String(),
      RequisitosFields.tempoEstimadoEmDias: tempoEstimadoEmDias,
      RequisitosFields.projetoId: projeto,
      RequisitosFields.coordenadas: coordenadas,
      RequisitosFields.imgUrl: imgURL.path,
      RequisitosFields.imgUrl2: imgURL2.path
    };
  }

  factory Requisito.fromMap(Map<String, dynamic> map) {
    return Requisito(
        id: map[RequisitosFields.id] != null
            ? map[RequisitosFields.id] as int
            : null,
        descricao: map[RequisitosFields.descricao] as String,
        status: map[RequisitosFields.status] as String,
        prioridade: map[RequisitosFields.prioridade] as String,
        complexidade: map[RequisitosFields.complexidade] as String,
        tipo: map[RequisitosFields.tipo] as String,
        dataCadastro: DateTime.parse(map[RequisitosFields.dataCadastro]),
        tempoEstimadoEmDias:
            int.parse(map[RequisitosFields.tempoEstimadoEmDias]),
        projeto: map[RequisitosFields.projetoId],
        coordenadas: map[RequisitosFields.coordenadas] as String,
        imgURL: File(map[RequisitosFields.imgUrl] as String),
        imgURL2: File(map[RequisitosFields.imgUrl2] as String));
  }

  String toJson() => json.encode(toMap());

  factory Requisito.fromJson(String source) =>
      Requisito.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Requisito(id: $id, descricao: $descricao, status: $status, prioridade: $prioridade, complexidade: $complexidade, tipo: $tipo, dataCadastro: $dataCadastro, tempoEstimadoEmDias: $tempoEstimadoEmDias, projeto: $projeto)';
  }

  @override
  bool operator ==(covariant Requisito other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.descricao == descricao &&
        other.status == status &&
        other.prioridade == prioridade &&
        other.complexidade == complexidade &&
        other.tipo == tipo &&
        other.dataCadastro == dataCadastro &&
        other.tempoEstimadoEmDias == tempoEstimadoEmDias &&
        other.projeto == projeto;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        descricao.hashCode ^
        status.hashCode ^
        prioridade.hashCode ^
        complexidade.hashCode ^
        tipo.hashCode ^
        dataCadastro.hashCode ^
        tempoEstimadoEmDias.hashCode ^
        projeto.hashCode;
  }
}
