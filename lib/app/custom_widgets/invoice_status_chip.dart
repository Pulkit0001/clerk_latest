
import 'package:clerk/app/utils/enums/invoice_status.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class InvoiceStatusChip extends StatelessWidget {
  const InvoiceStatusChip(
      {super.key, required this.status, required this.dueDate});

  final InvoiceStatus status;
  final DateTime dueDate;
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      shadowColor: _decideChipColor(status, dueDate),
      margin: EdgeInsets.symmetric(
        horizontal: 30.w,
      ),
      color: _decideChipColor(status, dueDate).withOpacity(0.3),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(8.w))),
      child: Container(
        alignment: Alignment.center,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              _decideChipText(status, dueDate),
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(
                  color: _decideChipColor(status, dueDate),
                  letterSpacing: 1,
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w500),
            ),
            SizedBox(
              width: 6.w,
            ),
            Icon(
              Icons.fact_check,
              color: _decideChipColor(status, dueDate),
              size: 14.w,
            )
          ],
        ),
      ),
    );
  }

  Color _decideChipColor(InvoiceStatus status, DateTime dueDate) {
    return (status == InvoiceStatus.paid)
        ? Colors.green
        : status == InvoiceStatus.cancelled
        ? Colors.grey
        : status == InvoiceStatus.pending &&
        dueDate.isBefore(DateTime.now())
        ? Colors.red
        : Colors.orange;
  }

  String _decideChipText(InvoiceStatus status, DateTime dueDate) {
    return status == InvoiceStatus.paid
        ? "RECEIVED"
        : status == InvoiceStatus.cancelled
        ? "CANCELLED"
        : status == InvoiceStatus.pending &&
        dueDate.isBefore(DateTime.now())
        ? 'OVERDUE'
        : 'PENDING';
  }
}