import 'package:clerk/app/data/models/candidate_data_model.dart';
import 'package:dartz/dartz.dart';

import '../../data/models/charge_data_model.dart';
import '../../data/models/group_data_model.dart';

abstract class GroupRepo {

  Future<Either<List<Group>, String>> getAllGroups({List<String>? groupIds});

  Future<Either<String, String>> getCurrentGroup();

  Future<Either<List<Candidate>, String>> getCandidates({ required String groupId});

  Future<Either<List<Charge>, String>> getCharges({ required String groupId});

  Future<Either<String, String>> createGroup({required Group group});

  Future<Either<bool, String>> deleteGroup({required String groupId});

  Future<Either<bool, String>> updateGroup({required Group group});

  /// should only use [addCandidates] method with those [candidateIds] which don't have any groups assigned.
  Future<Either<bool, String>> addCandidates(
      {required String groupId, required List<String> candidateIds});

  /// should only use [removeCandidates] method with those [candidateIds] which don't have any groups assigned.
  Future<Either<bool, String>> removeCandidates(
      {required String groupId, required List<String> candidateIds});

  Future<Either<bool, String>> applyCharges(
      {required String groupId, required List<String> chargeIds});

  Future<Either<bool, String>> removeCharges(
      {required String groupId, required List<String> chargeIds});
}
