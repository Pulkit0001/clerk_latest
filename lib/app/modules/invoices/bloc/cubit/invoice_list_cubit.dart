import 'package:clerk/app/utils/enums/invoice_status.dart';
import 'package:clerk/app/utils/enums/view_state_enums.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../repository/invoice_repo/invoice_repo.dart';
import '../state/invoice_list_state.dart';

class InvoiceListCubit extends Cubit<InvoiceListState> {
  InvoiceListCubit({
    required this.repo,
    this.candidateIds,
    this.status,
  }) : super(InvoiceListState.initial()) {
    loadInvoice();
  }

  final List<String>? candidateIds;
  final InvoiceStatus? status;
  final InvoiceRepo repo;

  loadInvoice() async {
    try {
      emit(state.copyWith(viewState: ViewState.loading));
      var res =
          await repo.getInvoices(candidateIds: candidateIds, status: status);
      res.fold((l) {
        if (l.isEmpty) {
          if (isClosed) {
            return;
          }
          emit(state.copyWith(invoices: l, viewState: ViewState.empty));
        } else {
          if (isClosed) {
            return;
          }
          emit(state.copyWith(invoices: l, viewState: ViewState.idle));
        }
      }, (r) {
        emit(state.copyWith(errorMessage: r, viewState: ViewState.error));
      });
    } catch (e) {
      if (isClosed) {
        return;
      }
      emit(state.copyWith(
          viewState: ViewState.error, errorMessage: e.toString()));
    }
  }
}
