class Functions {
  static T? findFirst<T>(List<T> list, bool Function(T) condition) {
    for (T item in list) {
      if (condition(item)) {
        return item;
      }
    }
    return null;
  }
}
