import 'package:clerk/app/utils/enums/view_state_enums.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../main.dart';
import '../../../../data/models/group_data_model.dart';
import '../../../../repository/group_repo/group_repo.dart';
import '../../../../utils/enums/entity_status.dart';
import '../states/group_form_state.dart';

class GroupsFormCubit extends Cubit<GroupFormState> {
  GroupsFormCubit({required this.repo, Group? group})
      : super(GroupFormState.initial(group: group)) {
    if (group == null) {
      toCreate = true;
    } else {
      toCreate = false;
    }
  }

  final TextEditingController nameController = TextEditingController();
  final TextEditingController startTimeController = TextEditingController();
  final TextEditingController endTimeController = TextEditingController();

  final GlobalKey<FormState> generalFormState = GlobalKey<FormState>();

  final GroupRepo repo;

  late bool toCreate;

  void changeFormStep(int index) {
    emit(state.copyWith(formStep: index));
  }

  void removeCharge(String value) {
    var charges = <String>[];
    charges.addAll(state.group.charges);
    charges.remove(value);
    emit(
      state.copyWith(
        group: state.group.copyWith(
          charges: charges,
        ),
      ),
    );
  }

  void addCharge(String value) {
    var charges = <String>[];
    charges.addAll(state.group.charges);
    charges.add(value);
    emit(
      state.copyWith(
        group: state.group.copyWith(
          charges: charges,
        ),
      ),
    );
  }

  bool validateForm() {
    if (toCreate) {
      if (state.formState == CustomFormState.idle && state.formStep == 0) {
        return generalFormState.currentState!.validate();
      }
      if (state.formState == CustomFormState.idle && state.formStep == 1) {
        return true;
      } else {
        return false;
      }
    } else if (state.formState == CustomFormState.idle) {
      return generalFormState.currentState!.validate();
    } else {
      return false;
    }
  }

  void createGroup() async {
    emit(state.copyWith(formState: CustomFormState.uploading));

    Group group;

    group = state.group.copyWith(
        name: nameController.text,
        startTime: startTimeController.text,
        endTime: endTimeController.text,
        status: EntityStatus.active
    );

    var res = await repo.createGroup(group: group);

    res.fold(
      (l) {
        emit(state.copyWith(
            formState: CustomFormState.success, successMessage: l));
        navigatorKey.currentState?.pop();
      },
      (r) {
        emit(state.copyWith(formState: CustomFormState.idle, errorMessage: r));
      },
    );
  }
}
