import 'dart:convert';

import 'package:clerk/app/utils/enums/entity_status.dart';
import 'package:clerk/app/utils/enums/pay_mode.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../utils/enums/invoice_canceller.dart';
import '../../utils/enums/invoice_status.dart';
import 'candidate_data_model.dart';

class Invoice {
  final String id;
  final num totalAmount;
  final DateTime? createdAt;
  final DateTime? dueDate;
  final DateTime? cancelledOn;
  final InvoiceStatus invoiceStatus;
  final List<InvoiceItem> invoiceItems;
  final String? payerId;
  final DateTime? issuedAt;
  final DateTime? lastNotified;
  final num? paidAmount;
  final DateTime? paidOn;
  final InvoicePayMode? payMode;
  final String? receiptId;
  final String? cancelReason;
  final InvoiceCanceller? cancelledBy;
  final EntityStatus status;
  final Candidate? candidate;

  Invoice({
    required this.id,
    required this.totalAmount,
    required this.createdAt,
    required this.dueDate,
    required this.cancelledOn,
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
    required this.status,
    this.candidate,
  });

  factory Invoice.fromRawJson(String str) => Invoice.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Invoice.fromJson(Map<String, dynamic> json) => Invoice(
      id: json['id'],
      totalAmount: json['totalAmount'],
      createdAt: json['createdAt'] == null
          ? null
          : (json['createdAt'] as Timestamp).toDate(),
      dueDate: (json['dueDate'] as Timestamp).toDate(),
      cancelledOn: json['cancelledOn'] == null
          ? null
          : (json['cancelledOn'] as Timestamp).toDate(),
      invoiceStatus: InvoiceStatus.values
          .firstWhere((element) => element.name == json['invoiceStatus']),
      invoiceItems: (json['invoiceItems'] as List<dynamic>)
          .map((e) => InvoiceItem.fromJson(e))
          .toList(),
      payerId: json['payerId'],
      issuedAt: json['issuedAt'] == null
          ? null
          : (json['issuedAt'] as Timestamp).toDate(),
      lastNotified: json['lastNotified'] == null
          ? null
          : (json['lastNotified'] as Timestamp).toDate(),
      paidAmount: json['paidAmount'],
      paidOn: json['paidOn'] == null
          ? null
          : (json['paidOn'] as Timestamp).toDate(),
      payMode: json['payMode'] == null
          ? null
          : InvoicePayMode.values
              .firstWhere((element) => element.name == json['payMode']),
      receiptId: json['receiptId'],
      cancelReason: json['cancelReason'],
      cancelledBy: json['cancelledBy'] == null
          ? null
          : InvoiceCanceller.values
              .firstWhere((element) => element.name == json['cancelledBy']),
      candidate: json['candidate'] == null
          ? null
          : Candidate.fromJson(json['candidate']),
      status: EntityStatus.values
          .firstWhere((element) => element.name == json['status']));

  Map<String, dynamic> toJson() => {
        'candidate': candidate?.toJson(),
        'totalAmount': totalAmount,
        'createdAt': createdAt == null ? null : Timestamp.fromDate(createdAt!),
        'dueDate': dueDate == null ? null : Timestamp.fromDate(dueDate!),
        'invoiceStatus': invoiceStatus.name,
        'invoiceItems': invoiceItems.map((e) => e.toJson()),
        'payerId': payerId,
        'issuedAt': issuedAt == null ? null : Timestamp.fromDate(issuedAt!),
        'lastNotifiedAt':
            lastNotified == null ? null : Timestamp.fromDate(lastNotified!),
        'paidAmount': paidAmount,
        'paidOn': paidOn == null ? null : Timestamp.fromDate(paidOn!),
        'payMode': payMode?.name,
        'receiptId': receiptId,
        'cancelReason': cancelReason,
        'cancelledBy': cancelledBy?.name,
        'status': status.name,
      };

  Invoice copyWith({
    String? id,
    num? totalAmount,
    DateTime? createdAt,
    DateTime? dueDate,
    DateTime? cancelledOn,
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
    Candidate? candidate,
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
          cancelledOn: cancelledOn ?? this.cancelledOn,
          paidOn: paidOn ?? this.paidOn,
          payMode: payMode ?? this.payMode,
          receiptId: receiptId ?? this.receiptId,
          cancelReason: cancelReason ?? this.cancelReason,
          cancelledBy: cancelledBy ?? this.cancelledBy,
          status: status ?? this.status,
          candidate: candidate ?? this.candidate);

  DateTime get dateToShow {
    switch (invoiceStatus) {
      case InvoiceStatus.created:
        return createdAt ?? DateTime.now();
      case InvoiceStatus.issued:
        return dueDate ?? DateTime.now();
      case InvoiceStatus.pending:
        return dueDate ?? DateTime.now();
      case InvoiceStatus.paid:
        return paidOn ?? DateTime.now();
      case InvoiceStatus.cancelled:
        return cancelledOn ?? DateTime.now();
    }
  }
}

class InvoiceItem {
  final String chargeName;
  final String chargeDescription;
  final num chargeAmount;
  final DateTime? chargedAt;

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
        chargedAt: json['chargedAt'] == null
            ? null
            : json['chargedAt'] is Timestamp
                ? (json['chargedAt'] as Timestamp).toDate()
                : DateTime.tryParse(json['chargedAt'].toString()),
      );

  Map<String, dynamic> toJson() => {
        'chargeName': chargeName,
        'chargeDescription': chargeDescription,
        'chargeAmount': chargeAmount,
        'chargedAt': chargedAt == null ? null : Timestamp.fromDate(chargedAt!),
      };
}
