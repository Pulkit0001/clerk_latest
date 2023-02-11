import 'package:clerk/app/utils/enums/view_state_enums.dart';

import '../../../../data/models/user_profile_data_model.dart';

class ProfileDetailState {
  final String? errorMessage;
  final UserProfile? userProfile;
  final ViewState viewState;

  ProfileDetailState({
    this.errorMessage,
    this.userProfile,
    required this.viewState,
  });

  factory ProfileDetailState.initial() => ProfileDetailState(
        viewState: ViewState.empty,
      );

  ProfileDetailState copyWith({
    UserProfile? userProfile,
    ViewState? viewState,
    String? errorMessage,
  }) =>
      ProfileDetailState(
        viewState: viewState ?? this.viewState,
        errorMessage: errorMessage ?? this.errorMessage,
        userProfile: userProfile ?? this.userProfile,
      );
}
