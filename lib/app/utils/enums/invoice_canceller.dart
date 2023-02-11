import 'package:flutter/foundation.dart';

enum InvoiceCanceller {
  system,
  payee
}

extension InvoiceCancellerValue on InvoiceCanceller {
  String get name => describeEnum(this);

  String get label {
    switch (this) {
      case InvoiceCanceller.system:
        return 'System';
      case InvoiceCanceller.payee:
        return 'Payee';
      default:
        return 'Selected Scheme Title is null';
    }
  }
}
