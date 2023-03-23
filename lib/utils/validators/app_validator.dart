import 'package:brasil_fields/brasil_fields.dart';
import 'package:email_validator/email_validator.dart';

class AppValidator {
  String? requiredValidator(String? campo) {
    if (campo?.isEmpty ?? false) {
      return 'Campo requerido!';
    } else {
      return null;
    }
  }

  String? cpfValidator(String? cpf) {
    cpf?.replaceAll(RegExp(r"[^0-9]"), "");
    if (!CPFValidator.isValid(cpf)) {
      return 'CPF incorreto!';
    } else {
      return null;
    }
  }

  String? passwordConfirm(String? password, String? confirmPassword) {
    if ((password?.trim().isNotEmpty ?? false) &&
        (confirmPassword!.trim() == password!.trim())) {
      return null;
    } else {
      return 'As senhas não conferem!';
    }
  }

  String? emailValidator(String? email) {
    if ((email?.isNotEmpty ?? false) &&
        !EmailValidator.validate(email!.trim())) {
      return 'Email inválido!';
    } else if (email?.isEmpty ?? false) {
      return 'Email requerido!';
    } else {
      return null;
    }
  }
}
