import 'package:flutter_modular/flutter_modular.dart';

import 'package:versionamentorequisitos/Models/projeto.dart';
import 'package:versionamentorequisitos/modules/home/home_module.dart';
import 'package:versionamentorequisitos/modules/listagem/controller/listagem_controller.dart';

import 'modules/cadastro/cadastro_module.dart';
import 'modules/listagem/listagem_module.dart';

class AppModule extends Module {
  @override
  List<Bind> get binds => [Bind.singleton((i) => ListagemController())];

  @override
  List<ModularRoute> get routes => [
        ModuleRoute('/home', module: HomeModule()),
        ModuleRoute('/cadastro', module: CadastroModule()),
        ModuleRoute('/', module: ListagemModule()),
      ];
}
