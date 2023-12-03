import 'package:country_code_picker/country_code_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../data/services/session_service.dart';
import '../../../repository/auth_repo/auth_repo.dart';
import '../../../services/auth/verify_phone_response.dart';
import '../../../services/utility_service.dart';
import '../../../utils/locator.dart';


part 'signup_mobile_cubit.freezed.dart';
part 'signup_mobile_state.dart';

class SignupMobileCubit extends Cubit<SignUpMobileState> {
  SignupMobileCubit(this.authRepo) : super(SignUpMobileState.initial()) {
    phone = TextEditingController();
  }
  // SignUpMobileCubit() : super(SignUpMobileState.initial());
  final AuthRepo authRepo;
  String? verificationId;
  int? resendToken;
  late TextEditingController phone;

  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  UserCredential? credential;

  void setCountryCode(CountryCode countryCode) {
    emit(state.copyWith.call(countryCode: countryCode.dialCode!));
  }

  Future<void> continueWithPhone(BuildContext context) async {
    final isValid = formKey.currentState!.validate();
    if (!isValid) {
      return;
    }
    // loader.showLoader(context, message: "Sending OTP");
    emit(state.copyWith.call(estate: EVerifyMobileState.sendingOtp));

    /// Make sure to replace `+1` with your country code
    final no = '${state.countryCode}${phone.text}';

    /// Starts a phone number verification process for the given phone number
    await authRepo.verifyPhoneNumber(
      no,
      onResponse: (response) => verifyPhoneNumberListener(context, response),
    );
  }

  /// Listener for mobile verification response
  void verifyPhoneNumberListener(
    BuildContext context,
    VerifyPhoneResponse data,
  ) {
    // loader.hideLoader();
    data.map(
      /// [verificationCompleted] Triggered when an SMS is auto-retrieved
      /// or the phone number has been instantly verified.
      /// The callback will receive an [PhoneAuthCredential]
      /// that can be passed to [signInWithCredential] or [linkWithCredential].
      verificationCompleted: (data) {
        UtilityService.cprint(
          '[verifyPhoneNumberListener] verification completed',
        );

        // emit(SignUpMobileCubit.response(EVerifyMobileState.OtpVerified,
        //     context.locale.verification_completed));
        emit(
          state.copyWith.call(
            estate: EVerifyMobileState.OtpVerified,
            message: 'Verification completed',
          ),
        );
      },

      /// [verificationFailed] Triggered when an error occurred
      ///  during phone number verification.
      /// A [FirebaseAuthException] is provided when this is triggered.
      verificationFailed: (data) {
        UtilityService.cprint('[verifyPhoneNumberListener] Failed');

        emit(
          state.copyWith.call(
            estate: EVerifyMobileState.VerificationFailed,
            message: 'Verification failed',
          ),
        );
      },

      /// Triggered when an SMS has been sent to the users phone,
      /// And will include a [verificationId] and [forceResendingToken].
      codeSent: (data) {
        verificationId = data.verificationId;
        resendToken = data.resendToken;
        UtilityService.cprint('[verifyPhoneNumberListener] Code sent');
        emit(
          state.copyWith.call(
            estate: EVerifyMobileState.OtpSent,
            message: 'OTP sent to phone',
          ),
        );
      },

      /// Triggered when SMS auto-retrieval times out
      /// and provide a [verificationId].
      codeAutoRetrievalTimeout: (data) {
        UtilityService.cprint('[verifyPhoneNumberListener] Timeout');

        // emit(
        //   state.copyWith.call(
        //     estate: EVerifyMobileState.Timeout,
        //     message: 'Timeout',
        //   ),
        // );
      },
    );
  }

  /// Verify otp
  Future<void> verifyOTP(BuildContext context, String smsCode) async {
    /// Display loader on screen while verifying Otp
    // loader.showLoader(context, message: context.locale.verifying);
    final user = await authRepo.verifyOTP(
      smsCode: smsCode,
      verificationId: verificationId!,
    );

    /// Hide loader
    // loader.hideLoader();
    await user.fold((l) {
      /// If otp verification failed
      emit(
        state.copyWith.call(
          estate: EVerifyMobileState.VerificationFailed,
          message: UtilityService.encodeStateMessage(l),
        ),
      );
    }, (r) async {
      /// If otp verification success
      credential = r;
      getIt<Session>().setUserCredential(r);
      emit(
        state.copyWith.call(
          estate: EVerifyMobileState.OtpVerified,
          message: 'OTP verified',
        ),
      );
    });
  }

  // Check is user is already registered with mobile number
  Future<void> checkMobileAvailability(BuildContext context) async {
    final response =
        await authRepo.checkMobileAvailability(credential!.user!.phoneNumber!);
    response.fold(
      (l) => emit(
        state.copyWith.call(
          estate: EVerifyMobileState.MobileAlreadyInUse,
          message: UtilityService.encodeStateMessage(l),
        ),
      ),
      (r) => emit(
        state.copyWith.call(
          message: 'Mobile available',
          credential: credential,
          estate: EVerifyMobileState.MobileNotRegistered,
        ),
      ),
    );
  }

  @override
  Future<void> close() {
    phone.dispose();
    return super.close();
  }
}
