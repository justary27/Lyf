import 'package:lyf/src/models/user_model.dart';

class Todo {
  final String id;
  final String title;
  final String description;
  final DateTime createdAt;
  final bool _isReminderSet;
  final DateTime? _reminderAt;

  Todo(this.id, this.title, this.description, this.createdAt,
      this._isReminderSet, this._reminderAt);
  String get entryId {
    return id;
  }

  String get todoTitle {
    return title;
  }

  String get todoDescription {
    return description;
  }

  DateTime get todoCreatedAt {
    return createdAt;
  }

  bool get isReminderSet {
    return _isReminderSet;
  }

  DateTime? get reminderAt {
    return _reminderAt;
  }

  factory Todo.fromJson(Map<String, dynamic> json) {
    return Todo(
        json['id'],
        json['title'],
        json['description'],
        DateTime.parse(json['createdAt']),
        json['isReminderSet'],
        (json['reminderAt'] != "None")
            ? DateTime.parse(json['reminderAt'])
            : null);
  }
  // Map<String, dynamic> create() => {
  //       '_userId': user,
  //       '_title': title,
  //       '_description': description,
  //       '_created_on': createdAt.toIso8601String(),
  //       '_is_reminder_Set': isReminderSet,
  //       '_reminder_at': reminderAt.toIso8601String(),
  //     };
  // Map<String, dynamic> update() => {
  //       '_title': title,
  //       '_description': description,
  //       '_created_on': createdAt.toIso8601String(),
  //       '_is_reminder_Set': isReminderSet,
  //       '_reminder_at': reminderAt.toIso8601String(),
  //     };
}
