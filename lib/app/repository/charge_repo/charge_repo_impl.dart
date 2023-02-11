import 'package:clerk/app/data/models/charge_data_model.dart';
import 'package:clerk/app/data/services/cloud_firestore_services/charges_service.dart';
import 'package:clerk/app/repository/charge_repo/charge_repo.dart';
import 'package:dartz/dartz.dart';

import '../../data/services/cloud_firestore_services/candidates_service.dart';
import '../../data/services/cloud_firestore_services/groups_service.dart';

class ChargesRepoImpl extends ChargeRepo {
  final ChargesService chargesService;
  final GroupsService groupService;
  final CandidatesService candidatesService;

  ChargesRepoImpl(
      this.chargesService, this.groupService, this.candidatesService);
  @override
  Future<Either<String, String>> createCharge({required Charge charge}) async {
    try {
      var res = await chargesService.createCharge(chargeData: charge);
      return Left(res);
    } catch (e) {
      return Right(e.toString());
    }
  }

  @override
  Future<Either<bool, String>> deleteCharge({required String chargeId}) async {
    try {
      var res = await chargesService.deleteCharge(chargeId);
      return Left(res);
    } catch (e) {
      return Right(e.toString());
    }
  }

  @override
  Future<Either<List<Charge>, String>> getAllCharges(
      {required List<String>? chargeIds}) async {
    try {
      var res = await chargesService.getCharges(chargesId: chargeIds);
      return Left(res);
    } catch (e) {
      return Right(e.toString());
    }
  }

  @override
  Future<Either<List<Charge>, String>> getAllChargesOfCandidate(
      {required String candidateId}) async {
    try {
      var candidateData =
          (await candidatesService.getCandidates(candidatesId: [candidateId]))
              .first;
      var res =
          await chargesService.getCharges(chargesId: candidateData.extraCharges);
      return Left(res);
    } catch (e) {
      return Right(e.toString());
    }
  }

  @override
  Future<Either<List<Charge>, String>> getAllChargesOfGroup(
      {required String groupId}) async {
    try {
      var groupData = (await groupService.getGroups(groupsId: [groupId])).first;
      var res = await chargesService.getCharges(chargesId: groupData.charges);
      return Left(res);
    } catch (e) {
      return Right(e.toString());
    }
  }

  @override
  Future<Either<bool, String>> updateCharge({required Charge charge}) async {
    try {
      var res = await chargesService.updateCharge(charge);
      return Left(res);
    } catch (e) {
      return Right(e.toString());
    }
  }
}
