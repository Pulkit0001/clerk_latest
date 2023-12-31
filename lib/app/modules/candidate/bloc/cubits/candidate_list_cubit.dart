import 'package:clerk/app/modules/candidate/bloc/states/candidate_list_state.dart';
import 'package:clerk/app/repository/candidate_repo/candidate_repo.dart';
import 'package:clerk/app/utils/enums/view_state_enums.dart';
import 'package:clerk/app/values/strings.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CandidateListCubit extends Cubit<CandidatesListState> {
  CandidateListCubit({
    required this.repo,
    this.candidates,
  }) : super(CandidatesListState.initial()) {
    loadCandidates(candidates);
  }

  final List<String>? candidates;
  final CandidateRepo repo;

  loadCandidates(List<String>? candidateIds) async {
    try {
      emit(state.copyWith(viewState: ViewState.loading));
      var res = await repo.getAllCandidates(candidateIds: candidateIds);
      res.fold((l) {
        if (l.isEmpty) {
          emit(state.copyWith(candidates: l, viewState: ViewState.empty));
        } else {
          emit(state.copyWith(candidates: l, viewState: ViewState.idle));
        }
      }, (r) {
        emit(state.copyWith(errorMessage: r, viewState: ViewState.error));
      });
    } catch (e) {
      if(!isClosed){
        emit(state.copyWith(
            viewState: ViewState.error, errorMessage: e.toString()));
      }
    }
  }

  Future<bool> deleteCandidate(String id) async {
    try {
      emit(state.copyWith(viewState: ViewState.loading));
      var res = await repo.deleteCandidate(candidateId: id);
      return res.fold<bool>((l) {
        if (l) {
          emit(state.copyWith(
            viewState: ViewState.idle,
            errorMessage: "Candidate deleted successfully",
          ));
          loadCandidates(candidates);
          return true;
        } else {
          emit(state.copyWith(errorMessage: defaultErrorBody));
          return false;
        }
      }, (r) {
        emit(state.copyWith(errorMessage: defaultErrorBody));
        return false;
      });
    } catch (e) {
      emit(state.copyWith(errorMessage: defaultErrorBody));
      return false;
    }
  }
}
