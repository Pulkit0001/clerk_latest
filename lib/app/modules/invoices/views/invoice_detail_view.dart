import 'package:cached_network_image/cached_network_image.dart';
import 'package:clerk/app/custom_widgets/empty_state_view.dart';
import 'package:clerk/app/custom_widgets/invoice_list_item_view.dart';
import 'package:clerk/app/custom_widgets/invoice_status_chip.dart';
import 'package:clerk/app/data/models/invoice_data_model.dart';
import 'package:clerk/app/modules/invoices/bloc/cubit/invoice_detail_cubit.dart';
import 'package:clerk/app/modules/invoices/bloc/cubit/invoice_list_cubit.dart';
import 'package:clerk/app/modules/invoices/bloc/state/invoice_detail_state.dart';
import 'package:clerk/app/modules/invoices/bloc/state/invoice_list_state.dart';
import 'package:clerk/app/repository/invoice_repo/invoice_repo.dart';
import 'package:clerk/app/utils/enums/invoice_status.dart';
import 'package:clerk/app/utils/enums/view_state_enums.dart';
import 'package:clerk/app/utils/extensions.dart';
import 'package:clerk/app/utils/locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../custom_widgets/clerk_progress_indicator.dart';
import '../../../values/colors.dart';

class InvoiceDetailView extends StatelessWidget {
  const InvoiceDetailView({Key? key}) : super(key: key);

  static Route<dynamic> getRoute({
    required Invoice invoice,
  }) =>
      MaterialPageRoute(
        builder: (context) => BlocProvider(
          create: (context) => InvoiceDetailCubit(
            repo: getIt<InvoiceRepo>(),
            invoice: invoice,
          ),
          child: InvoiceDetailView(),
        ),
      );

  @override
  Widget build(BuildContext context) {
    var cubit = context.read<InvoiceListCubit>();
    return SafeArea(
      child: Scaffold(
        backgroundColor: backgroundColor,
        body: Container(
          child: Column(
            children: [
              Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 12.w),
                  child: Card(
                    clipBehavior: Clip.hardEdge,
                    color: primaryColor,
                    margin: EdgeInsets.zero,
                    elevation: 6,
                    shadowColor: primaryColor,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.vertical(
                            bottom: Radius.circular(12.w))),
                    child: Row(
                      children: [
                        SizedBox(
                          width: 12.w,
                        ),
                        GestureDetector(
                          onTap: () {
                            context.navigate.pop();
                          },
                          child: Container(
                            padding: EdgeInsets.all(8.w),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: backgroundColor,
                            ),
                            child: Icon(
                              Icons.arrow_back_ios_rounded,
                              color: primaryColor,
                              size: 24.w,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 12.w,
                        ),
                        Text(
                          "Select Invoice",
                          style: GoogleFonts.nunito(
                              color: backgroundColor,
                              fontSize: 24.sp,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 1),
                        )
                      ],
                    ),
                  ),
                ),
                flex: 1,
              ),
              SizedBox(
                height: 12.h,
              ),
              Expanded(
                flex: 9,
                child: Container(
                  margin: EdgeInsets.symmetric(
                    horizontal: 12.w,
                  ),
                  child: Column(
                    children: [
                      Expanded(
                        child:
                            BlocBuilder<InvoiceDetailCubit, InvoiceDetailState>(
                          builder: (context, state) {
                            if (state.viewState == ViewState.idle) {
                              return InvoiceDetailCard(
                                invoice: state.invoice,
                              );
                            } else if (state.viewState == ViewState.loading) {
                              return ClerkProgressIndicator();
                            } else {
                              return EmptyStateWidget(
                                image: '',
                                message: "Invoices not found!!",
                              );
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                  color: Colors.transparent,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class InvoiceDetailCard extends StatelessWidget {
  const InvoiceDetailCard({super.key, required this.invoice});

  final Invoice invoice;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 12.w,
        vertical: 16.h,
      ),
      decoration: BoxDecoration(
        color: lightPrimaryColor,
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            lightPrimaryColor,
            backgroundColor,
          ],
        ),
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(12.w),
        ),
      ),
      child: Column(
        children: [
          Row(
            children: [
              CachedNetworkImage(imageUrl: invoice.candidate!.profilePic),
              Column(
                children: [
                  Text("${invoice.candidate!.name}, ${invoice.candidate!.age}"),
                  Text(invoice.candidate!.address),
                ],
              ),
              Spacer(),
              Expanded(
                child: Column(
                  children: [
                    InvoiceStatusChip(status: invoice.invoiceStatus, dueDate: invoice.dueDate!),

                  ],
                ),
              )
            ],
          ),
          Divider(),

        ],
      ),
    );
  }
}
