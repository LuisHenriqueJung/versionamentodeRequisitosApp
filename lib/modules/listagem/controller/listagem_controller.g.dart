// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'listagem_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$ListagemController on ListagemControllerBase, Store {
  late final _$listProjetosAtom =
      Atom(name: 'ListagemControllerBase.listProjetos', context: context);

  @override
  ObservableList<Projeto> get listProjetos {
    _$listProjetosAtom.reportRead();
    return super.listProjetos;
  }

  @override
  set listProjetos(ObservableList<Projeto> value) {
    _$listProjetosAtom.reportWrite(value, super.listProjetos, () {
      super.listProjetos = value;
    });
  }

  late final _$listPessoasAtom =
      Atom(name: 'ListagemControllerBase.listPessoas', context: context);

  @override
  ObservableList<Pessoa> get listPessoas {
    _$listPessoasAtom.reportRead();
    return super.listPessoas;
  }

  @override
  set listPessoas(ObservableList<Pessoa> value) {
    _$listPessoasAtom.reportWrite(value, super.listPessoas, () {
      super.listPessoas = value;
    });
  }

  late final _$listRequisitosAtom =
      Atom(name: 'ListagemControllerBase.listRequisitos', context: context);

  @override
  ObservableList<Requisito> get listRequisitos {
    _$listRequisitosAtom.reportRead();
    return super.listRequisitos;
  }

  @override
  set listRequisitos(ObservableList<Requisito> value) {
    _$listRequisitosAtom.reportWrite(value, super.listRequisitos, () {
      super.listRequisitos = value;
    });
  }

  late final _$getPessoasAsyncAction =
      AsyncAction('ListagemControllerBase.getPessoas', context: context);

  @override
  Future<ObservableList<Pessoa>> getPessoas() {
    return _$getPessoasAsyncAction.run(() => super.getPessoas());
  }

  late final _$getProjetosAsyncAction =
      AsyncAction('ListagemControllerBase.getProjetos', context: context);

  @override
  Future<ObservableList<Projeto>> getProjetos() {
    return _$getProjetosAsyncAction.run(() => super.getProjetos());
  }

  late final _$getRequisitosAsyncAction =
      AsyncAction('ListagemControllerBase.getRequisitos', context: context);

  @override
  Future<ObservableList<Requisito>> getRequisitos() {
    return _$getRequisitosAsyncAction.run(() => super.getRequisitos());
  }

  @override
  String toString() {
    return '''
listProjetos: ${listProjetos},
listPessoas: ${listPessoas},
listRequisitos: ${listRequisitos}
    ''';
  }
}
