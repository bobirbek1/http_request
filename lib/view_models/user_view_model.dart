import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:http_request/base_state.dart';
import 'package:http_request/models/user_model/user_model.dart';

class UserViewModel extends ChangeNotifier {
  final Dio _client;

  UserViewModel(this._client) {
    getUsers();
  }

  UserState _state = UserState(state: BaseState.initial);
  UserState get state => _state;

  void getUsers() async {
    try {
      _state = UserState(state: BaseState.loading);
      notifyListeners();
      final data = await _client.get("users");
      final users =
          data.data.map<UserModel>((user) => UserModel.fromJson(user)).toList();
      _state = UserState(state: BaseState.loaded, users: users);
    } catch (e) {
      print("exception occured while fetching users from server: $e");
      _state = UserState(
          state: BaseState.error,
          error: "exception occured while fetching users from server");
    } finally {
      notifyListeners();
    }
  }
}

class UserState {
  final BaseState state;
  final List<UserModel>? users;
  final String? error;

  UserState({
    required this.state,
    this.users,
    this.error,
  });
}
