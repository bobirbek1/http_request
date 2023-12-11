import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:http_request/base_state.dart';
import 'package:http_request/models/todo_model/todo_model.dart';

class TodoViewModel extends ChangeNotifier {
  final Dio _client;

  TodoViewModel(this._client);

  TodoState _state = TodoState(state: BaseState.initial);
  TodoState get state => _state;

  void fetchTodos(int? userId) async {
    if (userId == null) return;
    try {
      _state = TodoState(state: BaseState.loading);
      notifyListeners();
      final data =
          await _client.get("todos", queryParameters: {"userId": userId});
      final todos =
          data.data.map<TodoModel>((user) => TodoModel.fromJson(user)).toList();
      _state = TodoState(state: BaseState.loaded, todos: todos);
    } catch (e) {
      print("exception occured while fetching todos from server: $e");
      _state = TodoState(
          state: BaseState.error,
          error: "exception occured while fetching todos from server");
    } finally {
      notifyListeners();
    }
  }

  Future<bool> updateTodoComplete(int? todoId, bool value) async {
    if (todoId == null) {
      return false;
    }
    try {
      await _client.patch("todos/$todoId", data: {"completed": value});
      return true;
    } catch (e) {
      print("exception occured while updating todo: $e");
    }

    return false;
  }
}

class TodoState {
  final BaseState state;
  final List<TodoModel>? todos;
  final String? error;
  TodoState({required this.state, this.todos, this.error});
}
