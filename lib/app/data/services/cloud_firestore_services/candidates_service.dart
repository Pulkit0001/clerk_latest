import 'package:clerk/app/data/services/session_service.dart';
import 'package:clerk/app/utils/custom_exception_handler.dart';
import 'package:clerk/app/utils/enums/entity_status.dart';
import 'package:clerk/app/utils/extensions.dart';
import 'package:clerk/app/values/strings.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../models/candidate_data_model.dart';

class CandidatesService {
  final Session session;
  final FirebaseFirestore firestore;

  CandidatesService(this.session, this.firestore);

  Future<String> addCandidate({required Candidate candidateData}) async {
    try {
      var id = session.currentUser!.uid;
      CollectionReference candidates = firestore
          .collection(USERS_COLLECTION)
          .doc(id)
          .collection(CANDIDATES_COLLECTION);

      var res = await candidates.add(candidateData.toJson());
      var charges = [
        ...candidateData.extraCharges,
        ...candidateData.groupCharges
      ];
      WriteBatch writeBatch = firestore.batch();
      for (var e in charges) {
        writeBatch
            .set(candidates.doc(res.id).collection(CHARGES_COLLECTION).doc(), {
          'charge_id': e,
          'last_billed_at': null,
          'next_billing_date': Timestamp.now(),
          'status': EntityStatus.active.name,
          'is_extra': candidateData.extraCharges.contains(e)
        });
      }
      await writeBatch.commit();
      return res.id;
    } on Exception catch (e) {
      CustomExceptionHandler.handle(e);
      rethrow;
    }
  }

  Future<List<Candidate>> getCandidates({List<String>? candidatesId}) async {
    try {
      var id = session.currentUser!.uid;
      if(candidatesId != null && candidatesId.isEmpty){
        return <Candidate>[];
      }
      dynamic candidatesQuery = firestore
          .collection(USERS_COLLECTION)
          .doc(id)
          .collection(CANDIDATES_COLLECTION)
          .where('candidate_status', isEqualTo: 'active');

      if (candidatesId.isNotNullEmpty) {
        candidatesQuery = candidatesQuery.where(FieldPath.documentId, whereIn: candidatesId);
      }

      final res = (await candidatesQuery.get());
      Iterable<QueryDocumentSnapshot<Map<String, dynamic>>> candidateDocs =
          res.docs;

      List<Candidate> candidateList = [];
      for (var e in candidateDocs) {
        var charges = await e.reference
            .collection(CHARGES_COLLECTION)
            .where('status', isEqualTo: 'active')
            .get();
        var extraCharges = charges.docs
            .where((element) => element.data()['is_extra'])
            .map((e) => e.data()['charge_id'])
            .toList();
        var groupCharges = charges.docs
            .where((element) => !element.data()['is_extra'])
            .map((e) => e.data()['charge_id'])
            .toList();
        var x = e.data();
        x.addAll({
          "candidate_id": e.id,
          "extra_charges": extraCharges,
          "group_charges": groupCharges
        });
        candidateList.add(Candidate.fromJson(x));
      }

      return candidateList;
    } on Exception catch (e) {
      CustomExceptionHandler.handle(e);
      rethrow;
    }
  }

  Future<List<String>> searchCandidates({required String query}) async {
    try {
      var id = session.currentUser!.uid;
      final candidatesQuery = firestore
          .collection(USERS_COLLECTION)
          .doc(id)
          .collection(CANDIDATES_COLLECTION)
          .where(
            candidate_name_key,
          )
          .where('candidate_status', isEqualTo: 'active');

      final res = (await candidatesQuery.get());

      return res.docs.map((e) => e.id).toList();
    } on Exception catch (e) {
      CustomExceptionHandler.handle(e);
      rethrow;
    }
  }

  Future<bool> updateCandidate(Candidate candidate) async {
    try {
      var id = session.currentUser!.uid;
      var candidateDoc = firestore
          .collection(USERS_COLLECTION)
          .doc(id)
          .collection(CANDIDATES_COLLECTION)
          .doc(candidate.id);

      await candidateDoc.update(candidate.toJson());
      return true;
    } on Exception catch (e) {
      CustomExceptionHandler.handle(e);
      return false;
    }
  }

  Future<bool> applyCharges(String candidateId, List<String> charges,
      {bool isExtra = false}) async {
    try {
      var id = session.currentUser!.uid;
      var candidateDoc = firestore
          .collection(USERS_COLLECTION)
          .doc(id)
          .collection(CANDIDATES_COLLECTION)
          .doc(candidateId);

      WriteBatch writeBatch = firestore.batch();
      for (var e in charges) {
        writeBatch.set(candidateDoc.collection(CHARGES_COLLECTION).doc(), {
          'charge_id': e,
          'last_billed_at': null,
          'next_billing_date': Timestamp.now(),
          'status': EntityStatus.active.name,
          'is_extra': isExtra
        });
      }
      await writeBatch.commit();
      return true;
    } on Exception catch (e) {
      CustomExceptionHandler.handle(e);
      return false;
    }
  }

  Future<bool> removeCharges(
    String candidateId,
    List<String> charges,
  ) async {
    try {
      if(charges.isNotEmpty) {
        var id = session.currentUser!.uid;
        var chargeDocs = await firestore
            .collection(USERS_COLLECTION)
            .doc(id)
            .collection(CANDIDATES_COLLECTION)
            .doc(candidateId)
            .collection(CHARGES_COLLECTION)
            .where('charge_id', whereIn: charges)
            .get();

        WriteBatch writeBatch = firestore.batch();
        for (var e in chargeDocs.docs) {
          writeBatch.update(e.reference, {
            'status': EntityStatus.disabled.name,
          });
        }
        await writeBatch.commit();
      }
      return true;
    } on Exception catch (e) {
      CustomExceptionHandler.handle(e);
      return false;
    }
  }

  Future<bool> deleteCandidate(String candidateId) async {
    try {
      var id = session.currentUser!.uid;
      var candidateDoc = await firestore
          .collection(USERS_COLLECTION)
          .doc(id)
          .collection(CANDIDATES_COLLECTION)
          .doc(candidateId)
          .get();

      if (candidateDoc.exists) {
        await candidateDoc.reference.update({'candidate_status': 'disabled'});
      }
      return true;
    } on Exception catch (e) {
      CustomExceptionHandler.handle(e);
      return false;
    }
  }
}
