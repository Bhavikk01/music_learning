enum PaymentUseCase {
  buyCourse,
  renewCourse,
  buyInstrument,
}

String paymentUseCaseToString(PaymentUseCase paymentUseCase) {
  switch (paymentUseCase) {
    case PaymentUseCase.buyCourse:
      return 'BUY_COURSE';

    case PaymentUseCase.renewCourse:
      return 'RENEW_COURSE';

    case PaymentUseCase.buyInstrument:
      return 'BUY_INSTRUMENT';

    default:
      return 'BUY_COURSE';
  }
}

PaymentUseCase getPaymentUseCaseFromString(String str) {
  switch (str) {
    case 'BUY_COURSE':
      return PaymentUseCase.buyCourse;

    case 'RENEW_COURSE':
      return PaymentUseCase.renewCourse;

    case 'BUY_INSTRUMENT':
      return PaymentUseCase.buyInstrument;

    default:
      return PaymentUseCase.buyCourse;
  }
}
