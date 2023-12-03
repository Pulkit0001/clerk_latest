import 'package:flutter/foundation.dart';

enum InvoiceStatus { created, issued, pending, paid, cancelled }

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

  String heading(DateTime dueDate) {
    switch (this) {
      case InvoiceStatus.created:
        return 'Created on: ';
      case InvoiceStatus.issued:
      case InvoiceStatus.pending:
        {
          if (dueDate.isBefore(DateTime.now())) {
            return 'Overdue By: ';
          } else {
            return 'Due on: ';
          }
        }
      case InvoiceStatus.paid:
        return 'Paid at: ';
      case InvoiceStatus.cancelled:
        return 'Cancelled at: ';
    }
  }
}
