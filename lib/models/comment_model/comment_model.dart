








import 'package:freezed_annotation/freezed_annotation.dart';


part 'comment_model.freezed.dart';
part 'comment_model.g.dart';

@freezed
class CommentModel with _$CommentModel {
  factory CommentModel(
    int? id,
    int? postId,
    String? name,
    String? email,
    String? body,
  ) = _comment;

  factory CommentModel.fromJson(Map<String, dynamic> data) =>
      _$CommentModelFromJson(data);
}
