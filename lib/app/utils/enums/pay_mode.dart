import 'package:flutter/foundation.dart';

enum InvoicePayMode {  online, cash, }

extension InvoicePayModeValue on InvoicePayMode {
  String get name => describeEnum(this);

  String get label {
    switch (this) {
      case InvoicePayMode.cash:
        return 'Cash';
      case InvoicePayMode.online:
        return 'Online';
    }
  }
}
