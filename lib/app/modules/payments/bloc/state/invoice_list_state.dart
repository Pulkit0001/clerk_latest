import 'package:clerk/app/data/models/invoice_data_model.dart';
import 'package:clerk/app/utils/enums/view_state_enums.dart';

class InvoiceListState {
  
  final List<Invoice> invoices;
  final String? errorMessage;
  final ViewState viewState;

  InvoiceListState({
    required this.invoices,
    required this.viewState,
    this.errorMessage,
  });

  factory InvoiceListState.initial() =>
      InvoiceListState(invoices: [], viewState: ViewState.empty);

  InvoiceListState copyWith({
    List<Invoice>? invoices,
    String? errorMessage,
    ViewState? viewState,
  }) =>
      InvoiceListState(
          invoices: invoices ?? this.invoices,
          viewState: viewState ?? this.viewState,
          errorMessage: errorMessage ?? this.errorMessage);
}
