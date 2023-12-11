import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:http_request/base_state.dart';
import 'package:http_request/models/post_model/post_model.dart';

class PostViewModel extends ChangeNotifier {
  final Dio _client;

  PostViewModel(this._client);


PostState _state = PostState(state: BaseState.initial);
  PostState get state => _state;

  void fetchPosts(int? userId) async {
    if (userId == null) return;
    try {
      _state = PostState(state: BaseState.loading);
      notifyListeners();
      final data =
          await _client.get("posts", queryParameters: {"userId": userId});
      final posts =
          data.data.map<PostModel>((user) => PostModel.fromJson(user)).toList();
      _state = PostState(state: BaseState.loaded, posts: posts);
    } catch (e) {
      print("exception occured while fetching posts from server: $e");
      _state = PostState(
          state: BaseState.error,
          error: "exception occured while fetching posts from server");
    } finally {
      notifyListeners();
    }
  }

}

class PostState {
  final BaseState state;
  final List<PostModel>? posts;
  final String? error;
  PostState({required this.state, this.posts, this.error});
}
