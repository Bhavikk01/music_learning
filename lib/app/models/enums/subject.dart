enum Subject {
  guitar,
  piano,
  violin,
  vocal,
  tabla,
  flute,
  bass,
}

String subjectToString(Subject? sub) {
  switch (sub) {
    case Subject.guitar:
      return 'GUITAR';

    case Subject.piano:
      return 'PIANO';

    case Subject.violin:
      return 'VIOLIN';

    case Subject.vocal:
      return 'VOCAL';

    case Subject.tabla:
      return 'TABLA';

    case Subject.flute:
      return 'FLUTE';

    case Subject.bass:
      return 'BASS';

    default:
      return 'VOCAL';
  }
}

Subject getSubjectFromString(String? sub) {
  switch (sub) {
    case 'GUITAR':
      return Subject.guitar;

    case 'PIANO':
      return Subject.piano;

    case 'VIOLIN':
      return Subject.violin;

    case 'VOCAL':
      return Subject.vocal;

    case 'TABLA':
      return Subject.tabla;

    case 'FLUTE':
      return Subject.flute;

    case 'BASS':
      return Subject.bass;

    default:
      return Subject.vocal;
  }
}

List<Subject> getListOfSubjectFromString(str) {
  var subString = List<String>.from(str);
  var res = <Subject>[];
  for (var i in subString) {
    res.add(getSubjectFromString(i));
  }

  return res;
}

List<String> getListOfStringFromListOfSubjects(List<Subject> sub) {
  var res = <String>[];

  for (var i in sub) {
    res.add(subjectToString(i));
  }

  return res;
}
