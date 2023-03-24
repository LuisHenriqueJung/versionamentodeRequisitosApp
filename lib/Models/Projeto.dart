// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'dart:core';

import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';

import 'package:versionamentorequisitos/Models/pessoa.dart';
import 'package:versionamentorequisitos/db/db_conection.dart';

class ProjetoFields {
  static final List<String> values = [
    id,
    nome,
    prazoEntrega,
    dataInicio,
    responsavelId
  ];

  static const String tabelaProjeto = 'projetos';
  static const String id = '_id';
  static const String nome = 'nome';
  static const String prazoEntrega = 'prazo_entrega';
  static const String dataInicio = 'data_inicio';
  static const String responsavelId = 'responsavel_id';
}

class Projeto {
  int? id;
  String nome;
  String prazoEntrega;
  DateTime dataInicio;
  int responsavelId;
  Pessoa? responsavel;
  Projeto({
    this.id,
    required this.nome,
    required this.prazoEntrega,
    required this.dataInicio,
    required this.responsavelId,
    this.responsavel,
  });

  Projeto copyWith({
    int? id,
    String? nome,
    String? prazoEntrega,
    DateTime? dataInicio,
    int? responsavelId,
  }) {
    return Projeto(
      id: id ?? this.id,
      nome: nome ?? this.nome,
      prazoEntrega: prazoEntrega ?? this.prazoEntrega,
      dataInicio: dataInicio ?? this.dataInicio,
      responsavelId: responsavelId ?? this.responsavelId,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      ProjetoFields.id: id,
      ProjetoFields.nome: nome,
      ProjetoFields.prazoEntrega: prazoEntrega,
      ProjetoFields.dataInicio: dataInicio.toIso8601String(),
      ProjetoFields.responsavelId: responsavelId,
    };
  }

  factory Projeto.fromMap(Map<String, dynamic> map) {
    return Projeto(
      id: map[ProjetoFields.id] != null ? map[ProjetoFields.id] as int : null,
      nome: map[ProjetoFields.nome] as String,
      prazoEntrega: map[ProjetoFields.prazoEntrega],
      dataInicio: DateTime.parse(map[ProjetoFields.dataInicio]),
      responsavelId: map[ProjetoFields.responsavelId],
      responsavel:
          map[ProjetoFields.responsavelId] != null ? Pessoa.fromMap(map) : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Projeto.fromJson(String source) =>
      Projeto.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Projeto(id: $id, nome: $nome, prazoEntrega: $prazoEntrega, dataInicio: $dataInicio, responsavel: $responsavelId)';
  }

  @override
  bool operator ==(covariant Projeto other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.nome == nome &&
        other.prazoEntrega == prazoEntrega &&
        other.dataInicio == dataInicio &&
        other.responsavelId == responsavelId;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        nome.hashCode ^
        prazoEntrega.hashCode ^
        dataInicio.hashCode ^
        responsavelId.hashCode;
  }
}
