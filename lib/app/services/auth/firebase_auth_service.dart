import 'package:clerk/app/services/auth/verify_phone_response.dart';
import 'package:clerk/app/utils/enums/profile_status.dart';
import 'package:clerk/app/values/strings.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseAuthService {
  FirebaseAuthService(this.auth, this.firestore);

  final FirebaseAuth auth;
  final FirebaseFirestore firestore;

  Stream<Option<User>> get authStateChanges {
    return auth.authStateChanges().map(
      (User? user) {
        if (user == null) {
          return none();
        } else {
          return some(user);
        }
      },
    );
  }

  /// Verify mobile no. with firebase
  ///
  /// `onResponse` is a callback to return response received from firebase sdk
  Future<void> verifyPhoneNumber(
    String phone, {
    int? resendToken,
    required void Function(VerifyPhoneResponse response) onResponse,
  }) async {
    await auth.verifyPhoneNumber(
      phoneNumber: phone,
      forceResendingToken: resendToken,
      verificationCompleted: (PhoneAuthCredential credential) {
        onResponse(VerifyPhoneResponse.verificationCompleted(credential));
      },
      verificationFailed: (FirebaseAuthException e) {
        onResponse(VerifyPhoneResponse.verificationFailed(e));
      },
      codeSent: (String verificationId, int? resendToken) {
        onResponse(VerifyPhoneResponse.codeSent(verificationId, resendToken));
      },
      codeAutoRetrievalTimeout: (String verificationId) {
        onResponse(
          VerifyPhoneResponse.codeAutoRetrievalTimeout(verificationId),
        );
      },
    );
  }

  /// Once OTP received on mobile, pass otp and verificationId to verify otp.
  /// If Otp is verified successfully then new user will created in firebase.
  /// Creating new user doesn't mean its data is saved in firebase firestore/realtime database.
  Future<Either<String, UserCredential>> verifyOTP({
    required String verificationId,
    required String smsCode,
  }) async {
    try {
      final credential = PhoneAuthProvider.credential(
        verificationId: verificationId,
        smsCode: smsCode,
      );
      // Sign the user in (or link) with the credential
      final userCredential = await auth
          .signInWithCredential(credential)
          .onError((FirebaseAuthException error, StackTrace stackTrace) {
        throw error;
      });

      return Right(userCredential);
    } on FirebaseAuthException catch (error) {
      return Left(error.message!);
    }
  }

  Future<Either<String, bool>> checkMobileAvailability(
    String phoneNumber,
  ) async {
    try {
      final query = await firestore
          .collection(USERS_COLLECTION).doc(
          FirebaseAuth.instance.currentUser!.uid).get();
      final data = query.get('profile_status');
      if (data.isNotEmpty && data == ProfileStatus.completed.name) {
        return Future.value(const Left('Mobile number already in use'));
      } else {
        return Future.value(const Right(true));
      }
    }catch(e){
      return Future.value(const Right(true));
    }
  }



  /// Save user profile in firebase firestore database
  /// Saving a profile means creating a new user
  Future<Either<String, bool>> createUserAccount(dynamic model) async {
    try {
      await firestore
          .collection('profile')
          .doc(model.id)
          .set(model.toJson());
      return Future.value(const Right(true));
    } on FirebaseAuthException catch (error) {
      return Left(error.message!);
    }
  }

  Future<Either<String, User>> getFirebaseUser() async {
    try {
      final user = auth.currentUser;
      if (user != null) {
        return Right(user);
      } else {
        return const Left('Not-Found');
      }
    } on FirebaseAuthException catch (error) {
      return Left(error.message!);
    }
  }

  Future<void> logout() async {
    await auth.signOut();
  }
}
