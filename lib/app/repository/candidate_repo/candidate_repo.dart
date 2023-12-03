import 'dart:io';

import 'package:dartz/dartz.dart';

import '../../data/models/candidate_data_model.dart';
import '../../data/services/storage_service/file_upload_task_response.dart';

abstract class CandidateRepo {
  Future<Either<List<Candidate>, String>> getAllCandidates(
      {List<String>? candidateIds});

  Future<Either<List<String>, String>> searchCandidates(
      {required String searchQuery});

  Future<Either<String, String>> addCandidate({required Candidate candidate});

  Future<Either<bool, String>> deleteCandidate({required String candidateId});

  Future<Either<bool, String>> updateCandidate({required Candidate candidate});

  Future<Either<bool, String>> changeGroup(
      {required String candidateId, required String groupId});

  Future<Either<bool, String>> applyCharges(
      {required String candidateId, required List<String> chargeIds});

  Future<Either<bool, String>> removeCharges(
      {required String candidateId, required List<String> chargeIds});

  Future<Either<String, String>> uploadFile(
    File file, {
    required void Function(FileUploadTaskResponse response) onFileUpload,
  });

  Future<Either<bool, String>> updateExtraCharges(
      {required String candidateId, required List<String> extraCharges, required List<String> oldExtraCharges});
}
