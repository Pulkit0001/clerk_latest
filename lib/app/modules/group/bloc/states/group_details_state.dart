import 'package:clerk/app/data/models/candidate_data_model.dart';
import 'package:clerk/app/data/models/charge_data_model.dart';
import 'package:clerk/app/data/models/group_data_model.dart';
import 'package:clerk/app/utils/enums/view_state_enums.dart';

class GroupDetailsState {
  final String groupId;
  final String? errorMessage;
  final Group? group;
  final ViewState viewState;
  final List<Candidate> candidates;
  final List<Charge> charges;

  GroupDetailsState(
      {required this.groupId,
      this.errorMessage,
      this.group,
      required this.viewState,
      required this.candidates,
      required this.charges});

  factory GroupDetailsState.initial({
    required String groupId,
  }) =>
      GroupDetailsState(
          groupId: groupId,
          viewState: ViewState.empty,
          charges: [],
          candidates: []);

  GroupDetailsState copyWith({
    String? groupId,
    Group? group,
    ViewState? viewState,
    String? errorMessage,
    List<Candidate>? candidates,
    List<Charge>? charges,
  }) =>
      GroupDetailsState(
        groupId: groupId ?? this.groupId,
        viewState: viewState ?? this.viewState,
        errorMessage: errorMessage ?? this.errorMessage,
        group: group ?? this.group,
        candidates: candidates ?? this.candidates,
        charges: charges ?? this.charges,
      );
}
