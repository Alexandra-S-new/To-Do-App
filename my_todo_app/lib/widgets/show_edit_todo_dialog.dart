import 'package:flutter/material.dart';
import 'package:my_todo_app/models/todo.dart';

Future<void> showToDoDialog({
  required BuildContext context,
  required Future<void> Function(String, String?, Priority, DateTime?) onSave,
  ToDo? todo,
}) async {
  final titleController = TextEditingController(text: todo?.title ?? '');
  final descriptionController = TextEditingController(
    text: todo?.description ?? '',
  );
  Priority selectedPriority = todo?.priority ?? Priority.medium;
  DateTime? selectedDate = todo?.dueDate;
  await showDialog<void>(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text(todo == null ? 'Neue Aufgabe' : 'Aufgabe bearbeiten'),
        content: StatefulBuilder(
          builder: (context, setDialogState) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: titleController,
                  autofocus: true,
                  decoration: const InputDecoration(
                    labelText: 'Aufgabe eingeben',
                    hintText: 'Zum Beispiel: Koffer packen',
                  ),
                ),
                TextField(
                  controller: descriptionController,
                  autofocus: false,
                  decoration: const InputDecoration(
                    labelText: 'Beschreibung hinzufügen(optional)',
                    hintText: '',
                  ),
                ),
                const SizedBox(height: 16),
                DropdownButton<Priority>(
                  value: selectedPriority,
                  isExpanded: true,
                  items: const [
                    DropdownMenuItem(
                      value: Priority.low,
                      child: Text('🟢 Niedrig'),
                    ),
                    DropdownMenuItem(
                      value: Priority.medium,
                      child: Text('🟡 Mittel'),
                    ),
                    DropdownMenuItem(
                      value: Priority.high,
                      child: Text('🔴 Hoch'),
                    ),
                  ],
                  onChanged: (Priority? value) {
                    setDialogState(() {
                      selectedPriority = value!;
                    });
                  },
                ),
                const SizedBox(height: 16),
                OutlinedButton.icon(
                  onPressed: () async {
                    final pickedDate = await showDatePicker(
                      context: context,
                      initialDate: selectedDate ?? DateTime.now(),
                      firstDate: DateTime.now(),
                      lastDate: DateTime(2100),
                    );
                    if (pickedDate != null) {
                      setDialogState(() {
                        selectedDate = pickedDate;
                      });
                    }
                  },
                  icon: const Icon(Icons.calendar_today),
                  label: Text(
                    selectedDate == null
                        ? 'Fälligkeitsdatum auswählen'
                        : '${selectedDate!.day}.${selectedDate!.month}.${selectedDate!.year}',
                  ),
                ),
              ],
            );
          },
        ),
        actions: [
          ElevatedButton(
            onPressed: () async {
              final title = titleController.text.trim();
              final description = descriptionController.text.trim();
              if (title.isEmpty) return;
              await onSave(
                title,
                description.isEmpty ? null : description,
                selectedPriority,
                selectedDate,
              );
              if (!context.mounted) return;
              Navigator.pop(context);
            },
            child: Text(todo == null ? 'Hinzufügen' : 'Speichern'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text("Abbrechen"),
          ),
        ],
      );
    },
  );
}
