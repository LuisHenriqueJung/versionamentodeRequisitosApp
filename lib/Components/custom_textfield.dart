// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class CustomTextField extends StatelessWidget {
  final controller;
  final hint;
  final onChanged;
  final bool? obscure;
  final String? initialValue;
  final String label;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final String? Function(String?)? validator;
  const CustomTextField(
      {Key? key,
      required this.controller,
      this.initialValue,
      required this.hint,
      this.obscure,
      this.onChanged,
      required this.label,
      this.keyboardType,
      this.inputFormatters,
      this.validator})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: validator,
      obscureText: obscure == null ? false : true,
      inputFormatters: inputFormatters,
      keyboardType: keyboardType,
      controller: controller,
      onChanged: onChanged,
      style: const TextStyle(fontSize: 14),
      decoration: InputDecoration(
        focusedErrorBorder:
            OutlineInputBorder(borderSide: BorderSide(color: Colors.red)),
        errorBorder:
            OutlineInputBorder(borderSide: BorderSide(color: Colors.red)),
        contentPadding: const EdgeInsets.only(left: 8, right: 8),
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.blue.shade300)),
        border: const OutlineInputBorder(),
        hintText: hint,
        label: Text(label),
        floatingLabelStyle:
            MaterialStateTextStyle.resolveWith((Set<MaterialState> states) {
          final Color color = states.contains(MaterialState.focused)
              ? states.contains(MaterialState.error)
                  ? Colors.red
                  : Colors.blue.shade300
              : Colors.grey;
          return TextStyle(color: color);
        }),
        hintStyle: const TextStyle(
          fontSize: 14,
        ),
      ),
      initialValue: initialValue,
    );
  }
}
