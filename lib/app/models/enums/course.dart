enum Course {
  vocals,
  guitar,
  piano,
}

extension GetValue on Course {
  String get value => toString().split('.').last.toUpperCase();
}
