import 'dart:js';

import 'package:clerk/app/modules/payments/bloc/cubit/invoice_list_cubit.dart';
import 'package:clerk/app/modules/payments/bloc/state/invoice_list_state.dart';
import 'package:clerk/app/modules/payments/widgets/invoice_vertical_list_item.dart';
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

class InvoiceListView extends StatefulWidget {
  const InvoiceListView({Key? key}) : super(key: key);

  static Route<dynamic> getRoute({
    List<InvoiceStatus> status = const [
      InvoiceStatus.paid,
      InvoiceStatus.pending,
      InvoiceStatus.cancelled
    ],
    List<String>? candidateIds,
  }) {
    return MaterialPageRoute(
      builder: (context) => BlocProvider(
        create: (context) => InvoiceListCubit(
          repo: getIt<InvoiceRepo>(),
          candidateIds: candidateIds,
          status: status,
        ),
        child: InvoiceListView(),
      ),
    );
  }

  @override
  State<InvoiceListView> createState() => _InvoiceListViewState();
}

class _InvoiceListViewState extends State<InvoiceListView>
    with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    var cubit = context.read<InvoiceListCubit>();
    var tabController = TabController(
      length: 2,
      initialIndex: 0,
      vsync: this,
    );
    return SafeArea(
      child: Scaffold(
          backgroundColor: backgroundColor,
          resizeToAvoidBottomInset: false,
          body: Container(
            child: Column(
              children: [
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 12.w),
                    child: Column(
                      children: [
                        Expanded(
                          flex: 3,
                          child: Card(
                            clipBehavior: Clip.hardEdge,
                            color: primaryColor,
                            margin: EdgeInsets.zero,
                            elevation: 6,
                            shadowColor: primaryColor,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.vertical(
                                    bottom: Radius.circular(24.w))),
                            child: Container(
                              decoration: BoxDecoration(
                                  color: primaryColor,
                                  borderRadius: BorderRadius.vertical(
                                      bottom: Radius.circular(24.w))),
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
                                    "Invoices",
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
                        ),
                        if (cubit.status.length != 1)
                          TabBar(
                            labelColor: Colors.white,
                            labelStyle: GoogleFonts.nunito(
                                fontSize: 16.sp,
                                letterSpacing: 1,
                                fontWeight: FontWeight.w500),
                            labelPadding: EdgeInsets.symmetric(vertical: 2.h),
                            unselectedLabelColor: Colors.white.withOpacity(0.8),
                            indicatorColor: Colors.white,
                            controller: tabController,
                            tabs: [
                              ...cubit.status
                                  .map((e) => Tab(text: e.name.toUpperCase()))
                                  .toList()
                            ],
                          ),
                      ],
                    ),
                  ),
                  flex: 1,
                ),
                Expanded(
                  flex: 5,
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 12.w),
                    child: Column(
                      children: [
                        Expanded(
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 12.w, vertical: 16.h),
                            decoration: BoxDecoration(
                              color: lightPrimaryColor,
                              gradient: LinearGradient(
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  colors: [lightPrimaryColor, backgroundColor]),
                              borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(24.w)),
                            ),
                            child: Column(
                              children: [
                                BlocBuilder<InvoiceListCubit, InvoiceListState>(
                                    builder: (context, state) {
                                  if (state.viewState == ViewState.idle) {
                                    return TabBarView(
                                      controller: tabController,
                                      children: [
                                        ...cubit.status
                                            .map(
                                              (e) => ListView.builder(
                                                shrinkWrap: true,
                                                itemCount: state.invoices
                                                    .where((element) =>
                                                        element.invoiceStatus ==
                                                        e)
                                                    .length,
                                                itemBuilder:
                                                    (BuildContext context,
                                                            int index) =>
                                                        InvoiceVerticalListItem(
                                                  invoice: state.invoices
                                                      .where((element) =>
                                                          element
                                                              .invoiceStatus ==
                                                          e)
                                                      .elementAt(index),
                                                ),
                                              ),
                                            )
                                            .toList()
                                      ],
                                    );
                                  } else {
                                    return ClerkProgressIndicator();
                                  }
                                }),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    color: Colors.transparent,
                  ),
                ),
              ],
            ),
          )),
    );
  }
}
