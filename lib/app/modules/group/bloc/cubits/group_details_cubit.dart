import 'package:clerk/app/data/models/charge_data_model.dart';
import 'package:clerk/app/modules/group/bloc/states/group_details_state.dart';
import 'package:clerk/app/repository/charge_repo/charge_repo.dart';
import 'package:clerk/app/repository/group_repo/group_repo.dart';
import 'package:clerk/app/repository/invoice_repo/invoice_repo.dart';
import 'package:clerk/app/utils/enums/invoice_status.dart';
import 'package:clerk/app/utils/enums/view_state_enums.dart';
import 'package:clerk/app/utils/extensions.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../repository/candidate_repo/candidate_repo.dart';

class GroupDetailsCubit extends Cubit<GroupDetailsState> {
  GroupDetailsCubit({
    required String groupId,
    required this.repo,
    required this.candidateRepo,
    required this.chargeRepo,
    required this.invoiceRepo,
  }) : super(GroupDetailsState.initial(groupId: groupId)) {
    if (groupId.isEmpty) {
      getCurrentGroup();
    } else {
      loadGroup();
    }
  }

  final GroupRepo repo;
  final CandidateRepo candidateRepo;
  final ChargeRepo chargeRepo;
  final InvoiceRepo invoiceRepo;

  changeGroup(String groupId) async {
    emit(GroupDetailsState.initial(groupId: groupId));
    await loadGroup();
  }

  getCurrentGroup() async {
    try {
      emit(state.copyWith(viewState: ViewState.loading));
      var res = await repo.getCurrentGroup();
      res.fold((l) {
        changeGroup(l);
      }, (r) {
        emit(state.copyWith(
            viewState: ViewState.error, errorMessage: r.toString()));
      });
    } catch (e) {
      emit(state.copyWith(
          viewState: ViewState.error, errorMessage: e.toString()));
    }
  }

  loadGroup() async {
    try {
      if (state.groupId.isEmpty) {
        emit(state.copyWith(viewState: ViewState.empty));
        return;
      }
      emit(state.copyWith(viewState: ViewState.loading));
      var res = await repo.getAllGroups(groupIds: [state.groupId]);
      res.fold((l) {
        if (l.isEmpty) {
          emit(state.copyWith(viewState: ViewState.empty));
        } else {
          emit(state.copyWith(group: l.first, viewState: ViewState.idle));
          loadPendingAmount();
        }
      }, (r) {
        emit(state.copyWith(errorMessage: r, viewState: ViewState.error));
      });
    } catch (e) {
      emit(state.copyWith(
          viewState: ViewState.error, errorMessage: e.toString()));
    }
  }

  loadCandidates() async {
    try {
      emit(state.copyWith(viewState: ViewState.loading));
      var res = await candidateRepo.getAllCandidates(
          candidateIds: state.group?.candidates);
      res.fold((l) {
        emit(state.copyWith(candidates: l, viewState: ViewState.idle));
      }, (r) {
        emit(state.copyWith(errorMessage: r, viewState: ViewState.error));
      });
    } catch (e) {
      emit(state.copyWith(
          viewState: ViewState.error, errorMessage: e.toString()));
    }
  }

  loadCharges() async {
    try {
      emit(state.copyWith(viewState: ViewState.loading));
      var res = await chargeRepo.getAllCharges(chargeIds: state.group?.charges);
      res.fold((l) {
        emit(state.copyWith(charges: l, viewState: ViewState.idle));
      }, (r) {
        emit(state.copyWith(errorMessage: r, viewState: ViewState.error));
      });
    } catch (e) {
      emit(state.copyWith(
          viewState: ViewState.error, errorMessage: e.toString()));
    }
  }

  loadPendingAmount() async {
    try {
      emit(state.copyWith(pendingAmountState: ViewState.loading));
      var res = await invoiceRepo.getTotalSum(
          candidateIds: state.group?.candidates,
          status: InvoiceStatus.pending);
      res.fold((l) {
        emit(state.copyWith(
          pendingAmount: l,
          pendingAmountState: ViewState.idle,
        ));
      }, (r) {
        emit(state.copyWith(
            errorMessage: r, pendingAmountState: ViewState.error));
      });
    } catch (e) {
      emit(state.copyWith(
          pendingAmountState: ViewState.error, errorMessage: e.toString()));
    }
  }
}
