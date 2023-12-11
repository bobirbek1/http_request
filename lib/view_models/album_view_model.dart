import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:http_request/base_state.dart';
import 'package:http_request/models/album_model/album_model.dart';
import 'package:http_request/models/photo_model/photo_model.dart';

class AlbumViewModel extends ChangeNotifier {
  final Dio _client;

  AlbumViewModel(this._client);

  AlbumState _state = AlbumState(state: BaseState.initial);
  AlbumState get state => _state;
  PhotoState _photoState = PhotoState(state: BaseState.initial);
  PhotoState get photoState => _photoState;

  void fetchAlbums(int? userId) async {
    if (userId == null) return;
    try {
      _state = AlbumState(state: BaseState.loading);
      notifyListeners();
      final data =
          await _client.get("albums", queryParameters: {"userId": userId});
      final albums = data.data
          .map<AlbumModel>((user) => AlbumModel.fromJson(user))
          .toList();
      _state = AlbumState(state: BaseState.loaded, albums: albums);
    } catch (e) {
      print("exception occured while fetching albums from server: $e");
      _state = AlbumState(
          state: BaseState.error,
          error: "exception occured while fetching albums from server");
    } finally {
      notifyListeners();
    }
  }

  void fetchPhotosByAlbumId(int? id) async {
     if (id == null) return;
    try {
      _photoState = PhotoState(state: BaseState.loading);
      notifyListeners();
      final data =
          await _client.get("photos", queryParameters: {"albumId": id});
      final photos = data.data
          .map<PhotoModel>((user) => PhotoModel.fromJson(user))
          .toList();
      _photoState = PhotoState(state: BaseState.loaded, photos: photos);
    } catch (e) {
      print("exception occured while fetching photos from server: $e");
      _photoState = PhotoState(
          state: BaseState.error,
          error: "exception occured while fetching photos from server");
    } finally {
      notifyListeners();
    }
  }

}

class AlbumState {
  final BaseState state;
  final List<AlbumModel>? albums;
  final String? error;
  AlbumState({required this.state, this.albums, this.error});
}
class PhotoState {
  final BaseState state;
  final List<PhotoModel>? photos;
  final String? error;
  PhotoState({required this.state, this.photos, this.error});
}
