


import '../../../../data/models/group_data_model.dart';
import '../../../../utils/enums/view_state_enums.dart';

class GroupFormState {
  final bool toCreate;
  final Group group;
  final CustomFormState formState;
  final String? errorMessage;
  final String? successMessage;
  final int formStep;

  GroupFormState(
      {required this.toCreate,
        this.errorMessage,
        this.successMessage,
        required this.formStep,
        required this.group,
        required this.formState});

  factory GroupFormState.initial({Group? group}) => GroupFormState(
      group: group ?? Group.empty(),
      toCreate: group == null,
      formState: CustomFormState.idle,
      formStep: 0);

  GroupFormState copyWith({
    bool? toCreate,
    Group? group,
    CustomFormState? formState,
    String? errorMessage,
    String? successMessage,
    int? formStep,
  }) =>
      GroupFormState(
        toCreate: toCreate ?? this.toCreate,
        formState: formState ?? this.formState,
        group: group ?? this.group,
        successMessage: successMessage ?? this.successMessage,
        errorMessage: errorMessage ?? this.errorMessage,
        formStep: formStep ?? this.formStep,
      );
}
