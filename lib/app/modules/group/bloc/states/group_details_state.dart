import 'package:clerk/app/data/models/candidate_data_model.dart';
import 'package:clerk/app/data/models/charge_data_model.dart';
import 'package:clerk/app/data/models/group_data_model.dart';
import 'package:clerk/app/utils/enums/view_state_enums.dart';

class GroupDetailsState {
  final String groupId;
  final String? errorMessage;
  final Group? group;
  final num? pendingAmount;
  final ViewState viewState;
  final List<Candidate> candidates;
  final List<Charge> charges;
  final ViewState pendingAmountState;

  GroupDetailsState(
      {required this.groupId,
      this.errorMessage,
      this.group,
      this.pendingAmount,
      required this.viewState,
      required this.pendingAmountState,
      required this.candidates,
      required this.charges});

  factory GroupDetailsState.initial({
    required String groupId,
  }) =>
      GroupDetailsState(
          groupId: groupId,
          viewState: ViewState.empty,
          pendingAmountState: ViewState.empty,
          charges: [],
          candidates: []);

  GroupDetailsState copyWith({
    String? groupId,
    Group? group,
    ViewState? viewState,
    ViewState? pendingAmountState,
    num? pendingAmount,
    String? errorMessage,
    List<Candidate>? candidates,
    List<Charge>? charges,
  }) =>
      GroupDetailsState(
        groupId: groupId ?? this.groupId,
        viewState: viewState ?? this.viewState,
        pendingAmountState: pendingAmountState ?? this.pendingAmountState,
        errorMessage: errorMessage ?? this.errorMessage,
        group: group ?? this.group,
        pendingAmount: pendingAmount ?? this.pendingAmount,
        candidates: candidates ?? this.candidates,
        charges: charges ?? this.charges,
      );
}