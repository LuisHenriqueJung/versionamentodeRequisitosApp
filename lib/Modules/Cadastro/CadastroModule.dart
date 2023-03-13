import 'package:flutter_modular/flutter_modular.dart';

import 'package:versionamentorequisitos/Modules/Cadastro/cadastro_requisito_page.dart';
import 'package:versionamentorequisitos/Models/Projeto.dart';
import 'package:versionamentorequisitos/Modules/Cadastro/selecao_page.dart';

import 'cadastro_projeto_page.dart';

class CadastroModule extends Module {
  @override
  List<Bind> get binds => [
        Bind.singleton((i) => Projeto()),
      ];

  @override
  List<ModularRoute> get routes => [
        ChildRoute(
          '/',
          child: (context, args) => const SelecaoCadastroPage(),
        ),
        ChildRoute(
          '/requisito',
          child: (context, args) => const CadastroRequisitoPage(),
        ),
        ChildRoute(
          '/projeto',
          child: (context, args) => CadastroProjetoPage(),
        ),
      ];
}
