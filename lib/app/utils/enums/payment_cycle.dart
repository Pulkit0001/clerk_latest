import 'package:flutter/foundation.dart';

enum PaymentCycle {
  joiningDate,
  firstOfEachMonth
}

extension PaymentCycleValue on PaymentCycle {
  String get name => describeEnum(this);

  String get label {
    switch (this) {
      case PaymentCycle.joiningDate:
        return 'Joining Date';
      case PaymentCycle.firstOfEachMonth:
        return 'First of Each Month';
      default:
        return 'SelectedScheme Title is null';
    }
  }
}
