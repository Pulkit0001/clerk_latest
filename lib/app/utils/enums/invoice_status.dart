import 'package:flutter/foundation.dart';

enum InvoiceStatus {
  created,
  issued,
  pending,
  paid,
  cancelled
}

extension InvoiceStatusValue on InvoiceStatus {
  String get name => describeEnum(this);

  String get label {
    switch (this) {
      case InvoiceStatus.created:
        return 'Invoice Created';
      case InvoiceStatus.issued:
        return 'Invoice Issued';
      case InvoiceStatus.pending:
        return 'Invoice Pending';
      case InvoiceStatus.paid:
        return 'Invoice Paid';
      case InvoiceStatus.cancelled:
        return 'Invoice Cancelled';
    }
  }
}
