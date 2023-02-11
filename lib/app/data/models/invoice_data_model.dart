import 'dart:convert';

import 'package:clerk/app/utils/enums/entity_status.dart';
import 'package:clerk/app/utils/enums/pay_mode.dart';

import '../../utils/enums/invoice_canceller.dart';
import '../../utils/enums/invoice_status.dart';

class Invoice {
  final String id;
  final num totalAmount;
  final DateTime createdAt;
  final DateTime dueDate;
  final InvoiceStatus invoiceStatus;
  final List<InvoiceItem> invoiceItems;
  final String payerId;
  final DateTime issuedAt;
  final DateTime lastNotified;
  final num paidAmount;
  final DateTime paidOn;
  final InvoicePayMode payMode;
  final String receiptId;
  final String? cancelReason;
  final InvoiceCanceller cancelledBy;
  final EntityStatus status;

  Invoice(
      {required this.id,
      required this.totalAmount,
      required this.createdAt,
      required this.dueDate,
      required this.invoiceStatus,
      required this.invoiceItems,
      required this.payerId,
      required this.issuedAt,
      required this.lastNotified,
      required this.paidAmount,
      required this.paidOn,
      required this.payMode,
      required this.receiptId,
      required this.cancelReason,
      required this.cancelledBy,
      required this.status});

  factory Invoice.fromRawJson(String str) => Invoice.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Invoice.fromJson(Map<String, dynamic> json) => Invoice(
      id: json['id'],
      totalAmount: json['totalAmount'],
      createdAt: DateTime.parse(json['createdAt']),
      dueDate: DateTime.parse(json['dueDate']),
      invoiceStatus: InvoiceStatus.values
          .firstWhere((element) => element.name == json['invoiceStatus']),
      invoiceItems: json['invoiceItems'].map((e) => InvoiceItem.fromJson(e)),
      payerId: json['payerId'],
      issuedAt: DateTime.parse(json['issuedAt']),
      lastNotified: DateTime.parse(json['lastNotified']),
      paidAmount: json['paidAmount'],
      paidOn: DateTime.parse(json['paidOn']),
      payMode: InvoicePayMode.values
          .firstWhere((element) => element.name == json['payMode']),
      receiptId: json['receiptId'],
      cancelReason: json['cancelReason'],
      cancelledBy: InvoiceCanceller.values
          .firstWhere((element) => element.name == json['cancelledBy']),
      status: EntityStatus.values
          .firstWhere((element) => element == json['status']));

  Map<String, dynamic> toJson() => {

        'totalAmount': totalAmount,
        'createdAt': createdAt.toIso8601String(),
        'dueDate': dueDate.toIso8601String(),
        'invoiceStatus': invoiceStatus.name,
        'invoiceItems': invoiceItems.map((e) => e.toJson()),
        'payerId': payerId,
        'issuedAt': issuedAt.toIso8601String(),
        'lastNotified': lastNotified.toIso8601String(),
        'paidAmount': paidAmount,
        'paidOn': paidOn.toIso8601String(),
        'payMode': payMode.name,
        'receiptId': receiptId,
        'cancelReason': cancelReason,
        'cancelledBy': cancelledBy.name,
        'status': status.name,
      };

  Invoice copyWith({
    String? id,
    num? totalAmount,
    DateTime? createdAt,
    DateTime? dueDate,
    InvoiceStatus? invoiceStatus,
    List<InvoiceItem>? invoiceItems,
    String? payerId,
    DateTime? issuedAt,
    DateTime? lastNotified,
    num? paidAmount,
    DateTime? paidOn,
    InvoicePayMode? payMode,
    String? receiptId,
    String? cancelReason,
    InvoiceCanceller? cancelledBy,
    EntityStatus? status,
  }) =>
      Invoice(
          id: id ?? this.id,
          totalAmount: totalAmount ?? this.totalAmount,
          createdAt: createdAt ?? this.createdAt,
          dueDate: dueDate ?? this.dueDate,
          invoiceStatus: invoiceStatus ?? this.invoiceStatus,
          invoiceItems: invoiceItems ?? this.invoiceItems,
          payerId: payerId ?? this.payerId,
          issuedAt: issuedAt ?? this.issuedAt,
          lastNotified: lastNotified ?? this.lastNotified,
          paidAmount: paidAmount ?? this.paidAmount,
          paidOn: paidOn ?? this.paidOn,
          payMode: payMode ?? this.payMode,
          receiptId: receiptId ?? this.receiptId,
          cancelReason: cancelReason ?? this.cancelReason,
          cancelledBy: cancelledBy ?? this.cancelledBy,
          status: status ?? this.status);
}

class InvoiceItem {
  final String chargeName;
  final String chargeDescription;
  final num chargeAmount;
  final DateTime chargedAt;

  InvoiceItem(
      {required this.chargeName,
      required this.chargeDescription,
      required this.chargeAmount,
      required this.chargedAt});

  factory InvoiceItem.fromRawJson(String str) =>
      InvoiceItem.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory InvoiceItem.fromJson(Map<String, dynamic> json) => InvoiceItem(
      chargeName: json['chargeName'],
      chargeDescription: json['chargeDescription'],
      chargeAmount: json['chargeAmount'],
      chargedAt: DateTime.parse(json['chargedAt']));

  Map<String, dynamic> toJson() => {
        'chargeName': chargeName,
        'chargeDescription': chargeDescription,
        'chargeAmount': chargeAmount,
        'chargedAt': chargedAt.toIso8601String(),
      };
}
