import 'package:clerk/app/modules/candidate/bloc/states/candidate_list_state.dart';
import 'package:clerk/app/repository/candidate_repo/candidate_repo.dart';
import 'package:clerk/app/utils/enums/invoice_status.dart';
import 'package:clerk/app/utils/enums/view_state_enums.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../repository/invoice_repo/invoice_repo.dart';
import '../state/invoice_list_state.dart';

class InvoiceListCubit extends Cubit<InvoiceListState> {
  InvoiceListCubit({
    required this.repo,
    this.candidateIds,
    required this.status,
  }) : super(InvoiceListState.initial()) {
    loadInvoice(candidateIds, status);
  }

  final List<String>? candidateIds;
  final List<InvoiceStatus> status;
  final InvoiceRepo repo;

  loadInvoice(List<String>? candidateIds, List<InvoiceStatus>? status) async {
    try {
      emit(state.copyWith(viewState: ViewState.loading));
      var res = await repo.getInvoices(candidateIds: candidateIds, status: status);
      res.fold((l) {
        if(l.isEmpty){
          emit(state.copyWith(invoices: l, viewState: ViewState.empty));
        }else {
          emit(state.copyWith(invoices: l, viewState: ViewState.idle));
        }
      }, (r) {
        emit(state.copyWith(errorMessage: r, viewState: ViewState.error));
      });
    } catch (e) {
      emit(state.copyWith(
          viewState: ViewState.error, errorMessage: e.toString()));
    }
  }
}
