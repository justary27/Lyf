// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'diary_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DiaryEntry _$DiaryEntryFromJson(Map<String, dynamic> json) => DiaryEntry(
      json['_id'] as String?,
      json['_title'] as String,
      json['_description'] as String,
      json['_is_private'] as bool,
      DateTime.parse(json['_createdAt'] as String),
      json['_audioLink'] as String?,
      (json['_imageLinks'] as List<dynamic>?)?.map((e) => e as String).toList(),
    );

Map<String, dynamic> _$DiaryEntryToJson(DiaryEntry instance) =>
    <String, dynamic>{
      '_id': instance.id,
      '_title': instance.title,
      '_description': instance.description,
      '_is_private': instance.isPrivate,
      '_createdAt': instance.createdAt.toIso8601String(),
      '_audioLink': instance.audioLink,
      '_imageLinks': instance.imageLinks,
    };
