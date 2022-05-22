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
