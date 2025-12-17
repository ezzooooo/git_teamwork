class TodoEntity {
  final String id;
  final String title;

  TodoEntity({required this.id, required this.title});

  TodoEntity copyWith({String? id, String? title}) {
    return TodoEntity(id: id ?? this.id, title: title ?? this.title);
  }
}
