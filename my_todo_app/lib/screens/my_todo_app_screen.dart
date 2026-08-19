import 'package:flutter/material.dart';
import 'package:my_todo_app/models/todo.dart';
import 'package:my_todo_app/models/todo_view_enum.dart';
import 'package:my_todo_app/providers/theme_notifier.dart';
import 'package:my_todo_app/screens/app_theme.dart';
import 'package:my_todo_app/services/preferences_service.dart';
import 'package:my_todo_app/widgets/remove_todo_dialog.dart';
import 'package:my_todo_app/widgets/show_edit_todo_dialog.dart';
import 'package:my_todo_app/widgets/todo_filter.dart';
import 'package:my_todo_app/widgets/todo_list_card_item.dart';
import 'package:my_todo_app/widgets/todo_sort.dart';
import 'package:provider/provider.dart';

class MyTodoApp extends StatefulWidget {
  const MyTodoApp({super.key});

  @override
  State<MyTodoApp> createState() => _MyTodoAppState();
}

class _MyTodoAppState extends State<MyTodoApp> {
  final PreferencesTodo preferencesTodo = PreferencesTodo();

  final List<ToDo> todos = [];
  var _filter = ToDoFilter.all;
  bool sortByTitle = false;
  SortType sortType = SortType.none;

  String priorityLabel(Priority priority) {
    switch (priority) {
      case Priority.low:
        return '🟢 Niedrig';
      case Priority.medium:
        return '🟡 Mittel';
      case Priority.high:
        return '🔴 Hoch';
    }
  }

  Color priorityColor(Priority priority) {
    switch (priority) {
      case Priority.low:
        return AppTheme.successColor;
      case Priority.medium:
        return AppTheme.warningColor;
      case Priority.high:
        return AppTheme.errorColor;
    }
  }

  @override
  void initState() {
    super.initState();
    loadTodos();
  }

  Future<void> saveTodos() async {
    await preferencesTodo.saveAll(todos);
  }

  Future<void> loadTodos() async {
    final savedTodos = await preferencesTodo.loadAll();

    if (!mounted) return;

    setState(() {
      todos.clear();
      todos.addAll(savedTodos);
    });
  }

  Future<void> addToDo(
    String title,
    String? description,
    Priority priority,
    DateTime? selectedDate,
  ) async {
    final id = await preferencesTodo.getNextId();
    setState(() {
      todos.add(
        ToDo(
          title: title,
          description: description,
          priority: priority,
          dueDate: selectedDate,
          id: id,
        ),
      );
    });
    await saveTodos();
  }

  Future<void> updateToDo(
    ToDo todo,
    String title,
    String? description,
    Priority priority,
    DateTime? selectedDate,
  ) async {
    setState(() {
      todo.title = title;
      todo.description = description;
      todo.priority = priority;
      todo.dueDate = selectedDate;
    });
    await saveTodos();
  }

  Future<void> removeToDo(ToDo todo) async {
    if (!await showRemoveDialog(context, todo) || !mounted) return;
    setState(() => todos.remove(todo));
    await saveTodos();
  }

  List<ToDo> get displayedTodos {
    final sortedTodos = List<ToDo>.from(
      todos.where((todo) {
        switch (_filter) {
          case ToDoFilter.all:
            return true;
          case ToDoFilter.open:
            return !todo.isCompleted;
          case ToDoFilter.completed:
            return todo.isCompleted;
          case ToDoFilter.overTime:
            final today = DateUtils.dateOnly(DateTime.now());

            return todo.dueDate != null &&
                !todo.isCompleted &&
                DateUtils.dateOnly(todo.dueDate!).isBefore(today);
        }
      }),
    );
    switch (sortType) {
      case SortType.title:
        sortedTodos.sort(
          (a, b) => a.title.toLowerCase().compareTo(b.title.toLowerCase()),
        );
        break;
      case SortType.priority:
        sortedTodos.sort(
          (a, b) => a.priority.index.compareTo(b.priority.index),
        );
        break;
      case SortType.dueDate:
        sortedTodos.sort((a, b) {
          final dateA = a.dueDate ?? DateTime(9999);
          final dateB = b.dueDate ?? DateTime(9999);

          return dateA.compareTo(dateB);
        });
        break;
      case SortType.createdDate:
        sortedTodos.sort((a, b) {
          return a.createdAt.compareTo(b.createdAt);
        });
        break;
      case SortType.none:
        break;
    }

    return sortedTodos;
  }

  Future<void> openEditor([ToDo? todo]) => showToDoDialog(
    context: context,
    todo: todo,
    onSave: (title, description, priority, dueDate) => todo == null
        ? addToDo(title, description, priority, dueDate)
        : updateToDo(todo, title, description, priority, dueDate),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Meine ToDo App"),
        actions: [
          IconButton(
            onPressed: () {
              context.read<ThemeNotifier>().setThemeMode();
            },
            icon: Icon(
              context.watch<ThemeNotifier>().themeMode == ThemeMode.dark
                  ? Icons.light_mode
                  : Icons.dark_mode,
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          openEditor();
        },
        child: const Icon(Icons.add),
      ),
      body: todos.isEmpty
          ? const Center(child: Text('Keine Aufgaben vorhanden'))
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  //Filter
                  TodoFilterBar(
                    selectedFilter: _filter,
                    onChanged: (filter) {
                      setState(() {
                        _filter = filter;
                      });
                    },
                  ),

                  TodoSortMenu(
                    sortType: sortType,
                    onSelected: (value) {
                      setState(() {
                        sortType = sortType == value ? SortType.none : value;
                      });
                    },
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: displayedTodos.length,
                      itemBuilder: (context, index) {
                        final todo = displayedTodos[index];

                        return Dismissible(
                          key: ValueKey(todo.id),
                          direction: DismissDirection.endToStart,
                          background: Container(),
                          secondaryBackground: Container(
                            color: Theme.of(context).colorScheme.error,
                            alignment: Alignment.centerRight,
                            padding: const EdgeInsets.only(right: 20),
                            child: Icon(
                              Icons.delete,
                              color: Theme.of(context).colorScheme.onError,
                              size: 32,
                            ),
                          ),
                          confirmDismiss: (_) async {
                            return await showRemoveDialog(context, todo);
                          },
                          onDismissed: (_) async {
                            setState(() {
                              todos.remove(todo);
                            });
                            await saveTodos();
                          },
                          child: TodoListCardItem(
                            todo: todo,
                            priorityLabel: priorityLabel(todo.priority),
                            priorityColor: priorityColor(todo.priority),
                            onChanged: (value) async {
                              setState(() => todo.isCompleted = value ?? false);
                              await saveTodos();
                            },
                            onEdit: () => openEditor(todo),
                            onDelete: () => removeToDo(todo),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),

      // Center(child: Text('Keine Aufgaben vorhanden')),
    );
  }
}
