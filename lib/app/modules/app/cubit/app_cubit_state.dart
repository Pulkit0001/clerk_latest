part of 'app_cubit.dart';

@freezed
class AppState with _$AppState {
  const factory AppState({
    required EAppState estate,
    required String message,
  }) = _AppState;

  factory AppState.initial() => const AppState(
        estate: EAppState.notDetermined,
        message: '',
      );
}
