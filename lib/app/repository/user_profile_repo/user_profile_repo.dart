import 'dart:io';

import 'package:clerk/app/data/services/storage_service/file_upload_task_response.dart';
import 'package:dartz/dartz.dart';

import '../../data/models/user_profile_data_model.dart';




abstract class UserProfileRepo{

  Future<Either<UserProfile, String>> getUserProfile();

  Future<Either<String, String>> createUserProfile({required UserProfile profile});

  Future<Either<bool, String>> deleteUserProfile();

  Future<Either<bool, String>> updateUserProfile({required UserProfile profile});

  Future<Either<bool, String>> updateBusinessEmail({required String email});

  Future<Either<bool, String>> updateBusinessContact({required String contact});

  Future<Either<String, String>> uploadFile(
      File file,
      {
        required void Function(FileUploadTaskResponse response) onFileUpload,
      });
}