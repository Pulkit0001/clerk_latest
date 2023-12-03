import 'package:clerk/app/repository/group_repo/group_repo.dart';
import 'package:clerk/app/repository/invoice_repo/invoice_repo.dart';
import 'package:clerk/app/utils/enums/invoice_status.dart';
import 'package:clerk/app/utils/enums/view_state_enums.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'dashboard_state.dart';

class DashboardCubit extends Cubit<DashboardState> {
  DashboardCubit(this.invoiceRepo) : super(DashboardState.initial()){
    getTotalPendingAmount();
  }

  final PageController pageController = PageController();
  final InvoiceRepo invoiceRepo;

  changePageIndex(int index) {
    emit(state.copyWith(pageIndex: index));
  }

  Future<void> getTotalPendingAmount() async {
    try {
      emit(state.copyWith(pendingAmountState: ViewState.loading));
      var res = await invoiceRepo.getTotalSum(status: InvoiceStatus.pending);
      res.fold((l) {
        emit(state.copyWith(
            pendingAmountState: ViewState.idle, totalPendingAmount: l));
      }, (r) {
        emit(state.copyWith(pendingAmountState: ViewState.error));
      });
    } catch (e) {
      emit(state.copyWith(pendingAmountState: ViewState.error));
    }
  }
}
