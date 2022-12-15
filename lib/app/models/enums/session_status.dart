enum SessionStatus {
  scheduled,
  done,
  cancelled,
  abandoned,
}

getSessionStatusFromString(String status) {
  switch (status) {
    case 'SCHEDULED':
      return SessionStatus.scheduled;

    case 'DONE':
      return SessionStatus.done;

    case 'CANCELLED':
      return SessionStatus.cancelled;

    case 'ABANDONED':
      return SessionStatus.abandoned;

    default:
      return SessionStatus.scheduled;
  }
}

sessionStatusToString(SessionStatus? status) {
  switch (status) {
    case SessionStatus.scheduled:
      return 'SCHEDULED';

    case SessionStatus.done:
      return 'DONE';

    case SessionStatus.cancelled:
      return 'CANCELLED';

    case SessionStatus.abandoned:
      return 'ABANDONED';

    default:
      return 'SCHEDULED';
  }
}
