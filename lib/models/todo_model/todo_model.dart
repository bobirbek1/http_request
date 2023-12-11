
import 'package:freezed_annotation/freezed_annotation.dart';


part 'todo_model.freezed.dart';
part 'todo_model.g.dart';

@freezed
class TodoModel with _$TodoModel {
  factory TodoModel(
    int? id,
    int? userId,
    String? title,
    bool? completed,
  ) = _Todo;

  factory TodoModel.fromJson(Map<String, dynamic> data) =>
      _$TodoModelFromJson(data);
}
