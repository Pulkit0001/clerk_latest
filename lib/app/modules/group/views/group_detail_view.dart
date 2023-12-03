import 'package:clerk/app/custom_widgets/candidate_vertical_list_tile_view.dart';
import 'package:clerk/app/custom_widgets/clerk_progress_indicator.dart';
import 'package:clerk/app/custom_widgets/empty_state_view.dart';
import 'package:clerk/app/custom_widgets/invoice_status_chip.dart';
import 'package:clerk/app/data/models/candidate_data_model.dart';
import 'package:clerk/app/modules/candidate/views/update_charges_sheet.dart';
import 'package:clerk/app/modules/charge/bloc/cubits/charge_form_cubit.dart';
import 'package:clerk/app/modules/charge/views/charges_form_view.dart';
import 'package:clerk/app/modules/group/bloc/cubits/group_details_cubit.dart';
import 'package:clerk/app/modules/group/bloc/states/group_details_state.dart';
import 'package:clerk/app/modules/group/views/group_form_view.dart';
import 'package:clerk/app/modules/group/views/groups_bottom_sheet.dart';
import 'package:clerk/app/modules/invoices/views/invoice_pager_view.dart';
import 'package:clerk/app/repository/candidate_repo/candidate_repo.dart';
import 'package:clerk/app/repository/charge_repo/charge_repo.dart';
import 'package:clerk/app/repository/group_repo/group_repo.dart';
import 'package:clerk/app/repository/invoice_repo/invoice_repo.dart';
import 'package:clerk/app/utils/enums/invoice_status.dart';
import 'package:clerk/app/utils/enums/view_state_enums.dart';
import 'package:clerk/app/utils/extensions.dart';
import 'package:clerk/app/utils/locator.dart';
import 'package:clerk/app/values/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../custom_widgets/charge_vertical_list_tile_view.dart';
import '../../../data/models/charge_data_model.dart';
import '../../candidate/views/candidate_vertical_list_view.dart';
import '../../charge/views/charges_vertical_list_view.dart';

class GroupDetailView extends StatelessWidget {
  const GroupDetailView({Key? key}) : super(key: key);

  static Widget getWidget() => BlocProvider(
        create: (context) => GroupDetailsCubit(
          groupId: "",
          repo: getIt<GroupRepo>(),
          candidateRepo: getIt<CandidateRepo>(),
          chargeRepo: getIt<ChargeRepo>(),
          invoiceRepo: getIt<InvoiceRepo>(),
        ),
        child: GroupDetailView(),
      );

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: BlocBuilder<GroupDetailsCubit, GroupDetailsState>(
          builder: (context, state) {
            return Container(
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
                                bottom: Radius.circular(24.w))),
                        child: Container(
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Spacer(),
                                  if (state.pendingAmountState ==
                                      ViewState.idle)
                                    InkWell(
                                      onTap: () {
                                        if ((context
                                                    .read<GroupDetailsCubit>()
                                                    .state
                                                    .pendingAmount ??
                                                0) >
                                            0) {
                                          context.navigate.push(
                                            InvoicePager.getRoute(
                                              state.group?.candidates,
                                            ),
                                          );
                                        }
                                      },
                                      splashColor: Colors.red.withOpacity(0.25),
                                      splashFactory: InkRipple.splashFactory,
                                      child: Container(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 8.w, vertical: 4.h),
                                        margin: EdgeInsets.only(
                                          right: 16.w,
                                          top: 8.h,
                                        ),
                                        decoration: BoxDecoration(
                                          color: ((context
                                                          .read<
                                                              GroupDetailsCubit>()
                                                          .state
                                                          .pendingAmount ??
                                                      0) <=
                                                  0)
                                              ? Colors.green.withOpacity(.7)
                                              : Colors.red.withOpacity(.7),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(12.w)),
                                        ),
                                        child: Row(
                                          children: [
                                            Text(
                                              ((context
                                                              .read<
                                                                  GroupDetailsCubit>()
                                                              .state
                                                              .pendingAmount ??
                                                          0) <=
                                                      0)
                                                  ? "RECEIVED"
                                                  : "\u20b9 ${context.read<GroupDetailsCubit>().state.pendingAmount?.toString() ?? ""}",
                                              textAlign: TextAlign.center,
                                              style: GoogleFonts.nunito(
                                                color: backgroundColor,
                                                letterSpacing: 2,
                                                fontSize: 20.sp,
                                              ),
                                            ),
                                            if ((context
                                                        .read<
                                                            GroupDetailsCubit>()
                                                        .state
                                                        .pendingAmount ??
                                                    0) >
                                                0)
                                              Icon(
                                                Icons.arrow_forward_ios_rounded,
                                                color: backgroundColor,
                                              )
                                          ],
                                        ),
                                      ),
                                    ),
                                  if (state.group != null)
                                    Expanded(
                                      child: Align(
                                        alignment: Alignment.centerRight,
                                        child: IconButton(
                                          onPressed: () async {
                                            await context.navigate.push(
                                                GroupFormPage.getRoute(
                                                    group: state.group));
                                            context
                                                .read<GroupDetailsCubit>()
                                                .loadGroup();
                                          },
                                          icon: Icon(
                                            Icons.edit,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    )
                                  else
                                    Spacer()
                                ],
                              ),
                              SizedBox(
                                height: 15.h,
                              ),
                              Text(
                                state.group?.name
                                        .split(" ")
                                        .map((e) => e.replaceRange(0, 1,
                                            e.substring(0, 1).toUpperCase()))
                                        .toList()
                                        .join(" ") ??
                                    "Groups",
                                textAlign: TextAlign.center,
                                style: GoogleFonts.nunito(
                                  color: backgroundColor,
                                  letterSpacing: 1,
                                  fontSize: 20.sp,
                                ),
                              ),
                              Text(
                                state.group == null
                                    ? ""
                                    : "${state.group?.startTime ?? ""} - ${state.group?.endTime ?? ""}",
                                textAlign: TextAlign.center,
                                style: GoogleFonts.nunito(
                                  color: backgroundColor,
                                  fontSize: 18.sp,
                                ),
                              ),
                            ],
                          ),
                          decoration: BoxDecoration(
                              color: primaryColor,
                              borderRadius: BorderRadius.vertical(
                                  bottom: Radius.circular(24.w))),
                        ),
                      ),
                    ),
                    flex: 2,
                  ),
                  Expanded(
                    child: Stack(
                      children: [
                        Card(
                          elevation: 12,
                          shadowColor: primaryColor,
                          margin: EdgeInsets.only(
                              left: 12.w, right: 12.w, top: 12.w, bottom: 24.h),
                          color: backgroundColor,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(24.w))),
                          child: GroupDetailsTabBar(),
                        ),
                        Column(
                          children: [
                            Spacer(),
                            GestureDetector(
                              onTap: () async {
                                var res = await showBottomSheet(
                                  context: context,
                                  backgroundColor: Colors.transparent,
                                  clipBehavior: Clip.hardEdge,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.vertical(
                                      top: Radius.circular(
                                        24.w,
                                      ),
                                    ),
                                  ),
                                  builder: (context) => GroupListBottomSheet(
                                      selectedGroupId: state.groupId,
                                      onGroupSelected: context
                                          .read<GroupDetailsCubit>()
                                          .changeGroup),
                                );
                              },
                              child: Card(
                                color: lightPrimaryColor,
                                clipBehavior: Clip.hardEdge,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.vertical(
                                      top: Radius.circular(12.w)),
                                ),
                                margin: EdgeInsets.symmetric(horizontal: 12.w),
                                child: Container(
                                  child: Row(
                                    children: [
                                      Spacer(),
                                      Text(
                                        "Switch Group ",
                                        textAlign: TextAlign.center,
                                        style: GoogleFonts.nunito(
                                            color: backgroundColor,
                                            letterSpacing: 1,
                                            fontSize: 14.sp,
                                            fontWeight: FontWeight.bold
// fontStyle: FontStyle.italic
                                            ),
                                      ),
                                      Icon(
                                        Icons.arrow_drop_up_rounded,
                                        color: backgroundColor,
                                      ),
                                      SizedBox(
                                        width: 20.w,
                                      ),
                                    ],
                                  ),
                                  height: 26.h,
                                ),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                    flex: 9,
                  )
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

class GroupDetailsTabBar extends StatefulWidget {
  const GroupDetailsTabBar({
    Key? key,
  }) : super(key: key);

  @override
  State<GroupDetailsTabBar> createState() => _GroupDetailsTabBarState();
}

class _GroupDetailsTabBarState extends State<GroupDetailsTabBar>
    with TickerProviderStateMixin {
  late TabController tabController;

  @override
  void didUpdateWidget(covariant GroupDetailsTabBar oldWidget) {
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    tabController = TabController(
      length: 2,
      initialIndex: 0,
      vsync: this,
    );
    return Container(
      child: BlocBuilder<GroupDetailsCubit, GroupDetailsState>(
          builder: (context, state) {
        if (state.viewState == ViewState.idle) {
          return Column(
            children: [
              TabBar(
                labelColor: primaryColor,
                labelStyle: GoogleFonts.nunito(
                    fontSize: 16.sp,
                    letterSpacing: 1,
                    fontWeight: FontWeight.w500),
                labelPadding: EdgeInsets.symmetric(vertical: 2.h),
                unselectedLabelColor: lightPrimaryColor,
                indicatorColor: primaryColor,
                controller: tabController,
                tabs: [
                  Tab(text: "Candidates"),
                  Tab(text: "Charges"),
                ],
              ),
              Expanded(
                child: TabBarView(
                  physics: NeverScrollableScrollPhysics(),
                  controller: tabController,
                  children: [
                    CandidateVerticalListView.getWidget(
                        state.group?.candidates, state.group),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 8.h),
                      child: ChargeVerticalListView.getWidget(
                        state.group?.charges,
                        allowDeletion: false,
                        allowEdit: false,
                        emptyStateWidget: EmptyStateWidget(
                          actionBtnLabel: "Let me add",
                          message: "Don't you have added any charges yet",
                          onActionPressed: () async {
                            _handleChargesUpdation(state);
                          },
                        ),
                        fabActionCallback: () async {
                          _handleChargesUpdation(state);
                        },
                        removeFromGroupCallback: () {},
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        } else if (state.viewState == ViewState.loading) {
          return ClerkProgressIndicator();
        } else if (state.viewState == ViewState.empty) {
          return EmptyStateWidget(
              message: "Don't you have added any groups yet",
              onActionPressed: () async {
                await context.navigate.push(GroupFormPage.getRoute());
              });
        } else {
          return Builder(builder: (context) {
            return ErrorStateWidget(
                message: "OOPS!! Something went wrong. Please retry.",
                onActionPressed: () async {
                  print("action group called");
                  context.read<GroupDetailsCubit>().getCurrentGroup();
                });
          });
        }
      }),
    );
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  void _handleChargesUpdation(GroupDetailsState state) async {
    await showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (_) => Padding(
            padding: EdgeInsets.symmetric(horizontal: 12.w),
            child: UpdateChargesSheet.getWidget(state.group!)),
        backgroundColor: Colors.transparent);
    context.read<GroupDetailsCubit>().loadGroup();
  }
}
