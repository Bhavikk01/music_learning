enum PricingPlan {
  subscription4,
  alaCarte4,
  alaCarte8,
}

String pricingPlanToString(PricingPlan? plan) {
  switch (plan) {
    case PricingPlan.alaCarte4:
      return 'ALA_CARTE_4';

    case PricingPlan.alaCarte8:
      return 'ALA_CARTE_8';

    case PricingPlan.subscription4:
      return 'SUBSCRIPTION_4';

    default:
      return 'SUBSCRIPTION_4';
  }
}

PricingPlan getPricingPlanFromString(String? plan) {
  switch (plan) {
    case 'ALA_CARTE_4':
      return PricingPlan.alaCarte4;

    case 'ALA_CARTE_8':
      return PricingPlan.alaCarte8;

    case 'SUBSCRIPTION_4':
      return PricingPlan.subscription4;

    default:
      return PricingPlan.subscription4;
  }
}
