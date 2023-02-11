import 'dart:async';

import 'package:dartz/dartz.dart';

import '../../data/models/invoice_data_model.dart';
import '../../utils/enums/invoice_status.dart';

abstract class InvoiceRepo {

  Future<Either<Invoice, String>> generateInvoice(
      {required String candidateId});

  Future<Either<List<Invoice>, String>> getInvoices(
      {List<String>? candidateIds, List<InvoiceStatus>? status});

  Future<Either<num, String>> getTotalSum(
      {List<String>? candidateIds, List<InvoiceStatus>? status});

  Future<Either<Invoice, String>> getInvoiceById({required String invoiceId});

  Future<Either<bool, String>> payInvoice({required String invoiceId});

  Future<Either<bool, String>> cancelInvoice(
      {required String invoiceId, required String cancelReason});
}
