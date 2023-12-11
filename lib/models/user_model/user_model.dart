import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_model.freezed.dart';
part 'user_model.g.dart';

@freezed
class UserModel with _$UserModel {
  factory UserModel(
    int? id,
    String? name,
    String? username,
    String? email,
    String? phone,
    String? website,
  ) = _User;

  factory UserModel.fromJson(Map<String, dynamic> data) => _$UserModelFromJson(data);
}
