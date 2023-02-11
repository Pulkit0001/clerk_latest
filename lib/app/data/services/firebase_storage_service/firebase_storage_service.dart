import 'dart:io';

import 'package:clerk/app/utils/custom_exception_handler.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

abstract class StorageRepo {
  static final FirebaseStorage _storage = FirebaseStorage.instance;

  static Future<void> updateCandidateImage(String candidateId, File imageFile) async {
    try {
      Reference root = _storage.ref();
      String userId = FirebaseAuth.instance.currentUser!.uid;
      Reference candidateImageRef =
          root.child("$userId/$candidateId.${imageFile.path.split(".")[1]}");

      await candidateImageRef.putFile(imageFile);
    } on FirebaseException catch (e) {
      CustomExceptionHandler.handle(e);
    }
  }

  getCandidateImage() {

  }
}
