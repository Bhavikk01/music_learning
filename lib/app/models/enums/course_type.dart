enum CourseType {
  individual,
  batch
}

getCourseTypeFromString(String status) {
  switch (status) {
    case 'INDIVIDUAL':
      return CourseType.individual;

    case 'BATCH':
      return CourseType.batch;

    default:
      return CourseType.individual;
  }
}

courseTypetoString(CourseType? status) {
  switch (status) {
    case CourseType.individual:
      return 'INDIVIDUAL';

    case CourseType.batch:
      return 'BATCH';

    default:
      return 'INDIVIDUAL';
  }
}
