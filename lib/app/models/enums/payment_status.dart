enum PaymentStatus {
  initiated,
  success,
  failed,
}

String paymentStatusToString(PaymentStatus payment) {
  switch (payment) {
    case PaymentStatus.initiated:
      return 'INITIATED';

    case PaymentStatus.success:
      return 'SUCCESS';

    case PaymentStatus.failed:
      return 'FAILED';

    default:
      return 'INITIATED';
  }
}

PaymentStatus getPaymentStatusFromString(String str) {
  switch (str) {
    case 'INITIATED':
      return PaymentStatus.initiated;

    case 'SUCCESS':
      return PaymentStatus.success;

    case 'FAILED':
      return PaymentStatus.failed;

    default:
      return PaymentStatus.initiated;
  }
}
