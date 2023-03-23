import 'package:flutter_modular/flutter_modular.dart';
import 'package:versionamentorequisitos/modules/listagem/pages/listagem_pessoas_page.dart';
import 'package:versionamentorequisitos/modules/listagem/pages/listagem_projetos_page.dart';

class ListagemModule extends Module {
  @override
  List<Bind> get binds => [];

  @override
  List<ModularRoute> get routes => [
        ChildRoute(
          '/pessoas',
          child: (context, args) => const ListagemPessoasPage(),
        ),
        ChildRoute(
          '/projetos',
          child: (context, args) => const ListagemProjetosPage(),
        ),
      ];
}
