import 'package:flutter/material.dart';
import 'package:my_todo_app/models/todo.dart';

Future<bool> showRemoveDialog(BuildContext context, ToDo todo) async {
  final shouldDelete = await showDialog<bool>(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text('Aufgabe "${todo.title}" löschen'),
        content: const Text('Diese Aufgabe wird dauerhaft gelöscht.'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context, false);
            },
            child: const Text('Abbrechen'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context, true);
            },
            child: const Text('Löschen'),
          ),
        ],
      );
    },
  );

  return shouldDelete ?? false;
}
