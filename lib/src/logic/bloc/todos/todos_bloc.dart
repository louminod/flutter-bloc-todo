import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bloc_todo_tuto/src/data/models/todo.dart';
import 'package:bloc_todo_tuto/src/data/repositories/firebase_todos_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'todos_event.dart';
part 'todos_state.dart';

class TodosBloc extends Bloc<TodosEvent, TodosState> {
  TodosBloc({required FirebaseTodosRepository todosRepository})
      : _todosRepository = todosRepository,
        super(TodosLoading()) {
    on<LoadTodos>(_onLoadTodos);
    on<AddTodo>(_onAddTodo);
    on<UpdateTodo>(_onUpdateTodo);
    on<DeleteTodo>(_onDeleteTodo);
    on<ToggleAll>(_onToggleAll);
    on<ClearCompleted>(_onClearCompleted);
    on<TodosUpdated>(_onTodosUpdated);
  }

  final TodosRepository _todosRepository;
  StreamSubscription? _todosSubscription;

  void _onLoadTodos(LoadTodos event, Emitter<TodosState> emit) {
    _todosSubscription?.cancel();
    _todosSubscription = _todosRepository.todos().listen((todos) {
      add(TodosUpdated(todos));
    });
  }

  void _onAddTodo(AddTodo event, Emitter<TodosState> emit) {
    _todosRepository.addNewTodo(event.todo);
  }

  void _onUpdateTodo(UpdateTodo event, Emitter<TodosState> emit) {
    _todosRepository.updateTodo(event.updatedTodo);
  }

  void _onDeleteTodo(DeleteTodo event, Emitter<TodosState> emit) {
    _todosRepository.deleteTodo(event.todo);
  }

  void _onToggleAll(ToggleAll event, Emitter<TodosState> emit) {
    final currentState = state;
    if (currentState is TodosLoaded) {
      final allComplete = currentState.todos.every((todo) => todo.complete);
      final List<Todo> updatedTodos = currentState.todos
          .map((todo) => todo.copyWith(complete: !allComplete))
          .toList();
      updatedTodos.forEach((updatedTodo) {
        _todosRepository.updateTodo(updatedTodo);
      });
    }
  }

  void _onClearCompleted(ClearCompleted event, Emitter<TodosState> emit) {
    final currentState = state;
    if (currentState is TodosLoaded) {
      final List<Todo> completedTodos =
      currentState.todos.where((todo) => todo.complete).toList();
      completedTodos.forEach((completedTodo) {
        _todosRepository.deleteTodo(completedTodo);
      });
    }
  }

  void _onTodosUpdated(TodosUpdated event, Emitter<TodosState> emit) {
    emit(TodosLoaded(event.todos));
  }

  @override
  Future<void> close() {
    _todosSubscription?.cancel();
    return super.close();
  }
}
