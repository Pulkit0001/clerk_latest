import '../../../../data/models/user_profile_data_model.dart';
import '../../../../utils/enums/view_state_enums.dart';

class UserProfileFormState {

  final bool toCreate;
  final UserProfile userProfile;
  final CustomFormState formState;
  final String? errorMessage;
  final String? successMessage;
  final int formStep;

  UserProfileFormState({
    required this.toCreate,
    this.errorMessage,
    this.successMessage,
    required this.formStep,
    required this.userProfile,
    required this.formState,
  });

  factory UserProfileFormState.initial({UserProfile? userProfile, required int initialStep}) =>
      UserProfileFormState(
          userProfile: userProfile ?? UserProfile.empty(),
          toCreate: userProfile == null,
          formState: CustomFormState.idle,
          formStep: initialStep);

  UserProfileFormState copyWith({
    bool? toCreate,
    UserProfile? userProfile,
    CustomFormState? formState,
    String? errorMessage,
    String? successMessage,
    int? formStep,
  }) =>
      UserProfileFormState(
        toCreate: toCreate ?? this.toCreate,
        formState: formState ?? this.formState,
        userProfile: userProfile ?? this.userProfile,
        successMessage: successMessage ?? this.successMessage,
        errorMessage: errorMessage ?? this.errorMessage,
        formStep: formStep ?? this.formStep,
      );
}
