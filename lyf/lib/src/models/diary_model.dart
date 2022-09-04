import 'package:json_annotation/json_annotation.dart';
import '../interface/json_object.dart';

part 'diary_model.g.dart';

/// ## Diary
/// Defining class of an entry in diary of a [LyfUser].
@JsonSerializable()
class DiaryEntry extends JsonObject {
  /// Unique Id of a [DiaryEntry]
  @JsonKey(name: "_id")
  final String? id;

  /// Title of a [DiaryEntry]
  @JsonKey(name: "_title")
  final String title;

  /// Description of a [DiaryEntry]
  @JsonKey(name: "_description")
  final String description;

  /// Time when the [DiaryEntry] was created
  @JsonKey(name: "_createdAt")
  final DateTime createdAt;

  /// Url of an audioFile attached with the [DiaryEntry]
  @JsonKey(name: "_audioLink")
  String? audioLink;

  /// A list of urls attached with the [DiaryEntry]
  @JsonKey(name: "_imageLinks")
  List<String>? imageLinks;

  // Constructor

  DiaryEntry(
    this.id,
    this.title,
    this.description,
    this.createdAt,
    this.audioLink,
    this.imageLinks,
  );

  // Class properties

  String? get entryId {
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

  factory DiaryEntry.fromJson(Map<String, dynamic> json) =>
      _$DiaryEntryFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$DiaryEntryToJson(this);

  // static Stream<List<DiaryEntry?>?> getEntriesStream(){
  // }
}
