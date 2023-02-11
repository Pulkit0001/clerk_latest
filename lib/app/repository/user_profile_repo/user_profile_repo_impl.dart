import 'dart:io';

import 'package:clerk/app/data/services/cloud_firestore_services/user_profile_service.dart';
import 'package:clerk/app/data/services/storage_service/file_upload_task_response.dart';
import 'package:clerk/app/data/services/storage_service/firebase_storage_service.dart';
import 'package:clerk/app/repository/user_profile_repo/user_profile_repo.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../data/models/user_profile_data_model.dart';

class UserProfileRepoImpl extends UserProfileRepo {
  final UserProfileService profileService;
  final FirebaseStorageService storageService;

  UserProfileRepoImpl(this.profileService, this.storageService);

  @override
  Future<Either<String, String>> createUserProfile(
      {required UserProfile profile}) async {
    try {
      var res = await profileService.addUserProfile(userProfileData: profile);
      if (res.isNotEmpty) {
        return Left("Profile created successfully");
      }
      return Right("Profile not created");
    } catch (e) {
      return Right(e.toString());
    }
  }

  @override
  Future<Either<bool, String>> deleteUserProfile() async {
    try {
      var res = await profileService.deleteUserProfile();
      if (res) {
        return Left(true);
      }
      return Right("Profile not deleted");
    } catch (e) {
      return Right(e.toString());
    }
  }

  @override
  Future<Either<UserProfile, String>> getUserProfile() async {
    try {
      var res = await profileService.getUserProfile();
      return Left(res);
    } catch (e) {
      return Right(e.toString());
    }
  }

  @override
  Future<Either<bool, String>> updateBusinessContact(
      {required String contact}) async {
    try {
      var result = await profileService.getUserProfile();
      var x = result.copyWith(businessContact: contact);
      var res = await profileService.updateUserProfile(x);
      if (res) {
        return Left(res);
      } else {
        return Right('Profile not updated');
      }
    } catch (e) {
      return Right(e.toString());
    }
  }

  @override
  Future<Either<bool, String>> updateBusinessEmail(
      {required String email}) async {
    try {
      var result = await profileService.getUserProfile();
      var x = result.copyWith(businessEmail: email);
      var res = await profileService.updateUserProfile(x);
      if (res) {
        return Left(res);
      } else {
        return Right('Profile not updated');
      }
    } catch (e) {
      return Right(e.toString());
    }
  }

  @override
  Future<Either<bool, String>> updateUserProfile(
      {required UserProfile profile}) async {
    try {
      var res = await profileService.updateUserProfile(profile);
      if (res) {
        return Left(res);
      } else {
        return Right('Profile not updated');
      }
    } catch (e) {
      return Right(e.toString());
    }
  }

  @override
  Future<Either<String, String>> uploadFile(
      File file,
      {
        required void Function(FileUploadTaskResponse response) onFileUpload,
      }) async {
    return storageService.uploadFile(
      file,
      'users/${FirebaseAuth.instance.currentUser?.uid}/business_profile.${file.path.split(".")[1]}',
      onFileUpload: onFileUpload,
    );
  }
}
