// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'comment_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$commentImpl _$$commentImplFromJson(Map<String, dynamic> json) =>
    _$commentImpl(
      json['id'] as int?,
      json['postId'] as int?,
      json['name'] as String?,
      json['email'] as String?,
      json['body'] as String?,
    );

Map<String, dynamic> _$$commentImplToJson(_$commentImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'postId': instance.postId,
      'name': instance.name,
      'email': instance.email,
      'body': instance.body,
    };
