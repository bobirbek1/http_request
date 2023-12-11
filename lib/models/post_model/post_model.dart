


import 'package:freezed_annotation/freezed_annotation.dart';


part 'post_model.freezed.dart';
part 'post_model.g.dart';

@freezed
class PostModel with _$PostModel {
  factory PostModel(
    int? id,
    int? userId,
    String? title,
    String? body,
  ) = _Post;

  factory PostModel.fromJson(Map<String, dynamic> data) =>
      _$PostModelFromJson(data);
}
