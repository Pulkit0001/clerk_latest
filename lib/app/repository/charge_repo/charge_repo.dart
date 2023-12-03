import 'package:clerk/app/utils/enums/payment_interval_enums.dart';
import 'package:clerk/app/utils/enums/payment_type.dart';
import 'package:dartz/dartz.dart';

import 'package:clerk/app/data/models/charge_data_model.dart';

abstract class ChargeRepo {
  Future<Either<List<Charge>, String>> getAllCharges(
      {required List<String>? chargeIds,
      List<String>? excludeCharges,
      PaymentType? type,
      PaymentInterval? interval});

  Future<Either<List<Charge>, String>> getAllChargesOfGroup(
      {required String groupId});

  Future<Either<List<Charge>, String>> getAllChargesOfCandidate(
      {required String candidateId});

  Future<Either<String, String>> createCharge({required Charge charge});

  Future<Either<bool, String>> deleteCharge({required String chargeId});

  Future<Either<bool, String>> updateCharge({required Charge charge});
}
