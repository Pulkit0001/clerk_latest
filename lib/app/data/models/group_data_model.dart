import 'dart:convert';

import 'package:clerk/app/utils/enums/entity_status.dart';

class Group {
  Group({
    required this.id,
    required this.name,
    required this.charges,
    required this.startTime,
    required this.endTime,
    required this.candidates,
    required this.status,
  });

  final String id;
  final String name;
  final List<String> charges;
  final String startTime;
  final String endTime;
  final List<String> candidates;
  final EntityStatus status;
  factory Group.empty() => Group(
      id: "",
      name: "",
      charges: [],
      startTime: "",
      endTime: "",
      candidates: [],
      status: EntityStatus.disabled);
  factory Group.fromRawJson(String str) => Group.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Group.fromJson(Map<String, dynamic> json) => Group(
        id: json["group_id"],
        name: json["group_name"],
        charges: List<String>.from(json["group_charges"].map((x) => x)),
        startTime: json["group_start_time"],
        endTime: json["group_end_time"],
        candidates: List<String>.from(json["group_candidates"].map((x) => x)),
        status: EntityStatus.values
            .where((element) => element.name == json["group_status"])
            .first,
      );

  Map<String, dynamic> toJson() => {
        "group_id": id,
        "group_name": name,
        "group_charges": List<dynamic>.from(charges.map((x) => x)),
        "group_start_time": startTime,
        "group_end_time": endTime,
        "group_candidates": List<dynamic>.from(candidates.map((x) => x)),
        "group_status": status.name,
      };

  Group copyWith({
    String? id,
    String? name,
    List<String>? charges,
    String? startTime,
    String? endTime,
    List<String>? candidates,
    EntityStatus? status,
  }) =>
      Group(
          id: id ?? this.id,
          name: name ?? this.name,
          charges: charges ?? this.charges,
          startTime: startTime ?? this.startTime,
          endTime: endTime ?? this.endTime,
          candidates: candidates ?? this.candidates,
          status: status ?? this.status);
}
