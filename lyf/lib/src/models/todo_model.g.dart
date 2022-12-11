// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'todo_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Todo _$TodoFromJson(Map<String, dynamic> json) => Todo(
      json['_id'] as String?,
      json['_title'] as String,
      json['_description'] as String,
      DateTime.parse(json['_createdAt'] as String),
      json['_isCompleted'] as bool,
      json['_isReminderSet'] as bool,
      json['_reminderAt'] == null
          ? null
          : DateTime.parse(json['_reminderAt'] as String),
    );

Map<String, dynamic> _$TodoToJson(Todo instance) => <String, dynamic>{
      '_id': instance.id,
      '_title': instance.title,
      '_description': instance.description,
      '_createdAt': instance.createdAt.toIso8601String(),
      '_isCompleted': instance.isCompleted,
      '_isReminderSet': instance.isReminderSet,
      '_reminderAt': instance.reminderAt?.toIso8601String(),
    };
