// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:versionamentorequisitos/utils/validators/app_validator.dart';

import '../../../Components/custom_textfield.dart';
import '../../../Components/custom_textfield_login.dart';
import '../../cadastro/controller/cadastro_controller.dart';
import '../controller/login_controller.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    var cadastroController = Modular.get<CadastroController>();
    var controller = Modular.get<LoginController>();
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(children: [
        Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/images/background.jpg'),
                  fit: BoxFit.cover)),
        ),
        Padding(
          padding: const EdgeInsets.all(50.0),
          child: Form(
            key: controller.formKeyLogin,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomTextFieldLogin(
                    validator: (campo) =>
                        AppValidator().requiredValidator(campo),
                    controller: controller.login,
                    hint: 'Digite seu login',
                    label: 'Login'),
                SizedBox(
                  height: 30,
                ),
                CustomTextFieldLogin(
                    validator: (campo) =>
                        AppValidator().requiredValidator(campo),
                    obscure: true,
                    keyboardType: TextInputType.visiblePassword,
                    controller: controller.senha,
                    hint: 'Digite sua senha',
                    label: 'Senha'),
                SizedBox(
                  height: 30,
                ),
                SizedBox(
                  width: 180,
                  child: ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(Colors.blue[400])),
                    onPressed: () {
                      controller.logar();
                    },
                    child: Text('Logar'),
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Divider(
                  height: 2,
                  color: Colors.white,
                ),
                SizedBox(
                  height: 30,
                ),
                ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(Colors.blue[400])),
                  onPressed: () {
                    cadastroController.isLogin = true;
                    Modular.to.pushNamed('cadastro/pessoa');
                  },
                  child: Text('Ainda não tenho cadastro'),
                ),
              ],
            ),
          ),
        ),
      ]),
    );
  }
}
