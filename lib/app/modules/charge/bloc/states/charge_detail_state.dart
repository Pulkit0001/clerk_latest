import 'package:clerk/app/data/models/charge_data_model.dart';
import 'package:clerk/app/utils/enums/view_state_enums.dart';

class ChargeDetailsState {
  final String chargeId;
  final String? errorMessage;
  final Charge? charge;
  final ViewState viewState;

  ChargeDetailsState(
      {required this.chargeId, this.errorMessage,this.charge, required this.viewState});

  factory ChargeDetailsState.initial({
    required String chargeId,
  }) =>
      ChargeDetailsState(chargeId: chargeId, viewState: ViewState.empty);

  ChargeDetailsState copyWith({
    String? chargeId,
    Charge? charge,
    ViewState? viewState,  String? errorMessage,
  }) =>
      ChargeDetailsState(
          chargeId: chargeId ?? this.chargeId,
          viewState: viewState ?? this.viewState,
          errorMessage:  errorMessage ?? this.errorMessage,
          charge: charge ?? this.charge);
}
