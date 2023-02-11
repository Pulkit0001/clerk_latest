import 'package:flutter/foundation.dart';

enum PaymentType {
  oneTime,
  repeating,
}

extension PaymentTypeValue on PaymentType {
  String get name => describeEnum(this);
  String get label {
    switch (this) {
      case PaymentType.oneTime:
        return 'One Time';
      case PaymentType.repeating:
        return 'Repeating';
      default:
        return 'SelectedScheme Title is null';
    }
  }
}
