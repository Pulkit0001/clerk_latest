import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:file_picker/file_picker.dart';

class FileService {
  static Future<Option<File>> pickImage() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.image,
    );
    if (result != null) {
      final file = result.files.first;
      return some(File(file.path!));
    }
    return none();
  }

  static Future<Option<List<File>>> pickMultipleImage() async {
    final result = await FilePicker.platform
        .pickFiles(type: FileType.image, allowMultiple: true);
    if (result != null) {
      final files = <File>[];
      for (final file in result.files) {
        files.add(File(file.path!));
      }
      return some(files);
    }
    return none();
  }

  static Future<Option<List<File>>> pickMultipleFiles() async {
    final result = await FilePicker.platform
        .pickFiles(allowMultiple: true);
    if (result != null) {
      final files = <File>[];
      for (final file in result.files) {
        files.add(File(file.path!));
      }
      return some(files);
    }
    return none();
  }

  static Future<Option<File>> pickVideo() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.video,
    );
    if (result != null) {
      final file = result.files.first;
      return some(File(file.path!));
    }
    return none();
  }
}
