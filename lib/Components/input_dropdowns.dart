// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class MyInputDecoration {
  final String label;

  MyInputDecoration(this.label);
  InputDecoration getDecoration() {
    return InputDecoration(
      label: Text(label),
      focusedErrorBorder:
          OutlineInputBorder(borderSide: BorderSide(color: Colors.red)),
      errorBorder:
          OutlineInputBorder(borderSide: BorderSide(color: Colors.red)),
      contentPadding: const EdgeInsets.only(left: 8, right: 8),
      focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.blue.shade300)),
      border: const OutlineInputBorder(),
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
    );
  }
}
