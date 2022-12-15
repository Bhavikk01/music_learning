enum Hobby {
  music,
  dance,
}

extension GetValue on Hobby {
  String get value => toString().split('.').last.toUpperCase();
}
