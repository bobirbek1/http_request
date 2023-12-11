




import 'package:freezed_annotation/freezed_annotation.dart';


part 'album_model.freezed.dart';
part 'album_model.g.dart';

@freezed
class AlbumModel with _$AlbumModel {
  factory AlbumModel(
    int? id,
    int? userId,
    String? title,
  ) = _Album;

  factory AlbumModel.fromJson(Map<String, dynamic> data) =>
      _$AlbumModelFromJson(data);
}






