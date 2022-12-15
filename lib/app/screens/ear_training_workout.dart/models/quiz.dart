class Quiz {
  final List<QuizQuestion> questionsAndAnswers;
  final int noOfQuestions;

  const Quiz(
    this.questionsAndAnswers,
  ) : noOfQuestions = questionsAndAnswers.length;

  @override
  String toString() =>
      'Quiz(questionsAndAnswers: $questionsAndAnswers, noOfQuestions: $noOfQuestions)';
}

class QuizQuestion {
  final String question;
  final String answer;
  final String note1;
  final String note2;

  QuizQuestion(this.question, this.answer, this.note1, this.note2);
}
