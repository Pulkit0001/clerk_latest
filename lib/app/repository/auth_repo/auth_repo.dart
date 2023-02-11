import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../services/auth/verify_phone_response.dart';

abstract class AuthRepo {
  Future<void> verifyPhoneNumber(
    String phone, {
    required void Function(VerifyPhoneResponse response) onResponse,
  });

  Future<Either<String, UserCredential>> verifyOTP({
    required String verificationId,
    required String smsCode,
  });

  Future<Either<String, bool>> createUserAccount(dynamic model);
  Future<Either<String, bool>> checkMobileAvailability(String mobile);

  /// Fetch current firebase user
  Future<Either<String, User>> getFirebaseUser();
  Future<void> logout();
}
