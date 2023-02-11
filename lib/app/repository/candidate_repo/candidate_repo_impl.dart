import 'dart:io';

import 'package:clerk/app/data/models/candidate_data_model.dart';
import 'package:clerk/app/data/services/cloud_firestore_services/candidates_service.dart';
import 'package:clerk/app/data/services/cloud_firestore_services/groups_service.dart';
import 'package:clerk/app/repository/candidate_repo/candidate_repo.dart';
import 'package:clerk/app/repository/group_repo/group_repo.dart';
import 'package:clerk/app/utils/locator.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../data/services/storage_service/file_upload_task_response.dart';
import '../../data/services/storage_service/firebase_storage_service.dart';

class CandidateRepoImpl extends CandidateRepo {
  final CandidatesService candidatesService;
  final GroupsService groupsService;
  final FirebaseStorageService storageService;

  CandidateRepoImpl(
      this.candidatesService, this.groupsService, this.storageService);

  @override
  Future<Either<String, String>> addCandidate(
      {required Candidate candidate}) async {
    try {
      var res = await candidatesService.addCandidate(candidateData: candidate);
      if (res.isNotEmpty) {
        var result = await getIt<GroupRepo>()
            .addCandidates(groupId: candidate.group, candidateIds: [res]);
        return await result.fold(
            (l) => l
                ? Left("Candidate added Successfully")
                : Right("Candidate not added"),
            (r) => Right(r));
      }
      return Right("Candidate not added");
    } catch (e) {
      return Right(e.toString());
    }
  }

  @override
  Future<Either<bool, String>> applyCharges(
      {required String candidateId,
      required List<String> chargeIds,
      bool isExtra = false}) async {
    try {
      await candidatesService.applyCharges(candidateId, chargeIds,
          isExtra: isExtra);
      return Left(true);
    } catch (e) {
      return Right(e.toString());
    }
  }

  @override
  Future<Either<bool, String>> changeGroup(
      {required String candidateId, required String groupId}) async {
    try {
      await getIt<GroupRepo>()
          .addCandidates(groupId: groupId, candidateIds: [candidateId]);

      var res =
          await candidatesService.getCandidates(candidatesId: [candidateId]);

      var candidateData = res.first;
      var newGroup = (await groupsService.getGroups(groupsId: [groupId])).first;
      var oldGroup =
          (await groupsService.getGroups(groupsId: [candidateData.group]))
              .first;

      await getIt<GroupRepo>().removeCandidates(
          groupId: candidateData.group, candidateIds: [candidateId]);

      await candidatesService
          .updateCandidate(candidateData.copyWith(group: groupId));

      await applyCharges(
          candidateId: candidateId,
          chargeIds: newGroup.charges,
          isExtra: false);

      await removeCharges(
          candidateId: candidateId, chargeIds: oldGroup.charges);
      return Left(true);
    } catch (e) {
      return Right(e.toString());
    }
  }

  @override
  Future<Either<bool, String>> deleteCandidate(
      {required String candidateId}) async {
    try {
      var res = await candidatesService.deleteCandidate(candidateId);
      return Left(res);
    } catch (e) {
      return Right(e.toString());
    }
  }

  @override
  Future<Either<List<Candidate>, String>> getAllCandidates(
      {List<String>? candidateIds}) async {
    try {
      var res =
          await candidatesService.getCandidates(candidatesId: candidateIds);
      return Left(res);
    } catch (e) {
      return Right(e.toString());
    }
  }

  @override
  Future<Either<bool, String>> removeCharges(
      {required String candidateId, required List<String> chargeIds}) async {
    try {
      await candidatesService.removeCharges(candidateId, chargeIds);
      return Left(true);
    } catch (e) {
      return Right(e.toString());
    }
  }

  @override
  Future<Either<bool, String>> updateCandidate(
      {required Candidate candidate}) async {
    try {
      var res = await candidatesService.updateCandidate(candidate);
      return Left(res);
    } catch (e) {
      return Right(e.toString());
    }
  }

  @override
  Future<Either<String, String>> uploadFile(
    File file, {
    required void Function(FileUploadTaskResponse response) onFileUpload,
  }) async {
    return storageService.uploadFile(
      file,
      'users/${FirebaseAuth.instance.currentUser?.uid}/candidates_profile',
      onFileUpload: onFileUpload,
    );
  }

  @override
  Future<Either<List<String>, String>> searchCandidates({required String searchQuery}) async {
    try {
      var res = await candidatesService.searchCandidates( query: searchQuery);
      return Left(res);
    } catch (e) {
      return Right(e.toString());
    }
  }
}
