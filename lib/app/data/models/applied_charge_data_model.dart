import 'package:clerk/app/utils/enums/entity_status.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AppliedCharge {
  final String appliedChargeId;
  final String chargeId;
  final EntityStatus status;
  final DateTime lastBilledAt;
  final DateTime nextBillingDate;
  final bool isExtra;

  AppliedCharge(
      {required this.appliedChargeId,
      required this.chargeId,
      required this.status,
      required this.lastBilledAt,
      required this.nextBillingDate,
      required this.isExtra});

  factory AppliedCharge.fromJson(Map<String, dynamic> json) => AppliedCharge(
        appliedChargeId: json['id'],
        chargeId: json['charge_id'],
        status: json['status'],
        lastBilledAt: json['last_billed_at'],
        nextBillingDate: json['next_billing_date'],
        isExtra: json['is_extra'],
      );

  Map<String, dynamic> toJson() => {
        'charge_id': chargeId,
        'status': status.name,
        'last_billed_at': Timestamp.fromDate(lastBilledAt),
        'next_billing_date': Timestamp.fromDate(nextBillingDate),
        'is_extra': isExtra
      };
}
