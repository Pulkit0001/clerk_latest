// To parse this JSON data, do
//
//     final charge = chargeFromJson(jsonString);

import 'package:clerk/app/utils/enums/entity_status.dart';
import 'package:clerk/app/utils/enums/payment_interval_enums.dart';
import 'package:clerk/app/utils/enums/payment_type.dart';
import 'package:meta/meta.dart';
import 'dart:convert';

class Charge {
  Charge({
    required this.id,
    required this.name,
    required this.amount,
    required this.interval,
    required this.paymentType,
    required this.description,
    required this.status,
  });

  final String id;
  final String name;
  final num amount;
  final PaymentInterval interval;
  final PaymentType paymentType;
  final String description;
  final EntityStatus status;

  factory Charge.fromRawJson(String str) => Charge.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Charge.fromJson(Map<String, dynamic> json) => Charge(
        id: json["charge_id"],
        name: json["charge_name"],
        amount: json["charge_amount"].toDouble(),
        interval: PaymentInterval.values
            .where((element) => element.name == json["charge_interval"])
            .first,
        paymentType: PaymentType.values
            .where((element) => element.name == json["charge_payment_type"])
            .first,
        description: json["charge_description_key"],
        status: EntityStatus.values
            .where((element) => element.name == json["charge_status"])
            .first,
      );

  Map<String, dynamic> toJson() => {
        "charge_id": id,
        "charge_name": name,
        "charge_amount": amount,
        "charge_interval": interval.name,
        "charge_payment_type": paymentType.name,
        "charge_description_key": description,
        "charge_status": status.name,
      };

  Charge copyWith({
    String? id,
    String? name,
    num? amount,
    PaymentInterval? interval,
    PaymentType? paymentType,
    String? description,
    EntityStatus? status,
  }) =>
      Charge(
          id: id ?? this.id,
          name: name ?? this.name,
          amount: amount ?? this.amount,
          interval: interval ?? this.interval,
          paymentType: paymentType ?? this.paymentType,
          description: description ?? this.description,
          status: status ?? this.status);

  factory Charge.empty() => Charge(
      id: "",
      name: "",
      amount: 0,
      interval: PaymentInterval.none,
      paymentType: PaymentType.oneTime,
      description: "",
      status: EntityStatus.active);
}
