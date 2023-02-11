import 'package:flutter/foundation.dart';

enum PaymentInterval {

  none,
  weekly,
  halfMonthly,
  monthly,
  threeMonths,
  halfYearly,
  annual,
  biAnnual
}

extension PaymentIntervalValue on PaymentInterval {
  String get name => describeEnum(this);
  String get label {
    switch (this) {
      case PaymentInterval.none:
        return 'None';
      case PaymentInterval.weekly:
        return 'Seven Days';
      case PaymentInterval.halfMonthly:
        return 'Fifteen Days';
      case PaymentInterval.monthly:
        return 'One Month';
      case PaymentInterval.threeMonths:
        return 'Three Months';
      case PaymentInterval.halfYearly:
        return 'Six Months';
      case PaymentInterval.annual:
        return 'One Year';
      case PaymentInterval.biAnnual:
        return 'Two Year';
      default:
        return 'SelectedScheme Title is null';
    }
  }
}
