import 'package:flutter/material.dart';
import 'package:my_todo_app/models/todo_view_enum.dart';

class TodoFilterBar extends StatelessWidget {
  const TodoFilterBar({
    super.key,
    required this.selectedFilter,
    required this.onChanged,
  });

  final ToDoFilter selectedFilter;
  final ValueChanged<ToDoFilter> onChanged;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 16,
      children: [
        FilterChip(
          label: Text("Alle"),
          selected: selectedFilter == ToDoFilter.all,
          onSelected: (_) {
            onChanged(ToDoFilter.all);
          },
        ),
        FilterChip(
          label: Text("Offene"),
          selected: selectedFilter == ToDoFilter.open,
          onSelected: (_) {
            onChanged(ToDoFilter.open);
          },
        ),
        FilterChip(
          label: Text("Erledigt"),
          selected: selectedFilter == ToDoFilter.completed,
          onSelected: (_) {
            onChanged(ToDoFilter.completed);
          },
        ),

        FilterChip(
          label: Text("Überfällig"),
          selected: selectedFilter == ToDoFilter.overTime,
          onSelected: (_) {
            onChanged(ToDoFilter.overTime);
          },
        ),
      ],
    );
  }
}
