class DiaryEntry {
  final String id;
  final String title;
  final String description;
  final DateTime createdAt;
  // final String createdAt;
  DiaryEntry(
    this.id,
    this.title,
    this.description,
    this.createdAt,
  );
  String get entryId {
    return id;
  }

  String get entryTitle {
    return title;
  }

  String get entryDescription {
    return description;
  }

  DateTime get entryCreatedAt {
    return createdAt;
  }

  static fromJson(Map<String, dynamic> json) {
    return DiaryEntry(
      json['_id'],
      json['_title'],
      json['_description'],
      DateTime.parse(json['_createdAt']),
    );
  }

  // Map<String, dynamic> create() => {
  //       '_userId': user,
  //       '_title': title,
  //       '_description': description,
  //       '_created_on': createdAt.toIso8601String(),
  //     };
  Map<String, dynamic> update() => {
        '_title': title,
        '_description': description,
        // '_created_on': createdAt.toIso8601String(),
      };
}

DateTime x = DateTime(2000);
