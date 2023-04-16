// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$LoginController on LoginControllerBase, Store {
  late final _$loginAtom =
      Atom(name: 'LoginControllerBase.login', context: context);

  @override
  TextEditingController get login {
    _$loginAtom.reportRead();
    return super.login;
  }

  @override
  set login(TextEditingController value) {
    _$loginAtom.reportWrite(value, super.login, () {
      super.login = value;
    });
  }

  late final _$senhaAtom =
      Atom(name: 'LoginControllerBase.senha', context: context);

  @override
  TextEditingController get senha {
    _$senhaAtom.reportRead();
    return super.senha;
  }

  @override
  set senha(TextEditingController value) {
    _$senhaAtom.reportWrite(value, super.senha, () {
      super.senha = value;
    });
  }

  late final _$listPessoasAtom =
      Atom(name: 'LoginControllerBase.listPessoas', context: context);

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

  late final _$existesAtom =
      Atom(name: 'LoginControllerBase.existes', context: context);

  @override
  bool get existes {
    _$existesAtom.reportRead();
    return super.existes;
  }

  @override
  set existes(bool value) {
    _$existesAtom.reportWrite(value, super.existes, () {
      super.existes = value;
    });
  }

  late final _$logarAsyncAction =
      AsyncAction('LoginControllerBase.logar', context: context);

  @override
  Future logar() {
    return _$logarAsyncAction.run(() => super.logar());
  }

  @override
  String toString() {
    return '''
login: ${login},
senha: ${senha},
listPessoas: ${listPessoas},
existes: ${existes}
    ''';
  }
}
