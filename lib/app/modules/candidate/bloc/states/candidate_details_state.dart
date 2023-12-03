import 'package:clerk/app/data/models/candidate_data_model.dart';
import 'package:clerk/app/data/models/charge_data_model.dart';
import 'package:clerk/app/data/models/candidate_data_model.dart';
import 'package:clerk/app/data/models/invoice_data_model.dart';
import 'package:clerk/app/utils/enums/view_state_enums.dart';

class CandidateDetailsState {
  final String candidateId;
  final String? errorMessage;
  final Candidate? candidate;
  final ViewState viewState;
  final Invoice? pendingInvoice;

  final List<Charge> charges;

  CandidateDetailsState(
      {required this.candidateId,
      this.errorMessage,
      this.candidate,
      this.pendingInvoice,
      required this.viewState,
      required this.charges});

  factory CandidateDetailsState.initial({
    required String candidateId,
  }) =>
      CandidateDetailsState(
        candidateId: candidateId,
        viewState: ViewState.empty,
        charges: [],
      );

  CandidateDetailsState copyWith({
    String? candidateId,
    Candidate? candidate,
    ViewState? viewState,
    String? errorMessage,
    List<Candidate>? candidates,
    List<Charge>? charges,
    Invoice? pendingInvoice,
  }) =>
      CandidateDetailsState(
        candidateId: candidateId ?? this.candidateId,
        viewState: viewState ?? this.viewState,
        errorMessage: errorMessage ?? this.errorMessage,
        candidate: candidate ?? this.candidate,
        charges: charges ?? this.charges,
        pendingInvoice: pendingInvoice ?? this.pendingInvoice,
      );
}
