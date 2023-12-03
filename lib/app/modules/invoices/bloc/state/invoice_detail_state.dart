import 'package:clerk/app/utils/enums/view_state_enums.dart';

import '../../../../data/models/invoice_data_model.dart';

class InvoiceDetailState {
  final ViewState viewState;
  final Invoice invoice;
  final String? message;

  const InvoiceDetailState(
      {required this.viewState, required this.invoice, this.message});

  InvoiceDetailState copyWith({
    ViewState? viewState,
    Invoice? invoice,
    String? message,
  }) =>
      InvoiceDetailState(
          viewState: viewState ?? this.viewState,
          invoice: invoice ?? this.invoice);

  factory InvoiceDetailState.initial({required Invoice invoice}) =>
      InvoiceDetailState(invoice: invoice, viewState: ViewState.idle);
}
