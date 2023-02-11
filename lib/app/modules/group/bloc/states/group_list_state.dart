import 'package:clerk/app/data/models/group_data_model.dart';
import 'package:clerk/app/utils/enums/view_state_enums.dart';

class GroupsListState {
  final List<Group> groups;
  final String? errorMessage;
  final ViewState viewState;

  GroupsListState({
    required this.groups,
    required this.viewState,
    this.errorMessage,
  });

  factory GroupsListState.initial() =>
      GroupsListState(groups: [], viewState: ViewState.empty);

  GroupsListState copyWith({
    List<Group>? groups,
    String? errorMessage,
    ViewState? viewState,
  }) =>
      GroupsListState(
          groups: groups ?? this.groups,
          viewState: viewState ?? this.viewState,
          errorMessage: errorMessage ?? this.errorMessage);
}
