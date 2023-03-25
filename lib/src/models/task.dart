class task {
  String id;
  String name;
  int progress;

  task({required this.id, required this.name, required this.progress});

  factory task.fromMap(Map<String, dynamic> obj) =>
      task(id: obj['id'], name: obj['name'], progress: obj['progress']);
}
