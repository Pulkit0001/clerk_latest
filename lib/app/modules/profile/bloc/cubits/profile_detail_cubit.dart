import 'package:clerk/app/data/services/session_service.dart';
import 'package:clerk/app/utils/enums/view_state_enums.dart';
import 'package:clerk/app/utils/locator.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../repository/user_profile_repo/user_profile_repo.dart';
import '../states/profile_detail_state.dart';

class UserProfileDetailsCubit extends Cubit<ProfileDetailState> {
  UserProfileDetailsCubit({
    required this.repo,
  }) : super(ProfileDetailState.initial()) {
    if (getIt<Session>().userProfile != null) {
      emit(state.copyWith(
          userProfile: getIt<Session>().userProfile!,
          viewState: ViewState.idle));
    } else {
      loadUserProfile();
    }
  }

  final UserProfileRepo repo;

  loadUserProfile() async {
    try {
      emit(state.copyWith(viewState: ViewState.loading));
      var res = await repo.getUserProfile();
      res.fold((l) {
        emit(state.copyWith(userProfile: l, viewState: ViewState.idle));
      }, (r) {
        emit(state.copyWith(errorMessage: r, viewState: ViewState.error));
      });
    } catch (e) {
      emit(state.copyWith(
          viewState: ViewState.error, errorMessage: e.toString()));
    }
  }
}
