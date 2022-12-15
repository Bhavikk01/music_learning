enum HomeworkStatus {
  assigned,
  inReview,
  inProgress,
  passed,
  failed,
}

String homeworkStatusToString(HomeworkStatus homework) {
  switch (homework) {
    case HomeworkStatus.assigned:
      return 'ASSIGNED';

    case HomeworkStatus.inReview:
      return 'IN_REVIEW';

    case HomeworkStatus.inProgress:
      return 'IN_PROGRESS';

    case HomeworkStatus.passed:
      return 'PASSED';

    case HomeworkStatus.failed:
      return 'FAILED';

    default:
      return 'ASSIGNED';
  }
}

HomeworkStatus stringToHomeworkStatus(String homework) {
  switch (homework) {
    case 'ASSIGNED':
      return HomeworkStatus.assigned;

    case 'IN_REVIEW':
      return HomeworkStatus.inReview;

    case 'IN_PROGRESS':
      return HomeworkStatus.inProgress;

    case 'PASSED':
      return HomeworkStatus.passed;

    case 'FAILED':
      return HomeworkStatus.failed;

    default:
      return HomeworkStatus.assigned;
  }
}
