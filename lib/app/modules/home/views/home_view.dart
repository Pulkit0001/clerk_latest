import 'package:clerk/app/modules/dashboard/cubit/dashboard_cubit.dart';
import 'package:clerk/app/modules/dashboard/cubit/dashboard_state.dart';
import 'package:clerk/app/modules/invoices/views/invoice_list_view.dart';
import 'package:clerk/app/modules/invoices/views/invoices_tab_view.dart';
import 'package:clerk/app/modules/profile/bloc/cubits/profile_detail_cubit.dart';
import 'package:clerk/app/modules/search/views/search_view.dart';
import 'package:clerk/app/utils/enums/invoice_status.dart';
import 'package:clerk/app/utils/extensions.dart';
import 'package:clerk/app/values/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../../candidate/views/candidate_form_page.dart';
import '../../invoices/views/invoice_pager_view.dart';

class HomeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          child: Column(
            children: [
              Expanded(
                child: Stack(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 12.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Expanded(
                            flex: 2,
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
                                padding: EdgeInsets.symmetric(
                                    vertical: 20, horizontal: 24),
                                decoration: BoxDecoration(
                                    color: primaryColor,
                                    borderRadius: BorderRadius.vertical(
                                        bottom: Radius.circular(24.w))),
                                child: Column(
                                  children: [
                                    Text(
                                      context
                                              .read<UserProfileDetailsCubit>()
                                              .state
                                              .userProfile
                                              ?.businessName ??
                                          "",
                                      style: GoogleFonts.nunito(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w700,
                                        fontSize: 24,
                                        letterSpacing: 1.5,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                    Text(
                                      context
                                              .read<UserProfileDetailsCubit>()
                                              .state
                                              .userProfile
                                              ?.businessAddress ??
                                          "",
                                      style: GoogleFonts.nunito(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 20,
                                        letterSpacing: 1.5,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                              flex: 1,
                              child: Container(
                                color: Colors.transparent,
                              ))
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 30.w),
                      child: Column(
                        children: [
                          Expanded(
                              flex: 4,
                              child: Container(
                                color: Colors.transparent,
                              )),
                          Expanded(
                              flex: 4,
                              child:
                                  BlocBuilder<DashboardCubit, DashboardState>(
                                      builder: (context, state) {
                                return Card(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(
                                    Radius.circular(24.w),
                                  )),
                                  elevation: 12,
                                  clipBehavior: Clip.hardEdge,
                                  shadowColor: primaryColor,
                                  color: backgroundColor,
                                  child: InkWell(
                                    onTap: () {
                                      context.navigate
                                          .push(InvoicePager.getRoute());
                                    },
                                    splashColor: primaryColor.withOpacity(0.25),
                                    splashFactory: InkRipple.splashFactory,
                                    child: Container(
                                      padding: EdgeInsets.only(
                                          left: 24.w, right: 12.w),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        mainAxisSize: MainAxisSize.max,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.stretch,
                                        children: [
                                          Expanded(
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  'Total Pending Dues',
                                                  style: GoogleFonts.nunito(
                                                      color: textColor,
                                                      fontSize: 16,
                                                      letterSpacing: 1,
                                                      fontWeight:
                                                          FontWeight.w600),
                                                ),
                                                SizedBox(height: 2.h),
                                                Text(
                                                  NumberFormat(
                                                    "\u20b9 ##,##,###.00",
                                                    "en_in",     // local US
                                                  ).format(state.totalPendingAmount),
                                                  style: GoogleFonts.nunito(
                                                      color: textColor,
                                                      fontSize: 24,
                                                      letterSpacing: 0.8,
                                                      fontWeight:
                                                          FontWeight.w700),
                                                )
                                              ],
                                            ),
                                          ),
                                          Row(
                                            children: [
                                              Text(
                                                'CHECK',
                                                style: GoogleFonts.nunito(
                                                    color: textColor,
                                                    fontSize: 18,
                                                    letterSpacing: 0.7,
                                                    fontWeight:
                                                        FontWeight.w800),
                                              ),
                                              Icon(
                                                Icons
                                                    .arrow_forward_ios_outlined,
                                                color: textColor,
                                                size: 16.w,
                                              )
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              })),
                          Expanded(
                              flex: 1,
                              child: Container(
                                color: Colors.transparent,
                              ))
                        ],
                      ),
                    )
                  ],
                ),
                flex: 1,
              ),
              Expanded(
                flex: 2,
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 12.w),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: Column(
                          children: [
                            SizedBox(
                              height: (context.width - 36.w) / 2,
                              child: buildTile(
                                svgPath:
                                    'assets/illustrations/search-illustration.svg',
                                title: 'Search',
                                onPressed: () {
                                  context.navigate.push(SearchPage.getRoute());
                                },
                              ),
                            ),
                            SizedBox(
                              height: 12.w,
                            ),
                            Expanded(
                              flex: 2,
                              child: buildTile(
                                title: "Add Customer",
                                svgPath:
                                    'assets/illustrations/add_customer_illustration.svg',
                                onPressed: () {
                                  context.navigate
                                      .push(CandidateFormPage.getRoute());
                                },
                              ),
                            ),
                            SizedBox(
                              height: 12.w,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: 12.w,
                      ),
                      Expanded(
                        flex: 1,
                        child: Column(
                          children: [
                            Expanded(
                              flex: 2,
                              child: buildTile(
                                svgPath:
                                    'assets/illustrations/recent_payments.svg',
                                title: 'Recent Payments',
                                onPressed: () {
                                  context.navigate.push(
                                    InvoiceTabView.getRoute(
                                        status: [InvoiceStatus.paid]),
                                  );
                                },
                              ),
                            ),
                            SizedBox(
                              height: 12.w,
                            ),
                            SizedBox(
                              height: (context.width - 36.w) / 2,
                              child: buildTile(
                                svgPath:
                                    'assets/illustrations/accept_payment.svg',
                                title: 'Accept Payment',
                                onPressed: () {},
                              ),
                            ),
                            SizedBox(
                              height: 12.w,
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                  color: Colors.transparent,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget buildTile(
      {required Function onPressed,
      required String svgPath,
      required String title}) {
    return InkWell(
      onTap: () {
        onPressed();
      },
      splashColor: primaryColor.withOpacity(0.25),
      splashFactory: InkRipple.splashFactory,
      child: Card(
        clipBehavior: Clip.hardEdge,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(24.w)),
        ),
        child: Container(
          color: backgroundColor,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(
                svgPath,
                height: 72,
                width: 72,
              ),
              SizedBox(
                height: 12,
              ),
              Text(
                title,
                style: GoogleFonts.nunito(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: textColor),
                textAlign: TextAlign.center,
              )
            ],
          ),
        ),
        elevation: 6,
        shadowColor: primaryColor,
      ),
    );
  }
}
