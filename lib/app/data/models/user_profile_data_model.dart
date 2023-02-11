import 'dart:convert';

import 'package:clerk/app/utils/enums/entity_status.dart';

import '../../utils/enums/payment_cycle.dart';
import '../../utils/enums/profile_status.dart';

class UserProfile {
  final String userId;
  final String firstName;
  final String lastName;
  final String occupation;
  final String businessName;
  final String businessLogo;
  final String businessEmail;
  final String businessAddress;
  final String businessContact;
  final EntityStatus userStatus;
  final ProfileStatus profileStatus;
  final PaymentCycle paymentCycle;

  UserProfile(
      {required this.userId,
      required this.firstName,
      required this.lastName,
      required this.businessAddress,
      required this.occupation,
      required this.businessName,
      required this.businessLogo,
      required this.businessEmail,
      required this.businessContact,
      required this.userStatus,
      required this.profileStatus,
      required this.paymentCycle});

  factory UserProfile.empty() => UserProfile(
      userId: "",
      firstName: "",
      lastName: "",
      occupation: "",
      businessAddress: "",
      businessName: "",
      businessLogo: "",
      businessEmail: "",
      businessContact: "",
      userStatus: EntityStatus.active,
      profileStatus: ProfileStatus.personalDetails,
      paymentCycle: PaymentCycle.joiningDate);

  factory UserProfile.fromRawJson(String str) =>
      UserProfile.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory UserProfile.fromJson(Map<String, dynamic> json) => UserProfile(
      userId: json['user_id'],
      firstName: json['first_name'],
      lastName: json['last_name'],
      occupation: json['occupation'],
      businessAddress: json['business_address'],
      businessName: json['business_name'],
      businessLogo: json['business_logo'],
      businessEmail: json["business_email"],
      businessContact: json['business_contact'],
      userStatus: EntityStatus.values
          .firstWhere((element) => element.name == json['user_status']),
      profileStatus: ProfileStatus.values
          .firstWhere((element) => element.name == json['profile_status']),
      paymentCycle: PaymentCycle.values
          .firstWhere((element) => element.name == json['payment_cycle']));

  Map<String, dynamic> toJson() => {
        "first_name": firstName,
        "last_name": lastName,
        "occupation": occupation,
        "business_name": businessName,
        "business_logo": businessLogo,
        "business_email": businessEmail,
        "business_address": businessAddress,
        "business_contact": businessContact,
        "user_status": userStatus.name,
        "profile_status": profileStatus.name,
        "payment_cycle": paymentCycle.name,
      };

  UserProfile copyWith({
    String? userId,
    String? firstName,
    String? lastName,
    String? occupation,
    String? businessName,
    String? businessLogo,
    String? businessEmail,
    String? businessAddress,
    String? businessContact,
    EntityStatus? userStatus,
    ProfileStatus? profileStatus,
    PaymentCycle? paymentCycle,
  }) =>
      UserProfile(
          userId: userId ?? this.userId,
          firstName: firstName ?? this.firstName,
          lastName: lastName ?? this.lastName,
          occupation: occupation ?? this.occupation,
          businessName: businessName ?? this.businessName,
          businessLogo: businessLogo ?? this.businessLogo,
          businessEmail: businessEmail ?? this.businessEmail,
          businessAddress: businessAddress ?? this.businessAddress,
          businessContact: businessContact ?? this.businessContact,
          userStatus: userStatus ?? this.userStatus,
          profileStatus: profileStatus ?? this.profileStatus,
          paymentCycle: paymentCycle ?? this.paymentCycle);
}
