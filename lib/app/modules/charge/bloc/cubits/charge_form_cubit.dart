import 'package:clerk/app/data/models/charge_data_model.dart';
import 'package:clerk/app/modules/charge/bloc/states/charge_form_state.dart';
import 'package:clerk/app/utils/enums/payment_type.dart';
import 'package:clerk/app/utils/enums/view_state_enums.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../main.dart';
import '../../../../repository/charge_repo/charge_repo.dart';
import '../../../../utils/enums/entity_status.dart';
import '../../../../utils/enums/payment_interval_enums.dart';

class ChargesFormCubit extends Cubit<ChargeFormState> {
  ChargesFormCubit({required this.repo, Charge? charge})
      : super(ChargeFormState.initial(charge: charge)) {
    if (charge != null) {
      toCreate = false;
      timeValue = 16.666666 * (charge.interval.index - 1);
      if(timeValue < 0){
        timeValue = 0;
      }
      nameController = TextEditingController(text: charge.name);
      descController = TextEditingController(text: charge.description);
      amountController = TextEditingController(text: charge.amount.toString());
    } else {
      toCreate = true;
      nameController = TextEditingController();
      descController = TextEditingController();
      amountController = TextEditingController();
    }
  }

  late final TextEditingController nameController;
  late final TextEditingController descController;
  late final TextEditingController amountController;

  final GlobalKey<FormState> pricingFormState = GlobalKey<FormState>();
  final GlobalKey<FormState> generalFormState = GlobalKey<FormState>();

  final ChargeRepo repo;
  double timeValue = 0.0;

  late bool toCreate;

  void changeFormStep(int index) {
    emit(state.copyWith(formStep: index));
  }

  bool validateForm() {
    if (toCreate) {
      if (state.formState == CustomFormState.idle && state.formStep == 0) {
        return generalFormState.currentState!.validate();
      } else if (state.formState == CustomFormState.idle &&
          state.formStep == 1) {
        return pricingFormState.currentState!.validate();
      } else {
        return false;
      }
    } else if (state.formState == CustomFormState.idle) {
      return generalFormState.currentState!.validate() &&
          pricingFormState.currentState!.validate();
    } else {
      return false;
    }
  }

  void setPaymentType(PaymentType value) {
    emit(state.copyWith(charge: state.charge.copyWith(paymentType: value)));
  }

  void setPaymentInterval(PaymentInterval interval) {
    emit(state.copyWith(charge: state.charge.copyWith(interval: interval)));
  }

  void createCharge() async {
    emit(state.copyWith(formState: CustomFormState.uploading));

    Charge charge = state.charge.copyWith(
        name: nameController.text.trim(),
        description: descController.text.trim(),
        amount: num.parse(amountController.text.trim()),
        status: EntityStatus.active);
    var res = await repo.createCharge(charge: charge);

    res.fold(
      (l) {
        emit(state.copyWith(
            formState: CustomFormState.success, successMessage: l));
        navigatorKey.currentState?.pop();
      },
      (r) {
        emit(state.copyWith(formState: CustomFormState.error, errorMessage: r));
      },
    );
  }

  void updateCharge() async {
    emit(state.copyWith(formState: CustomFormState.uploading));

    Charge charge = state.charge.copyWith(
        name: nameController.text.trim(),
        description: descController.text.trim(),
        amount: num.parse(amountController.text.trim()),
        status: EntityStatus.active);
    var res = await repo.updateCharge(charge: charge);

    res.fold(
      (l) {
        emit(state.copyWith(
            formState: CustomFormState.success, successMessage: "Charge updated successfully."));
        navigatorKey.currentState?.pop();
      },
      (r) {
        emit(state.copyWith(formState: CustomFormState.error, errorMessage: r));
      },
    );
  }
}
