// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Projeto.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$Projeto on _Projeto, Store {
  late final _$nomeAtom = Atom(name: '_Projeto.nome', context: context);

  @override
  String get nome {
    _$nomeAtom.reportRead();
    return super.nome;
  }

  @override
  set nome(String value) {
    _$nomeAtom.reportWrite(value, super.nome, () {
      super.nome = value;
    });
  }

  late final _$dataInicioAtom =
      Atom(name: '_Projeto.dataInicio', context: context);

  @override
  String get dataInicio {
    _$dataInicioAtom.reportRead();
    return super.dataInicio;
  }

  @override
  set dataInicio(String value) {
    _$dataInicioAtom.reportWrite(value, super.dataInicio, () {
      super.dataInicio = value;
    });
  }

  late final _$dataEntregaEstimadaAtom =
      Atom(name: '_Projeto.dataEntregaEstimada', context: context);

  @override
  String get dataEntregaEstimada {
    _$dataEntregaEstimadaAtom.reportRead();
    return super.dataEntregaEstimada;
  }

  @override
  set dataEntregaEstimada(String value) {
    _$dataEntregaEstimadaAtom.reportWrite(value, super.dataEntregaEstimada, () {
      super.dataEntregaEstimada = value;
    });
  }

  late final _$tecNomeAtom = Atom(name: '_Projeto.tecNome', context: context);

  @override
  TextEditingController get tecNome {
    _$tecNomeAtom.reportRead();
    return super.tecNome;
  }

  @override
  set tecNome(TextEditingController value) {
    _$tecNomeAtom.reportWrite(value, super.tecNome, () {
      super.tecNome = value;
    });
  }

  late final _$tecInicioAtom =
      Atom(name: '_Projeto.tecInicio', context: context);

  @override
  TextEditingController get tecInicio {
    _$tecInicioAtom.reportRead();
    return super.tecInicio;
  }

  @override
  set tecInicio(TextEditingController value) {
    _$tecInicioAtom.reportWrite(value, super.tecInicio, () {
      super.tecInicio = value;
    });
  }

  late final _$tecEntregaEstimadaAtom =
      Atom(name: '_Projeto.tecEntregaEstimada', context: context);

  @override
  TextEditingController get tecEntregaEstimada {
    _$tecEntregaEstimadaAtom.reportRead();
    return super.tecEntregaEstimada;
  }

  @override
  set tecEntregaEstimada(TextEditingController value) {
    _$tecEntregaEstimadaAtom.reportWrite(value, super.tecEntregaEstimada, () {
      super.tecEntregaEstimada = value;
    });
  }

  @override
  String toString() {
    return '''
nome: ${nome},
dataInicio: ${dataInicio},
dataEntregaEstimada: ${dataEntregaEstimada},
tecNome: ${tecNome},
tecInicio: ${tecInicio},
tecEntregaEstimada: ${tecEntregaEstimada}
    ''';
  }
}
