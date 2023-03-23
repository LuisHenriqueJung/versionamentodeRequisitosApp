// ignore_for_file: prefer_const_constructors

import 'package:flutter_modular/flutter_modular.dart';

import 'package:versionamentorequisitos/Models/projeto.dart';
import 'package:versionamentorequisitos/modules/cadastro/pages/cadastro_pessoa_page.dart';

import 'controller/cadastro_controller.dart';
import 'pages/cadastro_projeto_page.dart';
import 'pages/cadastro_requisito_page.dart';

class CadastroModule extends Module {
  @override
  List<Bind> get binds => [Bind.singleton((i) => CadastroController())];

  @override
  List<ModularRoute> get routes => [
        ChildRoute(
          '/requisito',
          child: (context, args) => const CadastroRequisitoPage(),
        ),
        ChildRoute(
          '/projeto',
          child: (context, args) => CadastroProjetoPage(),
        ),
        ChildRoute(
          '/pessoa',
          child: (context, args) => CadastroPessoaPage(),
        ),
      ];
}
