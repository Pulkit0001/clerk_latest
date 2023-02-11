import 'package:clerk/app/data/models/charge_data_model.dart';
import 'package:clerk/app/utils/enums/view_state_enums.dart';

class ChargesListState {
  final List<Charge> charges;
  final String? errorMessage;
  final ViewState viewState;

  ChargesListState({
    required this.charges,
    required this.viewState,
    this.errorMessage,
  });

  factory ChargesListState.initial() =>
      ChargesListState(charges: [], viewState: ViewState.empty);

  ChargesListState copyWith({
    List<Charge>? charges,
    String? errorMessage,
    ViewState? viewState,
  }) =>
      ChargesListState(
          charges: charges ?? this.charges,
          viewState: viewState ?? this.viewState,
          errorMessage: errorMessage ?? this.errorMessage);
}
