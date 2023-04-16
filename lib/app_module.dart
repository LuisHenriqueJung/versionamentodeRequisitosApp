import 'package:flutter_modular/flutter_modular.dart';

import 'package:versionamentorequisitos/Models/projeto.dart';
import 'package:versionamentorequisitos/modules/home/controller/login_controller.dart';
import 'package:versionamentorequisitos/modules/home/home_module.dart';
import 'package:versionamentorequisitos/modules/listagem/controller/listagem_controller.dart';

import 'modules/cadastro/cadastro_module.dart';
import 'modules/cadastro/controller/cadastro_controller.dart';
import 'modules/listagem/listagem_module.dart';

class AppModule extends Module {
  @override
  List<Bind> get binds => [
        Bind.singleton((i) => ListagemController()),
        Bind.singleton((i) => CadastroController()),
        Bind.singleton((i) => LoginController())
      ];

  @override
  List<ModularRoute> get routes => [
        ModuleRoute('/', module: HomeModule()),
        ModuleRoute('/cadastro', module: CadastroModule()),
        ModuleRoute('/listagem', module: ListagemModule()),
      ];
}
