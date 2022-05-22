class TodoEndpoints {
  TodoEndpoints._();

  static const String todo = "todo";

  static List<String> createTodo({
    required String userId,
  }) {
    return [userId, todo, "create", ""];
  }

  static List<String> getAllTodos({
    required String userId,
  }) {
    return [userId, todo, ""];
  }

  static List<String> getTodo({
    required String userId,
    required todoId,
  }) {
    return [userId, todo, todoId, ""];
  }

  static List<String> updateTodo({
    required String userId,
    required String todoId,
  }) {
    return [userId, todo, todoId, "update", ""];
  }

  static List<String> deleteTodo({
    required String userId,
    required String todoId,
  }) {
    return [userId, todo, todoId, "delete", ""];
  }
}
