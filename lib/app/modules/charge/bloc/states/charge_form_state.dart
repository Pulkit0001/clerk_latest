import 'package:clerk/app/data/models/charge_data_model.dart';
import 'package:clerk/app/utils/enums/view_state_enums.dart';

class ChargeFormState {
  final bool toCreate;
  final Charge charge;
  final CustomFormState formState;
  final String? errorMessage;
  final String? successMessage;
  final int formStep;

  ChargeFormState(
      {required this.toCreate,
      this.errorMessage,
      this.successMessage,
      required this.formStep,
      required this.charge,
      required this.formState});

  factory ChargeFormState.initial({Charge? charge}) => ChargeFormState(
      charge: charge ?? Charge.empty(),
      toCreate: charge == null,
      formState: CustomFormState.idle,
      formStep: 0);

  ChargeFormState copyWith({
    bool? toCreate,
    Charge? charge,
    CustomFormState? formState,
    String? errorMessage,
    String? successMessage,
    int? formStep,
  }) =>
      ChargeFormState(
        toCreate: toCreate ?? this.toCreate,
        formState: formState ?? this.formState,
        charge: charge ?? this.charge,
        successMessage: successMessage ?? this.successMessage,
        errorMessage: errorMessage ?? this.errorMessage,
        formStep: formStep ?? this.formStep,
      );
}
