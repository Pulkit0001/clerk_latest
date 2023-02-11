


import '../../../../data/models/candidate_data_model.dart';
import '../../../../utils/enums/view_state_enums.dart';

class CandidateFormState {
  final bool toCreate;
  final Candidate candidate;
  final CustomFormState formState;
  final String? errorMessage;
  final String? successMessage;
  final int formStep;

  CandidateFormState(
      {required this.toCreate,
        this.errorMessage,
        this.successMessage,
        required this.formStep,
        required this.candidate,
        required this.formState});

  factory CandidateFormState.initial({Candidate? candidate}) => CandidateFormState(
      candidate: candidate ?? Candidate.empty(),
      toCreate: candidate == null,
      formState: CustomFormState.idle,
      formStep: 0);

  CandidateFormState copyWith({
    bool? toCreate,
    Candidate? candidate,
    CustomFormState? formState,
    String? errorMessage,
    String? successMessage,
    int? formStep,
  }) =>
      CandidateFormState(
        toCreate: toCreate ?? this.toCreate,
        formState: formState ?? this.formState,
        candidate: candidate ?? this.candidate,
        successMessage: successMessage ?? this.successMessage,
        errorMessage: errorMessage ?? this.errorMessage,
        formStep: formStep ?? this.formStep,
      );
}
