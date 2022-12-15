enum PaymentMethod {
  cash,
  razorpay,
}

String paymentMethodToString(PaymentMethod payment) {
  switch (payment) {
    case PaymentMethod.cash:
      return 'CASH';

    case PaymentMethod.razorpay:
      return 'RAZORPAY';

    default:
      return 'RAZORPAY';
  }
}

PaymentMethod getPaymentMethodFromString(String str) {
  switch (str) {
    case 'CASH':
      return PaymentMethod.cash;

    case 'RAZORPAY':
      return PaymentMethod.razorpay;

    default:
      return PaymentMethod.razorpay;
  }
}
