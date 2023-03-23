// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cadastro_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$CadastroController on CadastroControllerBase, Store {
  late final _$nomeControllerAtom =
      Atom(name: 'CadastroControllerBase.nomeController', context: context);

  @override
  TextEditingController get nomeController {
    _$nomeControllerAtom.reportRead();
    return super.nomeController;
  }

  @override
  set nomeController(TextEditingController value) {
    _$nomeControllerAtom.reportWrite(value, super.nomeController, () {
      super.nomeController = value;
    });
  }

  late final _$prazoEntregaAtom =
      Atom(name: 'CadastroControllerBase.prazoEntrega', context: context);

  @override
  TextEditingController get prazoEntrega {
    _$prazoEntregaAtom.reportRead();
    return super.prazoEntrega;
  }

  @override
  set prazoEntrega(TextEditingController value) {
    _$prazoEntregaAtom.reportWrite(value, super.prazoEntrega, () {
      super.prazoEntrega = value;
    });
  }

  late final _$responsavelAtom =
      Atom(name: 'CadastroControllerBase.responsavel', context: context);

  @override
  TextEditingController get responsavel {
    _$responsavelAtom.reportRead();
    return super.responsavel;
  }

  @override
  set responsavel(TextEditingController value) {
    _$responsavelAtom.reportWrite(value, super.responsavel, () {
      super.responsavel = value;
    });
  }

  late final _$nomePessoaAtom =
      Atom(name: 'CadastroControllerBase.nomePessoa', context: context);

  @override
  TextEditingController get nomePessoa {
    _$nomePessoaAtom.reportRead();
    return super.nomePessoa;
  }

  @override
  set nomePessoa(TextEditingController value) {
    _$nomePessoaAtom.reportWrite(value, super.nomePessoa, () {
      super.nomePessoa = value;
    });
  }

  late final _$cpfAtom =
      Atom(name: 'CadastroControllerBase.cpf', context: context);

  @override
  TextEditingController get cpf {
    _$cpfAtom.reportRead();
    return super.cpf;
  }

  @override
  set cpf(TextEditingController value) {
    _$cpfAtom.reportWrite(value, super.cpf, () {
      super.cpf = value;
    });
  }

  late final _$funcaoAtom =
      Atom(name: 'CadastroControllerBase.funcao', context: context);

  @override
  TextEditingController get funcao {
    _$funcaoAtom.reportRead();
    return super.funcao;
  }

  @override
  set funcao(TextEditingController value) {
    _$funcaoAtom.reportWrite(value, super.funcao, () {
      super.funcao = value;
    });
  }

  late final _$loginAtom =
      Atom(name: 'CadastroControllerBase.login', context: context);

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
      Atom(name: 'CadastroControllerBase.senha', context: context);

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

  late final _$confirmaSenhaAtom =
      Atom(name: 'CadastroControllerBase.confirmaSenha', context: context);

  @override
  TextEditingController get confirmaSenha {
    _$confirmaSenhaAtom.reportRead();
    return super.confirmaSenha;
  }

  @override
  set confirmaSenha(TextEditingController value) {
    _$confirmaSenhaAtom.reportWrite(value, super.confirmaSenha, () {
      super.confirmaSenha = value;
    });
  }

  late final _$emailAtom =
      Atom(name: 'CadastroControllerBase.email', context: context);

  @override
  TextEditingController get email {
    _$emailAtom.reportRead();
    return super.email;
  }

  @override
  set email(TextEditingController value) {
    _$emailAtom.reportWrite(value, super.email, () {
      super.email = value;
    });
  }

  late final _$listProjetosAtom =
      Atom(name: 'CadastroControllerBase.listProjetos', context: context);

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
      Atom(name: 'CadastroControllerBase.listPessoas', context: context);

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

  late final _$cadastrarProjetoAsyncAction =
      AsyncAction('CadastroControllerBase.cadastrarProjeto', context: context);

  @override
  Future<dynamic> cadastrarProjeto() {
    return _$cadastrarProjetoAsyncAction.run(() => super.cadastrarProjeto());
  }

  late final _$cadastrarPessoaAsyncAction =
      AsyncAction('CadastroControllerBase.cadastrarPessoa', context: context);

  @override
  Future<dynamic> cadastrarPessoa() {
    return _$cadastrarPessoaAsyncAction.run(() => super.cadastrarPessoa());
  }

  @override
  String toString() {
    return '''
nomeController: ${nomeController},
prazoEntrega: ${prazoEntrega},
responsavel: ${responsavel},
nomePessoa: ${nomePessoa},
cpf: ${cpf},
funcao: ${funcao},
login: ${login},
senha: ${senha},
confirmaSenha: ${confirmaSenha},
email: ${email},
listProjetos: ${listProjetos},
listPessoas: ${listPessoas}
    ''';
  }
}
