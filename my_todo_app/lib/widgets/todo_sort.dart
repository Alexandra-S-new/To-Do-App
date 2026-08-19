import 'package:flutter/material.dart';
import 'package:my_todo_app/models/todo_view_enum.dart';

class TodoSortMenu extends StatelessWidget {
  const TodoSortMenu({
    super.key,
    required this.sortType,
    required this.onSelected,
  });

  final SortType sortType;
  final ValueChanged<SortType> onSelected;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: PopupMenuButton<SortType>(
        icon: Icon(Icons.sort),
        tooltip: "Sortieren nach",
        onSelected: (onSelected),
        itemBuilder: (context) => [
          PopupMenuItem(
            value: SortType.title,
            child: Row(
              children: [
                Expanded(child: Text("Titel")),
                if (sortType == SortType.title)
                  Icon(
                    Icons.check,
                    color: Theme.of(context).colorScheme.primary,
                  ),
              ],
            ),
          ),
          PopupMenuItem(
            value: SortType.priority,
            child: Row(
              children: [
                Expanded(child: Text("Priorität")),
                if (sortType == SortType.priority)
                  Icon(
                    Icons.check,
                    color: Theme.of(context).colorScheme.primary,
                  ),
              ],
            ),
          ),
          PopupMenuItem(
            value: SortType.dueDate,
            child: Row(
              children: [
                Expanded(child: Text("Fälligkeitsdatum")),
                if (sortType == SortType.dueDate)
                  Icon(
                    Icons.check,
                    color: Theme.of(context).colorScheme.primary,
                  ),
              ],
            ),
          ),
          PopupMenuItem(
            value: SortType.createdDate,
            child: Row(
              children: [
                Expanded(child: Text("Erstellungsdatum")),
                if (sortType == SortType.createdDate)
                  Icon(
                    Icons.check,
                    color: Theme.of(context).colorScheme.primary,
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
