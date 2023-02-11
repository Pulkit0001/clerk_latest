import 'package:clerk/app/data/models/candidate_data_model.dart';
import 'package:clerk/app/data/models/charge_data_model.dart';
import 'package:clerk/app/data/models/candidate_data_model.dart';
import 'package:clerk/app/utils/enums/view_state_enums.dart';

class CandidateDetailsState {
  final String candidateId;
  final String? errorMessage;
  final Candidate? candidate;
  final ViewState viewState;
  final List<Candidate> candidates;
  final List<Charge> charges;

  CandidateDetailsState(
      {required this.candidateId,
      this.errorMessage,
      this.candidate,
      required this.viewState,
      required this.candidates,
      required this.charges});

  factory CandidateDetailsState.initial({
    required String candidateId,
  }) =>
      CandidateDetailsState(
          candidateId: candidateId,
          viewState: ViewState.empty,
          charges: [],
          candidates: []);

  CandidateDetailsState copyWith({
    String? candidateId,
    Candidate? candidate,
    ViewState? viewState,
    String? errorMessage,
    List<Candidate>? candidates,
    List<Charge>? charges,
  }) =>
      CandidateDetailsState(
        candidateId: candidateId ?? this.candidateId,
        viewState: viewState ?? this.viewState,
        errorMessage: errorMessage ?? this.errorMessage,
        candidate: candidate ?? this.candidate,
        candidates: candidates ?? this.candidates,
        charges: charges ?? this.charges,
      );
}
