import 'package:flutter_modular/flutter_modular.dart';
import 'package:versionamentorequisitos/modules/listagem/pages/listagem_pessoas_page.dart';
import 'package:versionamentorequisitos/modules/listagem/pages/listagem_projetos_page.dart';

import 'pages/listagem_requsitos_page.dart';

class ListagemModule extends Module {
  @override
  List<Bind> get binds => [];

  @override
  List<ModularRoute> get routes => [
        ChildRoute(
          '/pessoa',
          child: (context, args) => const ListagemPessoasPage(),
        ),
        ChildRoute(
          '/',
          child: (context, args) => const ListagemProjetosPage(),
        ),
        ChildRoute(
          '/requisito',
          child: (context, args) =>
              ListagemRequisitosPage(projetoId: args.data),
        ),
      ];
}
