import 'package:clerk/app/data/models/invoice_data_model.dart';
import 'package:clerk/app/data/services/cloud_firestore_services/invoice_service.dart';
import 'package:clerk/app/repository/invoice_repo/invoice_repo.dart';
import 'package:clerk/app/utils/enums/entity_status.dart';
import 'package:clerk/app/utils/enums/invoice_canceller.dart';
import 'package:clerk/app/utils/enums/invoice_status.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';

class InvoiceRepoImpl extends InvoiceRepo {
  final InvoiceService service;

  InvoiceRepoImpl(this.service);

  @override
  Future<Either<bool, String>> cancelInvoice(
      {required String invoiceId, required String cancelReason}) async {
    try {
      var res = await service.getInvoiceById(invoiceId: invoiceId);
      await service.updateInvoice(res.copyWith(
          status: EntityStatus.disabled,
          cancelledBy: InvoiceCanceller.payee,
          cancelReason: cancelReason));
      return Left(true);
    } catch (e) {
      return Right(e.toString());
    }
  }

  @override
  Future<Either<Invoice, String>> generateInvoice(
      {required String candidateId}) async {
    try {
      var res = await service.createInvoice(candidateId: candidateId);
      var invoice = await service.getInvoiceById(invoiceId: res);
      return Left(invoice);
    } catch (e) {
      return Right(e.toString());
    }
  }

  @override
  Future<Either<Invoice, String>> getInvoiceById(
      {required String invoiceId}) async {
    try {
      var invoice = await service.getInvoiceById(invoiceId: invoiceId);
      return Left(invoice);
    } catch (e) {
      return Right(e.toString());
    }
  }

  @override
  Future<Either<List<Invoice>, String>> getInvoices(
      {List<String>? candidateIds, List<InvoiceStatus>? status}) async {
    try {
      var invoices =
          await service.getInvoices(candidateIds: candidateIds, status: status);
      return Left(invoices);
    } catch (e) {
      return Right(e.toString());
    }
  }

  @override
  Future<Either<num, String>> getTotalSum(
      {List<String>? candidateIds, List<InvoiceStatus>? status}) async {
    try {
      var res =
      await service.getTotalSum(candidateIds: candidateIds, status: status);
      return Left(res);
    } catch (e) {
      return Right(e.toString());
    }
  }

  @override
  Future<Either<bool, String>> payInvoice({required String invoiceId}) async {
    try {
      var res = await service.getInvoiceById(invoiceId: invoiceId);
      await service.updateInvoice(res.copyWith(
        status: EntityStatus.disabled,
        invoiceStatus: InvoiceStatus.paid,
        paidOn: DateTime.now(),
        paidAmount: res.totalAmount,
      ));
      return Left(true);
    } catch (e) {
      return Right(e.toString());
    }
  }
}
