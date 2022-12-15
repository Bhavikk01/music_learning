enum CourseStatus {
  paymentPending,
  active,
  completed,
  abandoned,
}

CourseStatus getCourseStatusFromString(String course) {
  switch (course) {
    case 'PAYMENT_PENDING':
      return CourseStatus.paymentPending;

    case 'ACTIVE':
      return CourseStatus.active;

    case 'COMPLETED':
      return CourseStatus.completed;

    case 'ABANDONED':
      return CourseStatus.abandoned;

    default:
      return CourseStatus.paymentPending;
  }
}

String courseStatusToString(CourseStatus? course) {
  switch (course) {
    case CourseStatus.paymentPending:
      return 'PAYMENT_PENDING';

    case CourseStatus.completed:
      return 'COMPLETED';

    case CourseStatus.active:
      return 'ACTIVE';

    case CourseStatus.abandoned:
      return 'ABANDONED';

    default:
      return 'PAYMENT_PENDING';
  }
}
