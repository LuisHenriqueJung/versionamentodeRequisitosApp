import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class ShowSuccesDialog extends StatefulWidget {
  final bool projeto;
  const ShowSuccesDialog({super.key, required this.projeto});

  @override
  State<ShowSuccesDialog> createState() => _ShowSuccesDialogState();
}

class _ShowSuccesDialogState extends State<ShowSuccesDialog> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Sucesso'),
      content: SingleChildScrollView(
        child: ListBody(
          children: <Widget>[
            (widget.projeto)
                ? const Text('Projeto Cadastrado com sucesso!')
                : const Text('Requisito cadastrado com sucesso'),
          ],
        ),
      ),
      actions: <Widget>[
        TextButton(
          child: const Text('OK'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}
