import 'package:bloc_todo_tuto/src/data/models/todo.dart';

abstract class TodosRepositoryInterface {
  Stream<List<Todo>> todos();

  Future<void> addNewTodo(Todo todo);

  Future<void> deleteTodo(Todo todo);

  Future<void> updateTodo(Todo todo);
}
