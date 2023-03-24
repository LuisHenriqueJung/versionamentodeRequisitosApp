// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'dart:ffi';

class PessoaFields {
  static final List<String> values = [
    id,
    nome,
    cpf,
    funcao,
    login,
    senha,
    email,
    situacao,
    dataCadastro
  ];

  static const String tabelaPessoa = 'pessoas';
  static const String id = '_id';
  static const String nome = 'nome_pessoa';
  static const String cpf = 'cpf';
  static const String funcao = 'funcao';
  static const String login = 'login';
  static const String senha = 'senha';
  static const String email = 'email';
  static const String situacao = 'situacao';
  static const String dataCadastro = 'data_cadastro';
}

class Pessoa {
  int? id;
  String nome;
  String cpf;
  String funcao;
  String login;
  String senha;
  String email;
  bool situacao;
  DateTime dataCadastro;
  Pessoa({
    this.id,
    required this.nome,
    required this.cpf,
    required this.funcao,
    required this.login,
    required this.senha,
    required this.email,
    required this.situacao,
    required this.dataCadastro,
  });

  Pessoa copyWith({
    int? id,
    String? nome,
    String? cpf,
    String? funcao,
    String? login,
    String? senha,
    String? email,
    bool? situacao,
    DateTime? dataCadastro,
  }) {
    return Pessoa(
      id: id ?? this.id,
      nome: nome ?? this.nome,
      cpf: cpf ?? this.cpf,
      funcao: funcao ?? this.funcao,
      login: login ?? this.login,
      senha: senha ?? this.senha,
      email: email ?? this.email,
      situacao: situacao ?? this.situacao,
      dataCadastro: dataCadastro ?? this.dataCadastro,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      PessoaFields.id: id,
      PessoaFields.nome: nome,
      PessoaFields.cpf: cpf,
      PessoaFields.funcao: funcao,
      PessoaFields.login: login,
      PessoaFields.senha: senha,
      PessoaFields.email: email,
      PessoaFields.situacao: situacao ? 1 : 0,
      PessoaFields.dataCadastro: dataCadastro.toIso8601String(),
    };
  }

  factory Pessoa.fromMap(Map<String, dynamic> map) {
    return Pessoa(
      id: map[PessoaFields.id] != null ? map[PessoaFields.id] as int : null,
      nome: map[PessoaFields.nome] as String,
      cpf: map[PessoaFields.cpf] as String,
      funcao: map[PessoaFields.funcao] as String,
      login: map[PessoaFields.login] as String,
      senha: map[PessoaFields.senha] as String,
      email: map[PessoaFields.email] as String,
      situacao: map[PessoaFields.situacao] == 1 ? true : false,
      dataCadastro: DateTime.parse(map[PessoaFields.dataCadastro]),
    );
  }

  String toJson() => json.encode(toMap());

  factory Pessoa.fromJson(String source) =>
      Pessoa.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Pessoa(id: $id, nome: $nome, cpf: $cpf, funcao: $funcao, login: $login, senha: $senha, email: $email, situacao: $situacao, dataCadastro: $dataCadastro)';
  }

  @override
  bool operator ==(covariant Pessoa other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.nome == nome &&
        other.cpf == cpf &&
        other.funcao == funcao &&
        other.login == login &&
        other.senha == senha &&
        other.email == email &&
        other.situacao == situacao &&
        other.dataCadastro == dataCadastro;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        nome.hashCode ^
        cpf.hashCode ^
        funcao.hashCode ^
        login.hashCode ^
        senha.hashCode ^
        email.hashCode ^
        situacao.hashCode ^
        dataCadastro.hashCode;
  }
}
