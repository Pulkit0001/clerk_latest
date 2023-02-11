import 'package:clerk/app/data/models/candidate_data_model.dart';
import 'package:clerk/app/utils/enums/view_state_enums.dart';

class CandidatesListState {
  final List<Candidate> candidates;
  final String? errorMessage;
  final ViewState viewState;

  CandidatesListState({
    required this.candidates,
    required this.viewState,
    this.errorMessage,
  });

  factory CandidatesListState.initial() =>
      CandidatesListState(candidates: [], viewState: ViewState.empty);

  CandidatesListState copyWith({
    List<Candidate>? candidates,
    String? errorMessage,
    ViewState? viewState,
  }) =>
      CandidatesListState(
          candidates: candidates ?? this.candidates,
          viewState: viewState ?? this.viewState,
          errorMessage: errorMessage ?? this.errorMessage);
}
