import 'package:clerk/app/data/models/charge_data_model.dart';
import 'package:clerk/app/modules/candidate/bloc/states/candidate_details_state.dart';
import 'package:clerk/app/repository/charge_repo/charge_repo.dart';
import 'package:clerk/app/repository/candidate_repo/candidate_repo.dart';
import 'package:clerk/app/utils/enums/view_state_enums.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../repository/candidate_repo/candidate_repo.dart';

class CandidateDetailsCubit extends Cubit<CandidateDetailsState> {
  CandidateDetailsCubit({
    required String candidateId,
    required this.repo,
  }) : super(CandidateDetailsState.initial(candidateId: candidateId)) {
    loadCandidate();
  }

  final CandidateRepo repo;

  loadCandidate() async {
    try {
      emit(state.copyWith(viewState: ViewState.loading));
      var res = await repo.getAllCandidates(candidateIds: [state.candidateId]);
      res.fold((l) {
        emit(state.copyWith(candidate: l.first, viewState: ViewState.idle));
      }, (r) {
        emit(state.copyWith(errorMessage: r, viewState: ViewState.error));
      });
    } catch (e) {
      emit(state.copyWith(
          viewState: ViewState.error, errorMessage: e.toString()));
    }
  }

}
