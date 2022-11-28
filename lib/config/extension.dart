extension Value on Enum {
  String get value => name;
}

extension Search<T extends Enum> on List<T> {
  T? find(int? value) {
    return findByIndex(value);
  }

  T? findByValue(String? value) {
    return findByName(value);
  }

  T? findByName(String? name) {
    if (name == null) return null;
    return firstWhere((element) => element.name == name);
  }

  T? findByIndex(int? index) {
    if (index == null) return null;
    return firstWhere((element) => element.index == index);
  }
}
