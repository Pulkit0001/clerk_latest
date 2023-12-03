import 'package:clerk/app/data/models/invoice_data_model.dart';
import 'package:clerk/app/data/services/session_service.dart';
import 'package:clerk/app/utils/custom_exception_handler.dart';
import 'package:clerk/app/utils/enums/invoice_status.dart';
import 'package:clerk/app/utils/extensions.dart';
import 'package:clerk/app/values/strings.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';

class InvoiceService {
  final Session session;
  final FirebaseFirestore firestore;
  final FirebaseFunctions functions;

  InvoiceService(this.session, this.firestore, this.functions);

  Future<String> createInvoice({required String candidateId}) async {
    try {
      HttpsCallable callable = functions.httpsCallable(
        'generateInvoiceForCandidate',
      );
      final result = await callable.call(
          {'candidate_id': candidateId, 'user_id': session.currentUser!.uid});
      if (result.data['status']) {
        return 'Invoice Generated Successfully';
      } else {
        throw Exception("Server Error");
      }
    } on Exception catch (e) {
      CustomExceptionHandler.handle(e);
      rethrow;
    }
  }

  Future<List<Invoice>> getInvoices(
      {List<String>? candidateIds, InvoiceStatus? status}) async {
    try {
      if (candidateIds != null && candidateIds.isEmpty) {
        return <Invoice>[];
      }
      var id = session.currentUser!.uid;
      dynamic invoicesQuery = firestore
          .collection(USERS_COLLECTION)
          .doc(id)
          .collection(INVOICES_COLLECTION);

      final candidatesQuery = firestore
          .collection(USERS_COLLECTION)
          .doc(id)
          .collection(CANDIDATES_COLLECTION);

      if (status != null) {
        invoicesQuery =
            invoicesQuery.where('invoiceStatus', isEqualTo: status.name);
      }
      if (candidateIds.isNotNullEmpty) {
        invoicesQuery = invoicesQuery.where('payerId', whereIn: candidateIds);
      }
      var res = await invoicesQuery.get();
      var invoiceDocs = res.docs;

      List<Invoice> invoiceList = [];

      for (var e in invoiceDocs) {
        var x = e.data();
        x.addAll({"id": e.id});
        if (x['payerId'] != null) {
          var candidate = await candidatesQuery.doc(x['payerId']).get();
          x.addAll({
            "candidate": {...?candidate.data(), 'candidate_id': x['payerId']}
          });
        }
        invoiceList.add(Invoice.fromJson(x));
      }

      return invoiceList;
    } catch (e) {
      CustomExceptionHandler.handle(e as Exception);
      rethrow;
    }
  }

  Future<Invoice> getInvoiceById({required String invoiceId}) async {
    try {
      var id = session.currentUser!.uid;
      final invoicesQuery = firestore
          .collection(USERS_COLLECTION)
          .doc(id)
          .collection(INVOICES_COLLECTION)
          .doc(invoiceId);

      var invoiceDoc = await invoicesQuery.get();

      if (invoiceDoc.exists) {
        var x = invoiceDoc.data()!;
        x.addAll({"id": invoiceDoc.id});
        return Invoice.fromJson(x);
      } else {
        throw Exception("Invoice not Found");
      }
    } on Exception catch (e) {
      CustomExceptionHandler.handle(e);
      rethrow;
    }
  }

  Future<bool> updateInvoice(Invoice invoice) async {
    try {
      var id = session.currentUser!.uid;
      var invoiceRef = firestore
          .collection(USERS_COLLECTION)
          .doc(id)
          .collection(INVOICES_COLLECTION)
          .doc(invoice.id);
      await invoiceRef.update(invoice.toJson());
      return true;
    } on Exception catch (e) {
      CustomExceptionHandler.handle(e);
      return false;
    }
  }

  Future<num> getTotalSum(
      {List<String>? candidateIds, InvoiceStatus? status}) async {
    try {
      var id = session.currentUser!.uid;
      dynamic invoicesQuery = firestore
          .collection(USERS_COLLECTION)
          .doc(id)
          .collection(INVOICES_COLLECTION);

      if (status != null) {
        invoicesQuery =
            invoicesQuery.where('invoiceStatus', isEqualTo: status.name);
      }
      if (candidateIds.isNotNullEmpty) {
        invoicesQuery = invoicesQuery.where('payerId', whereIn: candidateIds);
      }
      var res = await invoicesQuery.get();
      var invoiceDocs = res.docs;

      num sum = 0;
      invoiceDocs.map((e) {
        sum = sum + (e['totalAmount'] as num);
      }).toList();
      return sum;
    } catch (e) {
      print(e.toString());
      CustomExceptionHandler.handle(e as Exception);
      rethrow;
    }
  }

  Future<Map<String, num?>> getPendingAmounts(
      {List<String>? candidatesId}) async {
    try {
      var id = session.currentUser!.uid;
      var invoicesQuery = firestore
          .collection(USERS_COLLECTION)
          .doc(id)
          .collection(INVOICES_COLLECTION).where('invoiceStatus',
          isEqualTo: InvoiceStatus.pending.name);


      if (candidatesId.isNotNullEmpty) {
        invoicesQuery = invoicesQuery.where('payerId', whereIn: candidatesId);
      }
      var res = await invoicesQuery.get();
      var invoiceDocs = res.docs;
      var pendingAmounts = <String, num?>{};

      invoiceDocs.map((e) {
        pendingAmounts.putIfAbsent(e['payerId'], () => e['totalAmount']);
      }).toList();
      return pendingAmounts;
    } catch (e) {
      print(e.toString());
      CustomExceptionHandler.handle(e as Exception);
      rethrow;
    }
  }
}
