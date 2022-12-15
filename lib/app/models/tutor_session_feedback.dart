import 'dart:convert';

import 'package:equatable/equatable.dart';

class TutorSessionFeedback extends Equatable {
  final List<String>? keywords;
  final String? remarks;
  final String? sessionStatus;
  final Map<String, String>? tags;

  const TutorSessionFeedback({
    this.keywords,
    this.remarks,
    this.sessionStatus,
    this.tags,
  });

  Map<String, dynamic> toMap() {
    return {
      'keywords': keywords,
      'remarks': remarks,
      'sessionStatus': sessionStatus,
      'tags': tags,
    };
  }

  factory TutorSessionFeedback.fromMap(Map<String, dynamic> map) {
    return TutorSessionFeedback(
      keywords: List<String>.from(map['keywords']),
      remarks: map['remarks'],
      sessionStatus: map['sessionStatus'],
      tags: map['tags'],
    );
  }

  String toJson() => json.encode(toMap());

  factory TutorSessionFeedback.fromJson(String source) =>
      TutorSessionFeedback.fromMap(json.decode(source));

  @override
  List<Object?> get props => [
        keywords,
        remarks,
        sessionStatus,
        tags,
      ];
}
