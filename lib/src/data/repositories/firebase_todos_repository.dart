import 'package:bloc_todo_tuto/src/data/models/todo.dart';
import 'package:bloc_todo_tuto/src/data/repositories/interfaces/todos_repository_interface.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseTodosRepository implements TodosRepositoryInterface {
  final todoCollection = FirebaseFirestore.instance.collection('todos');

  @override
  Future<void> addNewTodo(Todo todo) {
    return todoCollection.add(todo.toJson());
  }

  @override
  Future<void> deleteTodo(Todo todo) async {
    return todoCollection.doc(todo.id).delete();
  }

  @override
  Stream<List<Todo>> todos() => todoCollection.snapshots().map((snapshot) => snapshot.docs.map((doc) => Todo.fromJson(doc.data())).toList());

  @override
  Future<void> updateTodo(Todo todo) {
    return todoCollection.doc(todo.id).update(todo.toJson());
  }
}
