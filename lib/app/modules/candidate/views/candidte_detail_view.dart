import 'package:clerk/app/custom_widgets/charge_vertical_list_tile_view.dart';
import 'package:clerk/app/custom_widgets/custom_filled_button.dart';
import 'package:clerk/app/modules/candidate/bloc/cubits/candidate_details_cubit.dart';
import 'package:clerk/app/modules/candidate/bloc/states/candidate_details_state.dart';
import 'package:clerk/app/modules/charge/bloc/cubits/charges_list_cubit.dart';
import 'package:clerk/app/modules/charge/bloc/states/charge_list_state.dart';
import 'package:clerk/app/modules/payments/views/invoice_list_view.dart';
import 'package:clerk/app/modules/profile_tab/views/profile_tab_view.dart';
import 'package:clerk/app/repository/candidate_repo/candidate_repo.dart';
import 'package:clerk/app/repository/charge_repo/charge_repo.dart';
import 'package:clerk/app/utils/enums/invoice_status.dart';
import 'package:clerk/app/utils/extensions.dart';
import 'package:clerk/app/utils/locator.dart';
import 'package:clerk/app/values/colors.dart';
import 'package:clerk/main.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CandidateDetailView extends StatelessWidget {
  const CandidateDetailView({Key? key, required this.id}) : super(key: key);

  final String id;

  static Route<dynamic> getRoute(String id) {
    return MaterialPageRoute(
      builder: (context) => CandidateDetailView(
        id: id,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<CandidateDetailsCubit>(
      create: (context) => CandidateDetailsCubit(
        candidateId: id,
        repo: getIt<CandidateRepo>(),
      ),
      child: Builder(builder: (context) {
        return BlocBuilder<CandidateDetailsCubit, CandidateDetailsState>(
            builder: (context, state) {
          return SafeArea(
            child: Scaffold(
              body: Column(
                children: [
                  buildHeader(state),
                  buildBody(state),
                ],
              ),
            ),
          );
        });
      }),
    );
  }

  Widget buildBody(CandidateDetailsState state) {
    return Expanded(
      child: Container(
        child: Column(
          children: [
            SizedBox(
              height: 12.w,
            ),
            ProfileListItem(
                onPressed: () {},
                title: "Pending Invoice",
                icon: Icons.monetization_on_rounded),
            buildGroupTile(),
            ProfileListItem(
                onPressed: () {
                  navigatorKey.currentState?.push(
                    InvoiceListView.getRoute(
                      candidateIds: [state.candidateId],
                      status: [InvoiceStatus.paid, InvoiceStatus.cancelled],
                    ),
                  );
                },
                title: "All Invoices",
                icon: Icons.monetization_on_rounded),
            BlocProvider<ChargesListCubit>(
              create: (context) => ChargesListCubit(
                repo: getIt<ChargeRepo>(),
                charges: state.candidate?.extraCharges,
              ),
              child: Builder(builder: (context) {
                return BlocBuilder<ChargesListCubit, ChargesListState>(
                  builder: (context, state) => ListView.builder(
                    itemBuilder: (context, index) => ChargeVerticalListTile(
                      charge: state.charges[index],
                    ),
                  ),
                );
              }),
            ),
          ],
        ),
      ),
      flex: 7,
    );
  }

  Widget buildGroupTile() {
    return Expanded(
      flex: 3,
      child: Card(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(18.w))),
        elevation: 8,
        shadowColor: backgroundColor,
        margin: EdgeInsets.symmetric(horizontal: 18.w, vertical: 12.w),
        child: Container(
          child: Row(
            children: [
              SizedBox(
                width: 18.w,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "B.Tech",
                    style: GoogleFonts.nunito(
                      fontSize: 20.sp,
                    ),
                  ),
                  Text(
                    "10:00 AM - 4:00 PM",
                    style: GoogleFonts.nunito(
                      fontSize: 14.sp,
                    ),
                  ),
                ],
              ),
              Spacer(),
              CustomFilledButton(
                elevation: 2,
                verticalPadding: 2.h,
                label: "Change",
                onPressed: () {},
                circularRadius: 22.h,
                textSize: 14.sp,
              ),
              SizedBox(
                width: 12.w,
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget buildHeader(CandidateDetailsState state) {
    return Expanded(
      child: Container(
        child: Stack(
          children: [
            Column(
              children: [
                buildBackdrop(),
                Spacer(
                  flex: 1,
                ),
              ],
            ),
            Column(
              children: [
                Spacer(
                  flex: 1,
                ),
                buildCandidateCard(state),
              ],
            ),
          ],
        ),
      ),
      flex: 3,
    );
  }

  Widget buildCandidateCard(CandidateDetailsState state) {
    return Expanded(
      child: Card(
        margin: EdgeInsets.symmetric(horizontal: 16.w),
        elevation: 8,
        shadowColor: primaryColor,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(18.w))),
        child: Container(
          padding: EdgeInsets.all(12.w),
          decoration: BoxDecoration(
              color: backgroundColor,
              borderRadius: BorderRadius.all(Radius.circular(18.w))),
          child: Column(
            children: [
              Expanded(
                flex: 3,
                child: Padding(
                  padding: EdgeInsets.only(bottom: 8.w),
                  child: Row(
                    children: [
                      buildCandidateDPView(state.candidate?.profilePic),
                      SizedBox(
                        width: 4.w,
                      ),
                      Expanded(
                          child: Container(
                            margin: EdgeInsets.all(4.w),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: Container(
                                    padding: EdgeInsets.only(left: 12.w),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Expanded(
                                          flex: 8,
                                          child: Padding(
                                            padding: EdgeInsets.only(top: 12.w),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Row(
                                                  children: [
                                                    Flexible(
                                                      child: Text(
                                                        "Pulkit Garg",
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        softWrap: true,
                                                        maxLines: 1,
                                                        style:
                                                            GoogleFonts.nunito(
                                                                fontSize: 16.sp,
                                                                height: 1.2,
                                                                color: Colors
                                                                    .blueGrey,
                                                                letterSpacing:
                                                                    1.5,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                      ),
                                                    ),
                                                    Text(
                                                      ", 21   ",
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      softWrap: true,
                                                      maxLines: 1,
                                                      style: GoogleFonts.nunito(
                                                          fontSize: 16.sp,
                                                          height: 1.2,
                                                          color:
                                                              Colors.blueGrey,
                                                          letterSpacing: 1.5,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                  ],
                                                ),
                                                Text(
                                                  "Anita Rani",
                                                  style: GoogleFonts.nunito(
                                                      fontSize: 14.sp,
                                                      height: 1.2,
                                                      color: Colors.blueGrey,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      letterSpacing: 1.2),
                                                ),
                                                Text(
                                                  "Naraingarh, Ambala",
                                                  style: GoogleFonts.nunito(
                                                    fontSize: 12.sp,
                                                    height: 1.2,
                                                    color: Colors.blueGrey,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          child: Icon(
                                            Icons.edit,
                                            color: primaryColor,
                                            size: 24.w,
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  flex: 3,
                                ),
                                buildPaymentStatusChip(),
                              ],
                            ),
                          ),
                          flex: 2),
                    ],
                  ),
                ),
              ),
              buildCandidateCardActions(),
            ],
          ),
        ),
      ),
      flex: 5,
    );
  }

  Widget buildCandidateCardActions() {
    return Expanded(
      flex: 1,
      child: Padding(
        padding: EdgeInsets.only(top: 4.w),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            buildSingleCandidateAction(
                icon: Icons.phone_rounded, onPressed: () {}),
            buildSingleCandidateAction(
                icon: Icons.message_rounded, onPressed: () {}),
            buildSingleCandidateAction(
                icon: Icons.warning_rounded, onPressed: () {}),
            buildSingleCandidateAction(
                icon: Icons.monetization_on_rounded, onPressed: () {}),
          ],
        ),
      ),
    );
  }

  Widget buildSingleCandidateAction(
      {required IconData icon, required Function() onPressed}) {
    return FloatingActionButton(
      elevation: 2,
      backgroundColor: backgroundColor,
      onPressed: onPressed,
      child: Icon(
        icon,
        color: primaryColor,
      ),
    );
  }

  Widget buildCandidateDPView(String? profilePic) {
    return Expanded(
        child: Container(
          clipBehavior: Clip.hardEdge,
          height: double.infinity,
          margin: EdgeInsets.symmetric(horizontal: 4.w, vertical: 4.w),
          decoration: BoxDecoration(
              color: lightPrimaryColor.withOpacity(0.5),
              border: Border.all(),
              borderRadius: BorderRadius.all(Radius.circular(12.w))),
          child: Stack(
            children: [
              profilePic.isNotNullEmpty
                  ? Image.network(
                      profilePic!,
                      fit: BoxFit.cover,
                    )
                  : Icon(
                      Icons.person,
                      size: 85.h,
                      color: backgroundColor,
                    ),
              Column(
                children: [
                  Spacer(
                    flex: 3,
                  ),
                  Expanded(
                      flex: 2,
                      child: Container(
                        padding: EdgeInsets.only(bottom: 6.w),
                        decoration: BoxDecoration(
                            // color: Colors.black.withOpacity(0.4),
                            gradient: LinearGradient(
                                begin: Alignment.bottomCenter,
                                end: Alignment.topCenter,
                                colors: [
                              Colors.black.withOpacity(0.5),
                              Colors.transparent
                            ])),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              "EDIT",
                              style: GoogleFonts.poppins(
                                  color: backgroundColor,
                                  fontSize: 13.sp,
                                  letterSpacing: 2,
                                  fontWeight: FontWeight.w600),
                            ),
                            SizedBox(
                              width: 8.w,
                            ),
                            Icon(
                              Icons.edit,
                              color: backgroundColor,
                              size: 16.w,
                            )
                          ],
                        ),
                      ))
                ],
              )
            ],
          ),
        ),
        flex: 1);
  }

  Widget buildBackdrop() {
    return Expanded(
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 8.w),
        decoration: BoxDecoration(
            color: primaryColor,
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(24.w))),
      ),
      flex: 5,
    );
  }

  Widget buildPaymentStatusChip() {
    return Expanded(
      child: Card(
        elevation: 0,
        shadowColor: Colors.green,
        margin: EdgeInsets.symmetric(
          horizontal: 30.w,
        ),
        color: Colors.green.withOpacity(0.3),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(8.w))),
        child: Container(
          alignment: Alignment.center,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "RECEIVED",
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(
                    color: Colors.green,
                    letterSpacing: 1,
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w500),
              ),
              SizedBox(
                width: 6.w,
              ),
              Icon(
                Icons.fact_check,
                color: Colors.green,
                size: 14.w,
              )
            ],
          ),
        ),
      ),
      flex: 1,
    );
  }
}
