





import 'package:freezed_annotation/freezed_annotation.dart';


part 'photo_model.freezed.dart';
part 'photo_model.g.dart';

@freezed
class PhotoModel with _$PhotoModel {
  factory PhotoModel(
    int? id,
    int? albumId,
    String? title,
    String? url,
    String? thumbnailUrl,
  ) = _Photo;

  factory PhotoModel.fromJson(Map<String, dynamic> data) =>
      _$PhotoModelFromJson(data);
}
