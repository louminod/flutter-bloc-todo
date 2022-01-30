import 'package:equatable/equatable.dart';

class Todo extends Equatable {
  final bool complete;
  final String id;
  final String note;
  final String task;

  const Todo({required this.task, required this.id, required this.note, required this.complete});

  Map<String, Object> toJson() {
    return {
      "complete": complete,
      "task": task,
      "note": note,
      "id": id,
    };
  }

  static Todo fromJson(Map<String, dynamic> json) {
    return Todo(
      task: json["task"] as String,
      id: json["id"] as String,
      note: json["note"] as String,
      complete: json["complete"] as bool,
    );
  }

  @override
  List<Object?> get props => [id];

  @override
  String toString() {
    return 'Todo { complete: $complete, task: $task, note: $note, id: $id }';
  }
}
