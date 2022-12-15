enum WorkoutType {
  pitchMatching,
  qnA,
  earTraining,
  customWorkoutSingleAudio,
  customVideoWorkout,
  mtQuiz,
  sc
}

String workoutTypeToString(WorkoutType? workout) {
  switch (workout) {
    case WorkoutType.pitchMatching:
      return 'PITCH_MATCHING_1';

    case WorkoutType.qnA:
      return 'Q_AND_A';

    case WorkoutType.earTraining:
      return 'EAR_TRAINING_1';

    case WorkoutType.customWorkoutSingleAudio:
      return 'CUSTOM_WORKOUT_SINGLE_AUDIO';

    case WorkoutType.customVideoWorkout:
      return 'CUSTOM_VIDEO_WORKOUT';

    case WorkoutType.mtQuiz:
      return 'MT_QUIZ_1';

    case WorkoutType.sc:
      return 'SC_1';

    default:
      return 'EAR_TRAINING_1';
  }
}

WorkoutType stringToWorkoutType(String workout) {
  switch (workout) {
    case 'PITCH_MATCHING_1':
      return WorkoutType.pitchMatching;

    case 'Q_AND_A':
      return WorkoutType.qnA;

    case 'EAR_TRAINING_1':
      return WorkoutType.earTraining;

    case 'CUSTOM_WORKOUT_SINGLE_AUDIO':
      return WorkoutType.customWorkoutSingleAudio;

    case 'CUSTOM_VIDEO_WORKOUT':
      return WorkoutType.customVideoWorkout;

    case 'MT_QUIZ_1':
      return WorkoutType.mtQuiz;

    case 'SC_1':
      return WorkoutType.sc;

    default:
      return WorkoutType.earTraining;
  }
}
