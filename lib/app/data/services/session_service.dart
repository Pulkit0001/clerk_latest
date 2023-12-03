import 'package:clerk/app/data/models/user_profile_data_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Session {
  UserCredential? userCredential;

  UserProfile? userProfile;
  User? currentUser;

  void setFirebaseUser(User user) {
    currentUser = user;
  }

  void setUserCredential(UserCredential userCredential) {
    this.userCredential = userCredential;
  }

  saveUserProfile(UserProfile userProfile) {
    this.userProfile = userProfile;
  }

  Future<void> clearSession() async {
    userCredential = null;
    currentUser = null;
  }
}
