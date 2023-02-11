import 'dart:convert';

import 'package:clerk/app/utils/enums/entity_status.dart';

class Candidate {
  Candidate({
    required this.id,
    required this.age,
    required this.name,
    required this.group,
    required this.email,
    required this.extraCharges,
    required this.groupCharges,
    required this.contact,
    required this.address,
    required this.payments,
    required this.profilePic,
    required this.optionalContact,
    required this.status,
  });

  final String id;
  final int age;
  final String name;
  final String group;
  final String email;
  final List<String> extraCharges;
  final List<String> groupCharges;
  final String contact;
  final String address;
  final List<String> payments;
  final String profilePic;
  final String optionalContact;
  final EntityStatus status;

  factory Candidate.fromRawJson(String str) =>
      Candidate.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Candidate.fromJson(Map<String, dynamic> json) => Candidate(
        id: json["candidate_id"],
        age: json["candidate_age"],
        name: json["candidate_name"],
        group: json["candidate_group"],
        email: json["candidate_email"],
        extraCharges: List<String>.from(json["extra_charges"].map((x) => x)),
        groupCharges: List<String>.from(json["group_charges"].map((x) => x)),
        contact: json["candidate_contact"],
        address: json["candidate_address"],
        payments: List<String>.from(json["candidate_payments"].map((x) => x)),
        profilePic: json["candidate_profile_pic"],
        optionalContact: json["candidate_optional_contact"],
        status: EntityStatus.values
            .where((element) => element.name == json["candidate_status"])
            .first,
      );

  factory Candidate.empty() => Candidate(
      id: "",
      age: 0,
      name: "",
      group: "",
      email: "",
      extraCharges: [],
      groupCharges: [],
      contact: "",
      address: "",
      payments: [],
      profilePic: "",
      optionalContact: "",
      status: EntityStatus.disabled);

  Map<String, dynamic> toJson() => {
        "candidate_age": age,
        "candidate_name": name,
        "candidate_group": group,
        "candidate_email": email,
        "candidate_contact": contact,
        "candidate_address": address,
        "candidate_payments": List<dynamic>.from(payments.map((x) => x)),
        "candidate_profile_pic": profilePic,
        "candidate_optional_contact": optionalContact,
        "candidate_status": status.name,
      };

  Candidate copyWith({
    String? id,
    int? age,
    String? name,
    String? group,
    String? email,
    List<String>? extraCharges,
    List<String>? groupCharges,
    String? contact,
    String? address,
    List<String>? payments,
    String? profilePic,
    String? optionalContact,
    EntityStatus? status,
  }) =>
      Candidate(
          id: id ?? this.id,
          age: age ?? this.age,
          name: name ?? this.name,
          group: group ?? this.group,
          email: email ?? this.email,
          extraCharges: extraCharges ?? this.extraCharges,
          groupCharges: groupCharges ?? this.groupCharges,
          contact: contact ?? this.contact,
          address: address ?? this.address,
          payments: payments ?? this.payments,
          profilePic: profilePic ?? this.profilePic,
          optionalContact: optionalContact ?? this.optionalContact,
          status: status ?? this.status);
}
