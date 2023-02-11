part of 'signup_mobile_cubit.dart';

@freezed
class SignUpMobileState with _$SignUpMobileState {
  const factory SignUpMobileState({
    required EVerifyMobileState estate,
    required String message,
    required String countryCode,
    UserCredential? credential,
  }) = _SignUpMobileState;

  factory SignUpMobileState.initial() => const SignUpMobileState(
        message: '',
        estate: EVerifyMobileState.initial,
        countryCode: '+91',
      );
}

enum EVerifyMobileState {
  initial,
  sendingOtp,
  // ignore: constant_identifier_names
  OtpSent,
  // ignore: constant_identifier_names
  OtpVerifying,
  // ignore: constant_identifier_names
  OtpVerified,
  // ignore: constant_identifier_names
  Loading,
  // ignore: constant_identifier_names
  VerificationFailed,
  // ignore: constant_identifier_names
  MobileAlreadyInUse,
  // ignore: constant_identifier_names
  Other,
  // ignore: constant_identifier_names
  Timeout,
  // ignore: constant_identifier_names
  Created,

  // ignore: constant_identifier_names
  MobileNotRegistered,
}
