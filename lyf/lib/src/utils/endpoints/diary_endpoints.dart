class DiaryEndpoints {
  DiaryEndpoints._();
  static const String entry = "diary";

  static List<String> createEntry({
    required String userId,
  }) {
    return [userId, entry, "create", ""];
  }

  static List<String> getAllEntries({
    required String userId,
  }) {
    return [userId, entry, ""];
  }

  static List<String> getDiaryPdf({
    required String userId,
  }) {
    return [userId, entry, "pdf"];
  }

  static List<String> getDiaryTxt({
    required String userId,
  }) {
    return [userId, entry, "txt"];
  }

  static List<String> getEntry({
    required String userId,
    required entryId,
  }) {
    return [userId, entry, entryId, ""];
  }

  static List<String> getEntryPdf({
    required String userId,
    required entryId,
  }) {
    return [userId, entry, entryId, "$entryId.pdf"];
  }

  static List<String> getEntryTxt({
    required String userId,
    required entryId,
  }) {
    return [userId, entry, entryId, "$entryId.txt"];
  }

  static List<String> updateEntry({
    required String userId,
    required String entryId,
  }) {
    return [userId, entry, entryId, "update", ""];
  }

  static List<String> deleteEntry({
    required String userId,
    required String entryId,
  }) {
    return [userId, entry, entryId, "delete", ""];
  }
}
