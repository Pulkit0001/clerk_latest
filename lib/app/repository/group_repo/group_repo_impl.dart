import 'package:clerk/app/data/models/candidate_data_model.dart';
import 'package:clerk/app/data/models/charge_data_model.dart';
import 'package:clerk/app/data/models/group_data_model.dart';
import 'package:clerk/app/repository/group_repo/group_repo.dart';
import 'package:dartz/dartz.dart';

import '../../data/services/cloud_firestore_services/groups_service.dart';

class GroupRepoImpl extends GroupRepo {
  final GroupsService groupsService;

  GroupRepoImpl(this.groupsService);
  @override
  Future<Either<bool, String>> addCandidates(
      {required String groupId, required List<String> candidateIds}) async {
    try {
      var groupData = await groupsService.getGroups(groupsId: [groupId]);


    var candidates = groupData.first.candidates;
      candidates.addAll(candidateIds);

    var res =
    await groupsService.updateGroup(groupData.first.copyWith(candidates: candidates));
    return Left(res);
    } catch (e) {
    return Right(e.toString());
    }
  }

  @override
  Future<Either<bool, String>> applyCharges(
      {required String groupId, required List<String> chargeIds}) async {
    try {
      var groupData =
          (await groupsService.getGroups(groupsId: [groupId])).first;

      var charges = groupData.charges;
      charges.addAll(chargeIds);

      var res =
          await groupsService.updateGroup(groupData.copyWith(charges: charges));
      return Left(res);
    } catch (e) {
      return Right(e.toString());
    }
  }

  @override
  Future<Either<String, String>> createGroup({required Group group}) async {
    try {
      var res = await groupsService.createGroup(groupData: group);
      return Left(res);
    } catch (e) {
      return Right(e.toString());
    }
  }

  @override
  Future<Either<bool, String>> deleteGroup({required String groupId}) async {
    try {
      var res = await groupsService.deleteGroup(groupId);
      return Left(res);
    } catch (e) {
      return Right(e.toString());
    }
  }

  @override
  Future<Either<List<Group>, String>> getAllGroups(
      {List<String>? groupIds}) async {
    try {
      var res = await groupsService.getGroups(groupsId: groupIds);
      return Left(res);
    } catch (e) {
      return Right(e.toString());
    }
  }

  @override
  Future<Either<bool, String>> removeCandidates(
      {required String groupId, required List<String> candidateIds}) {
    // TODO: implement removeCandidates
    throw UnimplementedError();
  }

  @override
  Future<Either<bool, String>> removeCharges(
      {required String groupId, required List<String> chargeIds}) async {
    try {
      var groupData =
          (await groupsService.getGroups(groupsId: [groupId])).first;

      var charges = groupData.charges;
      charges.removeWhere((e) => chargeIds.contains(e));

      var res =
          await groupsService.updateGroup(groupData.copyWith(charges: charges));
      return Left(res);
    } catch (e) {
      return Right(e.toString());
    }
  }

  @override
  Future<Either<bool, String>> updateGroup({required Group group}) async {
    try {
      var res = await groupsService.updateGroup(group);
      return Left(res);
    } catch (e) {
      return Right(e.toString());
    }
  }

  @override
  Future<Either<List<Candidate>, String>> getCandidates({required String groupId}) {
    // TODO: implement getCandidates
    throw UnimplementedError();
  }

  @override
  Future<Either<List<Charge>, String>> getCharges({required String groupId}) {
    // TODO: implement getCharges
    throw UnimplementedError();
  }
}
