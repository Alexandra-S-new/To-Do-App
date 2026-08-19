enum Priority { low, medium, high }

class ToDo {
  int id;
  String title;
  String? description;
  bool isCompleted;

  DateTime createdAt;
  DateTime? dueDate;
  Priority priority;
  ToDo({
    required this.id,
    required this.title,
    this.description,
    this.isCompleted = false,
    this.priority = Priority.medium,
    DateTime? createdAt,
    this.dueDate,
  }) : createdAt = createdAt ?? DateTime.now();

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'isCompleted': isCompleted,
      'createdAt': createdAt.toIso8601String(),
      'dueDate': dueDate?.toIso8601String(),
      'priority': priority.name,
    };
  }

  factory ToDo.fromMap(Map<String, dynamic> map) {
    return ToDo(
      id: map['id'],
      title: map['title'],
      description: map['description'],
      isCompleted: map['isCompleted'],
      createdAt: DateTime.parse(map['createdAt']),
      dueDate: map['dueDate'] == null ? null : DateTime.parse(map['dueDate']),
      priority: Priority.values.byName(map['priority']),
    );
  }
}
