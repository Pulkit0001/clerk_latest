import 'package:clerk/app/repository/auth_repo/auth_repo.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../data/services/session_service.dart';
import '../../services/auth/firebase_auth_service.dart';
import '../../services/auth/verify_phone_response.dart';
import '../../utils/locator.dart';

class AuthRepoImpl implements AuthRepo {
  AuthRepoImpl(this.authService, this.session);
  final FirebaseAuthService authService;
  final Session session;

  @override
  Future<void> verifyPhoneNumber(
    String phone, {
    required void Function(VerifyPhoneResponse response) onResponse,
    int? resendToken,
  }) {
    return authService.verifyPhoneNumber(
      phone,
      onResponse: onResponse,
      resendToken: resendToken,
    );
  }

  @override
  Future<Either<String, UserCredential>> verifyOTP({
    required String verificationId,
    required String smsCode,
  }) {
    return authService.verifyOTP(
      verificationId: verificationId,
      smsCode: smsCode,
    );
  }

  @override
  Future<Either<String, bool>> checkMobileAvailability(String mobile) {
    return authService.checkMobileAvailability(mobile);
  }

  @override
  Future<Either<String, bool>> createUserAccount(dynamic model) async {
    final response = await authService.createUserAccount(model);
    return response.fold(Left.new, (r) async {
      // await getIt<Session>().saveUserProfile(model);
      return Right(r);
    });
  }

  @override
  Future<Either<String, User>> getFirebaseUser() async {
    final response = await authService.getFirebaseUser();
    return response.fold(Left.new, (r) async {
      session.setFirebaseUser(r);
      return Right(r);
    });
  }

  @override
  Future<void> logout() async {
    return authService.logout();
  }

  @override
  Future<UserCredential> signInViaEmail(String email, String password) {
    // TODO: implement signInViaEmail
    throw UnimplementedError();
  }

  @override
  Future<UserCredential> signInWithGoogle() {
    // TODO: implement signInWithGoogle
    throw UnimplementedError();
  }

  @override
  Future<UserCredential> signUpViaEmail(String email, String password) {
    // TODO: implement signUpViaEmail
    throw UnimplementedError();
  }
}
