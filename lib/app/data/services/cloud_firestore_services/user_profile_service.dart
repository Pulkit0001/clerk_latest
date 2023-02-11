import 'package:clerk/app/data/services/session_service.dart';
import 'package:clerk/app/utils/custom_exception_handler.dart';
import 'package:clerk/app/values/strings.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../models/user_profile_data_model.dart';

class UserProfileService {
  final Session session;
  final FirebaseFirestore firestore;

  UserProfileService(this.session, this.firestore);

  Future<String> addUserProfile({required UserProfile userProfileData}) async {
    try {
      var id = session.currentUser!.uid;
      DocumentReference userProfile =
          firestore.collection(USERS_COLLECTION).doc(id);
      await userProfile.set(userProfileData.toJson());
      return id;
    } on Exception catch (e) {
      CustomExceptionHandler.handle(e);
      rethrow;
    }
  }

  Future<UserProfile> getUserProfile() async {
    try {
      var id = session.currentUser!.uid;
      final userProfile = firestore.collection(USERS_COLLECTION).doc(id);
      DocumentSnapshot<Map<String, dynamic>> userProfileDoc;
      userProfileDoc = await userProfile.get();
      var x = userProfileDoc.data();
      x?.addAll({"user_id": userProfileDoc.id});
      return UserProfile.fromJson(x!);
    } on Exception catch (e) {
      CustomExceptionHandler.handle(e);
      rethrow;
    }
  }

  Future<bool> updateUserProfile(UserProfile userProfile) async {
    try {
      var id = session.currentUser!.uid;
      var userProfileDoc =
          await firestore.collection(USERS_COLLECTION).doc(id).get();

      if (userProfileDoc.exists) {
        await userProfileDoc.reference.update(userProfile.toJson());
      }
      return true;
    } on Exception catch (e) {
      CustomExceptionHandler.handle(e);
      return false;
    }
  }

  Future<bool> deleteUserProfile() async {
    try {
      var id = session.currentUser!.uid;
      var userProfileDoc =
          await firestore.collection(USERS_COLLECTION).doc(id).get();

      if (userProfileDoc.exists) {
        await userProfileDoc.reference.update({'user_status': 'disabled'});
      }
      return true;
    } on Exception catch (e) {
      CustomExceptionHandler.handle(e);
      return false;
    }
  }
}
