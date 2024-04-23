class TodoModel {
  int? id;
  String? title, desc, createdAt, updatedAt;

  TodoModel({
    this.id,
    this.title,
    this.desc,
    this.createdAt,
    this.updatedAt,
  });

  factory TodoModel.fromJson(Map<String, dynamic> json) {
    return TodoModel(
      id: json['id'],
      title: json['title'],
      desc: json['desc'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }
}
