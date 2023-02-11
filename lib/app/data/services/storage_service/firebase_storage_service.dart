import 'dart:io';

import 'package:clerk/app/utils/extensions.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import '../../../services/utility_service.dart';
import 'file_upload_task_response.dart';

class FirebaseStorageService {
  FirebaseStorageService(this.storage);
  final firebase_storage.FirebaseStorage storage;

  Future<Either<String, String>> uploadFile(
    File file,
    String uploadPath, {
    required void Function(FileUploadTaskResponse response) onFileUpload,
  }) async {
    // We can still optionally use the Future alongside the stream.
    try {
      final ref = storage.ref(uploadPath);
      final task = ref.putFile(file);
      task.snapshotEvents.listen(
        (firebase_storage.TaskSnapshot snapshot) {
          onFileUpload(FileUploadTaskResponse.snapshot(snapshot));
        },
        onError: (e) {
          UtilityService.cprint('onError', error: task.snapshot);
          if (e.code == 'permission-denied') {
            UtilityService.cprint(
              'User does not have permission to upload to this reference.',
            );
            onFileUpload(
              const FileUploadTaskResponse.onError('permission-denied'),
            );
          }
        },
      );
      await task;
      final filePath = await ref.getDownloadURL();
      UtilityService.cprint('Upload complete.');
      return Left(filePath);
    } on FirebaseException catch (e) {
      if (e.code == 'permission-denied') {
        UtilityService.cprint(
          'User does not have permission to upload to this reference.',
        );
      }
      onFileUpload(FileUploadTaskResponse.onError(e.code));
      return Right(e.code);
    }
  }

  Future<void> deletePostFiles(List<String>? list) async {
    if (list.notNullAndEmpty) {
      for (final path in list!) {
        final photoRef = storage.refFromURL(path);
        UtilityService.cprint('[Path]$path');
        try {
          await photoRef.delete();
        } catch (e) {
          UtilityService.cprint('[deletePostFiles]', error: e);
        }
      }
    }
  }
}
