

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:http_request/base_state.dart';
import 'package:http_request/models/comment_model/comment_model.dart';

class CommentViewModel extends ChangeNotifier {
  final Dio _client;

  CommentViewModel(this._client);


CommentState _state = CommentState(state: BaseState.initial);
  CommentState get state => _state;

  void fetchComments(int? postId) async {
    if (postId == null) return;
    try {
      _state = CommentState(state: BaseState.loading);
      notifyListeners();
      final data =
          await _client.get("comments", queryParameters: {"postId": postId});
      final comments =
          data.data.map<CommentModel>((user) => CommentModel.fromJson(user)).toList();
      _state = CommentState(state: BaseState.loaded, comments: comments);
    } catch (e) {
      print("exception occured while fetching comments from server: $e");
      _state = CommentState(
          state: BaseState.error,
          error: "exception occured while fetching comments from server");
    } finally {
      notifyListeners();
    }
  }

}

class CommentState {
  final BaseState state;
  final List<CommentModel>? comments;
  final String? error;
  CommentState({required this.state, this.comments, this.error});
}
