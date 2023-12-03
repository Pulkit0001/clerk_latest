import 'package:bloc/bloc.dart';
import 'package:clerk/app/data/models/user_profile_data_model.dart';
import 'package:clerk/app/repository/auth_repo/auth_repo.dart';
import 'package:clerk/app/repository/user_profile_repo/user_profile_repo.dart';
import 'package:clerk/app/utils/enums/profile_status.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../data/services/session_service.dart';
import '../../../services/utility_service.dart';
import '../../../utils/locator.dart';
part 'app_cubit.freezed.dart';
part 'app_cubit_state.dart';
part 'e_app_state.dart';

class AppCubit extends Cubit<AppState> {
  AppCubit(this.authRepo, this.profileRepo) : super(AppState.initial());

  late UserProfile user;
  final AuthRepo authRepo;

  final UserProfileRepo profileRepo;

  // ignore: avoid_void_async
  void checkAuthentication() async {
    final response = await authRepo.getFirebaseUser();
    await response.fold(
      (l) {
        emit(
          AppState(
            estate: EAppState.loggedOut,
            message: UtilityService.encodeStateMessage(l),
          ),
        );
      },
      (r) async {
        /// Fetch current user data from firebase
        await fetchUser().then((value) => null);
      },
    );
  }

  Future<void> fetchUser() async {
    final response = await profileRepo.getUserProfile();
    await response.fold((l) async {
      user = l;
      await getIt<Session>().saveUserProfile(l);
      emit(
        AppState(
          estate: user.profileStatus == ProfileStatus.completed
              ? EAppState.loggedIn
              : EAppState.pendingAccount,
          message: UtilityService.encodeStateMessage('Auto login Success'),
        ),
      );
    }, (r) {
      emit(
        state.copyWith.call(
          estate: EAppState.loggedOut,
          message: UtilityService.encodeStateMessage(r),
        ),
      );
    });
  }

  Future<void> logout() async {
    await authRepo.logout();
    await getIt<Session>().clearSession();
    emit(
      const AppState(
        estate: EAppState.loggedOut,
        message: 'Logged out from app',
      ),
    );
  }

  Future<void> deleteAccount() async {
    final response = await authRepo.getFirebaseUser();
    await response.fold(
      (l) {
        emit(
          AppState(
            estate: EAppState.loggedOut,
            message: UtilityService.encodeStateMessage(l),
          ),
        );
      },
      (r) async {
        // await getIt<ProfileRepo>().deleteProfile(r.uid);
        // await getIt<CRMRepo>().deleteAllConnections();
        // await getIt<FirebaseChatRoomService>().disableUser(r.uid);
        await logout();
      },
    );
  }
}
