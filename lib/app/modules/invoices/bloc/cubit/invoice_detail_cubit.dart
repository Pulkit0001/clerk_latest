import 'package:clerk/app/modules/invoices/bloc/state/invoice_detail_state.dart';
import 'package:clerk/app/modules/invoices/widgets/invoice_cancel_sheet.dart';
import 'package:clerk/app/repository/invoice_repo/invoice_repo.dart';
import 'package:clerk/app/services/utility_service.dart';
import 'package:clerk/app/utils/enums/pay_mode.dart';
import 'package:clerk/app/values/strings.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../data/models/invoice_data_model.dart';

class InvoiceDetailCubit extends Cubit<InvoiceDetailState> {
  InvoiceDetailCubit({required Invoice invoice, required this.repo})
      : super(InvoiceDetailState.initial(invoice: invoice));

  final InvoiceRepo repo;
  Future<String> acceptPayment(InvoicePayMode payMode, double amount) async {
    try {
      var res =
          await repo.payInvoice(invoiceId: state.invoice.id, payMode: payMode);
      return res.fold<String>(
          (l) => l
              ? "Invoice marked paid successfully"
              : StringConstants.somethingWentWrong,
          (r) => StringConstants.somethingWentWrong);
    } catch (e) {
      UtilityService.cprint(e.toString());
      return StringConstants.somethingWentWrong;
    }
  }

  Future<String> cancelPayment(InvoiceCancelReason cancelReason) async {
    try {
      var res = await repo.cancelInvoice(
        invoiceId: state.invoice.id,
        cancelReason: cancelReason.name,
      );
      return res.fold<String>(
          (l) => l
              ? "Invoice cancelled successfully"
              : StringConstants.somethingWentWrong,
          (r) => StringConstants.somethingWentWrong);
    } catch (e) {
      UtilityService.cprint(e.toString());
      return StringConstants.somethingWentWrong;
    }
  }

  Future<String> updateInvoice() async {
    try {
      var res = await repo.updateInvoice(
        invoice: state.invoice
      );
      return res.fold<String>(
              (l) => l
              ? "Invoice cancelled successfully"
              : StringConstants.somethingWentWrong,
              (r) => StringConstants.somethingWentWrong);
    } catch (e) {
      UtilityService.cprint(e.toString());
      return StringConstants.somethingWentWrong;
    }
  }
}
