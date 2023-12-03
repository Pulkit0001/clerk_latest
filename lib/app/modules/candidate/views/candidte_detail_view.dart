import 'package:cached_network_image/cached_network_image.dart';
import 'package:clerk/app/custom_widgets/charge_vertical_list_tile_view.dart';
import 'package:clerk/app/custom_widgets/clerk_shimmers.dart';
import 'package:clerk/app/custom_widgets/custom_filled_button.dart';
import 'package:clerk/app/custom_widgets/empty_state_view.dart';
import 'package:clerk/app/custom_widgets/invoice_status_chip.dart';
import 'package:clerk/app/data/services/session_service.dart';
import 'package:clerk/app/modules/candidate/bloc/cubits/candidate_details_cubit.dart';
import 'package:clerk/app/modules/candidate/bloc/states/candidate_details_state.dart';
import 'package:clerk/app/modules/candidate/views/change_group_sheet.dart';
import 'package:clerk/app/modules/candidate/views/manage_extra_charges_sheet.dart';
import 'package:clerk/app/modules/charge/bloc/cubits/charges_list_cubit.dart';
import 'package:clerk/app/modules/charge/bloc/states/charge_list_state.dart';
import 'package:clerk/app/modules/group/bloc/cubits/group_details_cubit.dart';
import 'package:clerk/app/modules/group/bloc/states/group_details_state.dart';
import 'package:clerk/app/modules/invoices/views/invoices_tab_view.dart';
import 'package:clerk/app/modules/invoices/widgets/payment_collection_sheet.dart';
import 'package:clerk/app/modules/profile_tab/views/profile_tab_view.dart';
import 'package:clerk/app/repository/candidate_repo/candidate_repo.dart';
import 'package:clerk/app/repository/charge_repo/charge_repo.dart';
import 'package:clerk/app/repository/group_repo/group_repo.dart';
import 'package:clerk/app/repository/invoice_repo/invoice_repo.dart';
import 'package:clerk/app/services/utility_service.dart';
import 'package:clerk/app/utils/enums/invoice_status.dart';
import 'package:clerk/app/utils/enums/view_state_enums.dart';
import 'package:clerk/app/utils/extensions.dart';
import 'package:clerk/app/utils/locator.dart';
import 'package:clerk/app/values/colors.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../../../../main.dart';
import '../../../data/models/invoice_data_model.dart';
import 'candidate_form_page.dart';

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
        invoiceRepo: getIt<InvoiceRepo>(),
      ),
      child: Builder(
        builder: (context) {
          return SafeArea(
            child: Scaffold(
              body: BlocBuilder<CandidateDetailsCubit, CandidateDetailsState>(
                  builder: (context, state) {
                return Column(
                  children: [
                    buildHeader(state, context),
                    buildBody(state, context),
                  ],
                );
              }),
            ),
          );
        },
      ),
    );
  }

  Widget buildBody(CandidateDetailsState state, BuildContext context) {
    return Expanded(
      child: Container(
        child: Column(
          children: [
            SizedBox(
              height: 12.w,
            ),
            state.viewState == ViewState.idle
                ? ProfileListItem(
                    onPressed: () {},
                    title: "Pending Invoice",
                    icon: Icons.monetization_on_rounded)
                : ClerkShimmers.buildListShimmer(
                    height: 56, listItemsLength: 1),
            buildGroupTile(state, context),
            state.viewState == ViewState.idle
                ? ProfileListItem(
                    onPressed: () {
                      navigatorKey.currentState?.push(
                        InvoiceTabView.getRoute(
                          candidateIds: [state.candidateId],
                          status: [InvoiceStatus.paid, InvoiceStatus.cancelled],
                        ),
                      );
                    },
                    title: "All Invoices",
                    icon: Icons.monetization_on_rounded)
                : ClerkShimmers.buildListShimmer(
                    height: 56, listItemsLength: 1),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Row(
                children: [
                  Text(
                    'Extra Charges',
                    style: GoogleFonts.nunito(
                      color: primaryColor,
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Spacer(),
                  if (state.viewState == ViewState.idle &&
                      (state.candidate?.extraCharges).isNotNullEmpty)
                    InkWell(
                      onTap: () async {
                        await showModalBottomSheet(
                            context: context,
                            isScrollControlled: true,
                            builder: (_) => Padding(
                                padding: EdgeInsets.symmetric(horizontal: 12.w),
                                child: ManageExtraChargeSheet.getWidget(
                                    state.candidate!)),
                            backgroundColor: Colors.transparent);
                        context.read<CandidateDetailsCubit>().loadCandidate();
                      },
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: 8.h, horizontal: 8.w),
                        child: Row(
                          children: [
                            Text(
                              'Manage',
                              style: GoogleFonts.nunito(
                                  color: primaryColor,
                                  fontSize: 18.sp,
                                  fontWeight: FontWeight.w600,
                                  fontStyle: FontStyle.italic),
                            ),
                            Icon(
                              Icons.arrow_forward_ios_rounded,
                              color: primaryColor,
                              size: 18.sp,
                            )
                          ],
                        ),
                      ),
                    ),
                ],
              ),
            ),
            if (state.viewState == ViewState.idle &&
                (state.candidate?.extraCharges).isNotNullEmpty)
              Expanded(
                child: BlocProvider<ChargesListCubit>(
                  create: (context) => ChargesListCubit(
                    repo: getIt<ChargeRepo>(),
                    charges: state.candidate?.extraCharges,
                  ),
                  child: Builder(builder: (context) {
                    return BlocBuilder<ChargesListCubit, ChargesListState>(
                      builder: (context, state) => ListView.separated(
                        physics: NeverScrollableScrollPhysics(),
                        padding: EdgeInsets.symmetric(
                            horizontal: 12.w, vertical: 8.h),
                        itemCount: state.charges.length,
                        itemBuilder: (context, index) => ChargeVerticalListTile(
                          charge: state.charges[index],
                        ),
                        separatorBuilder: (context, index) => SizedBox(
                          height: 6.h,
                        ),
                      ),
                    );
                  }),
                ),
              )
            else if (state.viewState == ViewState.loading)
              Expanded(child: ClerkShimmers.buildListShimmer(height: 56, listItemsLength: 4))
            else
              Expanded(
                child: EmptyStateWidget(
                  image: '',
                  imageHeight: 56.h,
                  actionBtnLabel: "Let's Add",
                  message: "You haven't added any\n extra charges.",
                  onActionPressed: () async {
                    await showModalBottomSheet(
                      context: context,
                      isScrollControlled: true,
                      builder: (_) => Padding(
                        padding: EdgeInsets.symmetric(horizontal: 12.w),
                        child: ManageExtraChargeSheet.getWidget(
                          state.candidate!,
                        ),
                      ),
                      backgroundColor: Colors.transparent,
                    );
                    context.read<CandidateDetailsCubit>().loadCandidate();
                  },
                ),
              )
          ],
        ),
      ),
      flex: 7,
    );
  }

  Widget buildGroupTile(CandidateDetailsState state, BuildContext context) {
    return state.viewState == ViewState.idle
        ? BlocProvider<GroupDetailsCubit>(
            create: (_) => GroupDetailsCubit(
              groupId: state.candidate!.group,
              repo: getIt<GroupRepo>(),
              candidateRepo: getIt<CandidateRepo>(),
              chargeRepo: getIt<ChargeRepo>(),
              invoiceRepo: getIt<InvoiceRepo>(),
            ),
            child: BlocBuilder<GroupDetailsCubit, GroupDetailsState>(
                builder: (context, groupState) {
              return Container(
                margin: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.w),
                padding: EdgeInsets.symmetric(horizontal: 0.w, vertical: 12.w),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(12.w)),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          offset: Offset(4, 4),
                          blurRadius: 10)
                    ]),
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
                          groupState.group?.name ?? '',
                          style: GoogleFonts.nunito(
                            fontSize: 20.sp,
                          ),
                        ),
                        if (groupState.group?.startTime != null &&
                            groupState.group?.endTime != null)
                          Text(
                            "${groupState.group!.startTime} - ${groupState.group!.endTime}",
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
                      onPressed: () async {
                        await showModalBottomSheet(
                            context: context,
                            isScrollControlled: true,
                            builder: (_) => Padding(
                                padding: EdgeInsets.symmetric(horizontal: 12.w),
                                child: ChangeGroupSheet.getWidget(
                                    state.candidate!)),
                            backgroundColor: Colors.transparent);
                      },
                      circularRadius: 22.h,
                      textSize: 14.sp,
                    ),
                    SizedBox(
                      width: 12.w,
                    )
                  ],
                ),
              );
            }),
          )
        : ClerkShimmers.buildListShimmer(height: 96, listItemsLength: 1);
  }

  Widget buildHeader(CandidateDetailsState state, BuildContext context) {
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
                buildCandidateCard(state, context),
              ],
            ),
          ],
        ),
      ),
      flex: state.viewState == ViewState.loading
          ? 3
          : (state.pendingInvoice == null ? 2 : 3),
    );
  }

  Widget buildCandidateCard(CandidateDetailsState state, BuildContext context) {
    return Expanded(
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 16.w),
        padding: EdgeInsets.all(12.w),
        decoration: BoxDecoration(
          color: backgroundColor,
          boxShadow: [
            BoxShadow(
                color: Colors.black.withOpacity(0.1),
                offset: Offset(4, 4),
                blurRadius: 10)
          ],
          borderRadius: BorderRadius.all(
            Radius.circular(
              12.w,
            ),
          ),
        ),
        child: Column(
          children: [
            Expanded(
              flex: 3,
              child: Padding(
                padding: EdgeInsets.only(bottom: 8.w),
                child: Row(
                  children: [
                    if (state.viewState == ViewState.loading)
                      Expanded(
                        child: LayoutBuilder(builder: (context, constraints) {
                          return ClerkShimmers.buildListShimmer(
                            height: constraints.maxWidth,
                            margin: EdgeInsets.zero,
                            listItemsLength: 1
                          );
                        }),
                      )
                    else
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
                                        child: Padding(
                                          padding: EdgeInsets.only(top: 12),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              if (state.viewState ==
                                                  ViewState.loading)
                                                Row(
                                                  children: [
                                                    Expanded(
                                                      flex: 2,
                                                      child: ClerkShimmers
                                                          .buildListShimmer(
                                                              height: 16.sp,
                                                              margin: EdgeInsets
                                                                  .zero,
                                                              listItemsLength:
                                                                  1),
                                                    ),
                                                    Text(
                                                      ",",
                                                      style: GoogleFonts.nunito(
                                                          fontSize: 16.sp,
                                                          height: 1.2,
                                                          color:
                                                              Colors.blueGrey,
                                                          letterSpacing: 1.5,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                    Expanded(
                                                      flex: 1,
                                                      child: ClerkShimmers
                                                          .buildListShimmer(
                                                              margin: EdgeInsets
                                                                  .zero,
                                                              height: 16.sp,
                                                              listItemsLength:
                                                                  1),
                                                    ),
                                                  ],
                                                )
                                              else
                                                Row(
                                                  children: [
                                                    Flexible(
                                                      fit: FlexFit.tight,
                                                      child: Text(
                                                        state.candidate?.name
                                                                .replaceAll("",
                                                                    "\u{200B}") ??
                                                            "",
                                                        overflow: TextOverflow
                                                            .visible,
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
                                                      ", ${state.candidate?.age ?? ""}   ",
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
                                              if (state.viewState ==
                                                  ViewState.loading)
                                                SizedBox(
                                                  width: 72,
                                                  child: ClerkShimmers
                                                      .buildListShimmer(
                                                    height: 12.sp,
                                                    margin: EdgeInsets.only(
                                                        top: 4.0),
                                                    listItemsLength: 1,
                                                  ),
                                                )
                                              else
                                                Text(
                                                  state.candidate?.address ??
                                                      "",
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
                                      InkWell(
                                        onTap: () {
                                          Navigator.of(context).push(
                                              CandidateFormPage.getRoute(
                                                  candidate: state.candidate));
                                        },
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
                              if (state.viewState == ViewState.loading)
                                ClerkShimmers.buildListShimmer(
                                    height: 32,
                                    listItemsLength: 1,
                                    margin:
                                        EdgeInsets.symmetric(horizontal: 24))
                              else
                                buildPaymentStatusChip(
                                  state.pendingInvoice?.invoiceStatus ??
                                      InvoiceStatus.paid,
                                  state.pendingInvoice?.dueDate,
                                ),
                            ],
                          ),
                        ),
                        flex: 2),
                  ],
                ),
              ),
            ),
            if (state.viewState == ViewState.loading &&
                state.pendingInvoice == null)
              ClerkShimmers.buildGridShimmer(
                height: 48,
                itemsLength: 4,
                crossAxisCount: 4,
              ),
            if (state.pendingInvoice != null)
              buildCandidateCardActions(state.pendingInvoice!, context),
          ],
        ),
      ),
      flex: state.pendingInvoice == null ? 4 : 5,
    );
  }

  Widget buildCandidateCardActions(Invoice invoice, BuildContext context) {
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
                icon: Icons.phone_rounded,
                onPressed: () {
                  UtilityService.launchPhoneIntent(invoice);
                }),
            buildSingleCandidateAction(
                icon: Icons.message_rounded,
                onPressed: () {
                  UtilityService.launchSMSIntent(
                      invoice, getIt<Session>().userProfile!);
                }),
            buildSingleCandidateAction(
                icon: Icons.mail,
                onPressed: () {
                  UtilityService.launchMailIntent(
                      invoice, getIt<Session>().userProfile!);
                }),
            buildSingleCandidateAction(
                icon: Icons.monetization_on_rounded,
                onPressed: () {
                  showBottomSheet(
                    backgroundColor: Colors.transparent,
                    context: context,
                    builder: (_) => PaymentCollectionSheet.getWidget(invoice),
                  );
                }),
          ],
        ),
      ),
    );
  }

  Widget buildSingleCandidateAction(
      {required IconData icon, required Function() onPressed}) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        height: 56.w,
        width: 56.w,
        decoration: BoxDecoration(
            color: backgroundColor,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  offset: Offset(4, 4),
                  blurRadius: 10)
            ]),
        child: Icon(
          icon,
          color: primaryColor,
        ),
      ),
    );
  }

  Widget buildCandidateDPView(String? profilePic) {
    return Expanded(
      child: LayoutBuilder(
        builder: (context, constraints) {
          return Container(
            height: constraints.maxWidth,
            clipBehavior: Clip.hardEdge,
            margin: EdgeInsets.symmetric(horizontal: 4.w, vertical: 4.w),
            decoration: BoxDecoration(
                color: lightPrimaryColor.withOpacity(0.5),
                borderRadius: BorderRadius.all(Radius.circular(12.w))),
            child: CachedNetworkImage(
              imageUrl: profilePic ?? "",
              height: constraints.maxWidth,
              fit: BoxFit.cover,
              errorWidget: (a, b, c) => Image.asset('assets/images/avator.png'),
            ),
          );
        },
      ),
      flex: 1,
    );
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

  Widget buildPaymentStatusChip(InvoiceStatus invoiceStatus,
      [DateTime? dueDate]) {
    return Expanded(
      child: InvoiceStatusChip(
        status: invoiceStatus,
        dueDate: dueDate ?? DateTime.now(),
      ),
      flex: 1,
    );
  }
}
