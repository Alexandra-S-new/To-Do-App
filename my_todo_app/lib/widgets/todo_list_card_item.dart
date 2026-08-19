import 'package:flutter/material.dart';
import 'package:my_todo_app/models/todo.dart';

class TodoListCardItem extends StatelessWidget {
  const TodoListCardItem({
    super.key,
    required this.todo,
    required this.priorityLabel,
    required this.priorityColor,
    required this.onChanged,
    required this.onEdit,
    required this.onDelete,
  });
  final ToDo todo;
  final String priorityLabel;
  final Color priorityColor;
  final ValueChanged<bool?> onChanged;
  final VoidCallback onEdit;
  final VoidCallback onDelete;
  @override
  Widget build(BuildContext context) {
    //Datum
    final today = DateUtils.dateOnly(DateTime.now());
    final isOverdue =
        todo.dueDate != null &&
        !todo.isCompleted &&
        DateUtils.dateOnly(todo.dueDate!).isBefore(today);
    final decoration = todo.isCompleted ? TextDecoration.lineThrough : null;
    return Card(
      margin: EdgeInsets.all(8),

      child: CheckboxListTile(
        title: Text(todo.title, style: TextStyle(decoration: decoration)),
        value: todo.isCompleted,
        onChanged: onChanged,
        secondary: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              tooltip: 'Aufgabe löschen',
              onPressed: onDelete,
              icon: Icon(Icons.delete),
            ),
            IconButton(
              tooltip: 'Aufgabe bearbeiten',
              onPressed: onEdit,
              icon: Icon(Icons.edit),
            ),
          ],
        ),
        subtitle: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [
            Text(
              priorityLabel,
              style: TextStyle(
                color: priorityColor,
                fontWeight: FontWeight.bold,
                decoration: decoration,
              ),
            ),
            if (todo.description != null)
              Text(
                todo.description ?? '',
                style: TextStyle(decoration: decoration),
              ),
            Text(
              'Erstellt am: ${todo.createdAt.day.toString().padLeft(2, '0')}.'
              '${todo.createdAt.month.toString().padLeft(2, '0')}.'
              '${todo.createdAt.year}',
              style: TextStyle(decoration: decoration),
            ),
            Row(
              children: [
                if (todo.dueDate != null)
                  Text(
                    'Fällig am: ${todo.dueDate!.day.toString().padLeft(2, '0')}.'
                    '${todo.dueDate!.month.toString().padLeft(2, '0')}.'
                    '${todo.dueDate!.year}',
                    style: TextStyle(decoration: decoration),
                  ),
                SizedBox(width: 8),
                if (isOverdue)
                  Text(
                    '- Aufgabe Überfällig',
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.error,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
