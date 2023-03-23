// ignore_for_file: depend_on_referenced_packages

import 'dart:io';

import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:versionamentorequisitos/Models/projeto.dart';
import 'package:versionamentorequisitos/Models/pessoa.dart';
import 'package:versionamentorequisitos/Models/requisito.dart';

class DbConection {
  static final DbConection instance = DbConection._init();

  static Database? _database;

  DbConection._init();
  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB('VersionamentoRequisitos.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);
    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    const idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    const textType = 'TEXT NOT NULL';
    const numberType = 'INTEGER NOT NULL';

    await db.execute('''CREATE TABLE ${PessoaFields.tabelaPessoa} (
     ${PessoaFields.id} $idType,
     ${PessoaFields.nome} $textType,
     ${PessoaFields.cpf} $textType,
     ${PessoaFields.funcao} $textType,
     ${PessoaFields.login} $textType,
     ${PessoaFields.senha} $textType,
     ${PessoaFields.email} $textType,
     ${PessoaFields.situacao} $textType,
     ${PessoaFields.dataCadastro} $textType
    )''');

    await db.execute('''CREATE TABLE ${ProjetoFields.tabelaProjeto} (
     ${ProjetoFields.id} $idType,
     ${ProjetoFields.nome} $textType,
     ${ProjetoFields.prazoEntrega} $textType,
     ${ProjetoFields.dataInicio} $textType,
     ${ProjetoFields.responsavelId} $numberType
    )''');

    await db.execute('''CREATE TABLE ${RequisitosFields.tabelaRequisito} (
    ${RequisitosFields.id} $idType,
    ${RequisitosFields.descricao} $textType,
    ${RequisitosFields.status} $textType,
    ${RequisitosFields.prioridade} $textType,
    ${RequisitosFields.complexidade} $textType,
    ${RequisitosFields.tipo} $textType,
    ${RequisitosFields.dataCadastro} $textType,
    ${RequisitosFields.tempoEstimadoEmDias} $textType,
    ${RequisitosFields.projetoId} $numberType

    )''');
  }

  Future close() async {
    final db = await instance.database;
    db.close();
  }

  //---------------------------INICIO PESSOA----------------------//

  Future<Pessoa> insertPessoa(Pessoa pessoa) async {
    final db = await instance.database;
    final id = await db.insert(PessoaFields.tabelaPessoa, pessoa.toMap());
    return pessoa.copyWith(id: id);
  }

  Future<Pessoa> readPessoa(int id) async {
    final db = await instance.database;
    final maps = await db.query(
      PessoaFields.tabelaPessoa,
      columns: PessoaFields.values,
      where: '${PessoaFields.id} = ?',
      whereArgs: [id],
    );
    if (maps.isNotEmpty) {
      return Pessoa.fromMap(maps.first);
    } else {
      throw Exception('Id $id não encontrado');
    }
  }

  Future<List<Pessoa>> readAllPessoas() async {
    final db = await instance.database;
    final results = await db.query(PessoaFields.tabelaPessoa,
        orderBy: '${PessoaFields.id} ASC');

    return results.map((json) => Pessoa.fromMap(json)).toList();
  }

  Future<int> updatePessoa(Pessoa pessoa) async {
    final db = await instance.database;

    return db.update(PessoaFields.tabelaPessoa, pessoa.toMap(),
        where: '${PessoaFields.id} = ? ', whereArgs: [pessoa.id]);
  }

  Future<int> deletePessoa(int id) async {
    final db = await instance.database;

    return db.delete(PessoaFields.tabelaPessoa,
        where: '${PessoaFields.id} = ? ', whereArgs: [id]);
  }

  //---------------------------FIM PESSOA----------------------//
  //------------------------INICIO PROJETO---------------------//
  Future<Projeto> insertProjeto(Projeto projeto) async {
    final db = await instance.database;
    final id = await db.insert(ProjetoFields.tabelaProjeto, projeto.toMap());
    return projeto.copyWith(id: id);
  }

  Future<Projeto> readProjeto(int id) async {
    final db = await instance.database;
    final maps = await db.query(
      ProjetoFields.tabelaProjeto,
      columns: ProjetoFields.values,
      where: '${ProjetoFields.id} = ?',
      whereArgs: [id],
    );
    if (maps.isNotEmpty) {
      return Projeto.fromMap(maps.first);
    } else {
      throw Exception('Id $id não encontrado');
    }
  }

  Future<List<Projeto>> readAllProjetos() async {
    final db = await instance.database;
    final results = await db.query(ProjetoFields.tabelaProjeto,
        orderBy: '${ProjetoFields.id} ASC');

    return results.map((json) => Projeto.fromMap(json)).toList();
  }

  Future<int> updateProjeto(Projeto projeto) async {
    final db = await instance.database;

    return db.update(ProjetoFields.tabelaProjeto, projeto.toMap(),
        where: '${ProjetoFields.id} = ? ', whereArgs: [projeto.id]);
  }

  Future<int> deleteProjeto(int id) async {
    final db = await instance.database;

    return db.delete(ProjetoFields.tabelaProjeto,
        where: '${ProjetoFields.id} = ? ', whereArgs: [id]);
  }

  //------------------------FIM PROJETO---------------------------//
  //------------------------INICIO REQUISITOS---------------------//
  Future<Requisito> insertRequisito(Requisito requisito) async {
    final db = await instance.database;
    final id =
        await db.insert(RequisitosFields.tabelaRequisito, requisito.toMap());
    return requisito.copyWith(id: id);
  }

  Future<List<Requisito>> readRequisitoByProjeto(int id) async {
    List<Requisito> listRequisitos = [];
    final db = await instance.database;
    final maps = await db.query(
      RequisitosFields.tabelaRequisito,
      columns: RequisitosFields.values,
      where: '${RequisitosFields.projetoId} = ?',
      whereArgs: [id],
    );
    if (maps.isNotEmpty) {
      for (var element in maps) {
        listRequisitos.add(Requisito.fromMap(element));
      }
      return listRequisitos;
    } else {
      return listRequisitos;
    }
  }

  Future<Requisito> readRequisitoByProject(int idProjeto) async {
    final db = await instance.database;
    final maps = await db.query(
      RequisitosFields.tabelaRequisito,
      columns: RequisitosFields.values,
      where: '${RequisitosFields.projetoId} = ?',
      whereArgs: [idProjeto],
    );
    if (maps.isNotEmpty) {
      return Requisito.fromMap(maps.first);
    } else {
      throw Exception('Id $idProjeto não encontrado');
    }
  }

  Future<List<Requisito>> readAllRequisitos() async {
    final db = await instance.database;
    final results = await db.query(RequisitosFields.tabelaRequisito,
        orderBy: '${RequisitosFields.id} ASC');

    return results.map((json) => Requisito.fromMap(json)).toList();
  }

  Future<int> updateRequisito(Requisito requisito) async {
    final db = await instance.database;

    return db.update(RequisitosFields.tabelaRequisito, requisito.toMap(),
        where: '${RequisitosFields.id} = ? ', whereArgs: [requisito.id]);
  }

  Future<int> deleteRequisito(int id) async {
    final db = await instance.database;

    return db.delete(RequisitosFields.tabelaRequisito,
        where: '${RequisitosFields.id} = ? ', whereArgs: [id]);
  }

  //------------------------FIM REQUISITOS---------------------//
}
