import 'package:clerk/app/data/models/charge_data_model.dart';
import 'package:clerk/app/data/services/session_service.dart';
import 'package:clerk/app/utils/custom_exception_handler.dart';
import 'package:clerk/app/utils/enums/payment_interval_enums.dart';
import 'package:clerk/app/utils/enums/payment_type.dart';
import 'package:clerk/app/utils/extensions.dart';
import 'package:clerk/app/values/strings.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChargesService {
  final Session session;
  final FirebaseFirestore firestore;

  ChargesService(this.session, this.firestore);

  Future<String> createCharge({required Charge chargeData}) async {
    try {
      var id = session.currentUser!.uid;
      CollectionReference charges = firestore
          .collection(USERS_COLLECTION)
          .doc(id)
          .collection(CHARGES_COLLECTION);

      var res = await charges.add(chargeData.toJson());
      return res.id;
    } on Exception catch (e) {
      CustomExceptionHandler.handle(e);
      rethrow;
    }
  }

  Future<List<Charge>> getCharges(
      {List<String>? chargesId,
      List<String>? excludeCharges,
      PaymentType? type,
      PaymentInterval? interval}) async {
    try {
      var id = session.currentUser!.uid;
      final charges = firestore
          .collection(USERS_COLLECTION)
          .doc(id)
          .collection(CHARGES_COLLECTION);

      Iterable<QueryDocumentSnapshot<Map<String, dynamic>>> chargeDocs;

      var chargesQuery = charges.where('charge_status', isEqualTo: 'active');
      if (chargesId.isNotNullEmpty) {
        chargesQuery =
            chargesQuery.where(FieldPath.documentId, whereIn: chargesId);
      }
      if (type != null) {
        chargesQuery =
            chargesQuery.where('charge_payment_type', isEqualTo: type.name);
      }
      if (interval != null) {
        chargesQuery =
            chargesQuery.where('charge_interval', isEqualTo: interval.name);
      }
      if (excludeCharges.isNotNullEmpty) {
        chargesQuery = chargesQuery.where(FieldPath.documentId,
            whereNotIn: excludeCharges ?? []);
      }
      chargeDocs = (await chargesQuery.get()).docs;
      List<Charge> chargeList = chargeDocs.map((e) {
        var x = e.data();
        x.addAll({"charge_id": e.id});
        return Charge.fromJson(x);
      }).toList();
      return chargeList;
    } on Exception catch (e) {
      CustomExceptionHandler.handle(e);
      rethrow;
    }
  }

  Future<bool> updateCharge(Charge charge) async {
    try {
      var id = session.currentUser!.uid;
      var chargeDoc = await firestore
          .collection(USERS_COLLECTION)
          .doc(id)
          .collection(CHARGES_COLLECTION)
          .doc(charge.id)
          .get();

      if (chargeDoc.exists) {
        await chargeDoc.reference.update(charge.toJson());
      }
      return true;
    } on Exception catch (e) {
      CustomExceptionHandler.handle(e);
      return false;
    }
  }

  Future<bool> deleteCharge(String chargeId) async {
    try {
      var id = session.currentUser!.uid;
      var chargeDoc = await firestore
          .collection(USERS_COLLECTION)
          .doc(id)
          .collection(CHARGES_COLLECTION)
          .doc(chargeId)
          .get();

      if (chargeDoc.exists) {
        await chargeDoc.reference.update({'charge_status': 'disabled'});
      }
      return true;
    } on Exception catch (e) {
      CustomExceptionHandler.handle(e);
      return false;
    }
  }
}
