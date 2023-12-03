import 'package:clerk/app/custom_widgets/clerk_dialog.dart';
import 'package:clerk/app/custom_widgets/custom_snack_bar.dart';
import 'package:clerk/app/custom_widgets/empty_state_view.dart';
import 'package:clerk/app/modules/charge/bloc/states/charge_list_state.dart';
import 'package:clerk/app/modules/charge/views/charges_form_view.dart';
import 'package:clerk/app/utils/enums/view_state_enums.dart';
import 'package:clerk/app/utils/extensions.dart';
import 'package:clerk/app/utils/locator.dart';
import 'package:clerk/app/values/colors.dart';
import 'package:clerk/app/values/strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../custom_widgets/charge_vertical_list_tile_view.dart';
import '../../../custom_widgets/clerk_progress_indicator.dart';
import '../../../repository/charge_repo/charge_repo.dart';
import '../../../utils/enums/payment_interval_enums.dart';
import '../../../utils/enums/payment_type.dart';
import '../bloc/cubits/charges_list_cubit.dart';

class ChargeVerticalListView extends StatelessWidget {
  const ChargeVerticalListView(
      {Key? key,
      this.charges,
      required this.allowEdit,
      required this.allowDeletion,
      this.removeFromGroupCallback,
      this.fabActionCallback,
      this.emptyStateWidget})
      : super(key: key);

  static Widget getWidget(
    List<String>? charges, {
    PaymentType? type,
    PaymentInterval? interval,
    bool allowEdit = true,
    bool allowDeletion = true,
    VoidCallback? removeFromGroupCallback,
    Widget? emptyStateWidget,
    Future<void> Function()? fabActionCallback,
  }) {
    return BlocProvider<ChargesListCubit>(
      create: (context) => ChargesListCubit(
          repo: getIt<ChargeRepo>(),
          charges: charges,
          type: type,
          interval: interval),
      child: ChargeVerticalListView(
          charges: charges,
          allowDeletion: allowDeletion,
          allowEdit: allowEdit,
          removeFromGroupCallback: removeFromGroupCallback,
          fabActionCallback: fabActionCallback,
          emptyStateWidget: emptyStateWidget),
    );
  }

  final List<String>? charges;
  final bool allowEdit;
  final bool allowDeletion;
  final VoidCallback? removeFromGroupCallback;
  final Future<void> Function()? fabActionCallback;
  final Widget? emptyStateWidget;

  @override
  Widget build(BuildContext context) {
    context.read<ChargesListCubit>().loadCharges(charges);
    return BlocBuilder<ChargesListCubit, ChargesListState>(
      builder: (context, state) {
        if (state.viewState == ViewState.loading) {
          return ClerkProgressIndicator();
        } else if (state.viewState == ViewState.empty) {
          return emptyStateWidget ??
              EmptyStateWidget(
                  message: "Don't you have added any Charges yet",
                  onActionPressed: () async {
                    await context.navigate.push(ChargesFormView.getRoute());
                    context.read<ChargesListCubit>().loadCharges(null);
                  });
        } else if (state.viewState == ViewState.error) {
          return ErrorStateWidget(
              message: "OOPS!! Something went wrong. Please retry.",
              onActionPressed: () async {
                context.read<ChargesListCubit>().loadCharges(null);
              });
        } else {
          const groupTag = 'x';
          return Container(
            child: Stack(
              children: [
                SlidableAutoCloseBehavior(
                  child: ListView.separated(
                    shrinkWrap: true,
                    itemCount: state.charges.length,
                    itemBuilder: (context, index) => Container(
                      margin: EdgeInsets.symmetric(horizontal: 12.w),
                      child: Slidable(
                        groupTag: groupTag,

                        // key: ValueKey(0),
                        endActionPane: ActionPane(
                          extentRatio: (allowEdit ? 0.15 : 0) +
                              (allowDeletion ? 0.15 : 0) +
                              (removeFromGroupCallback != null ? 0.15 : 0),
                          motion: ScrollMotion(),
                          children: [
                            if (allowEdit)
                              SlidableAction(
                                borderRadius: allowDeletion
                                    ? BorderRadius.zero
                                    : BorderRadius.horizontal(
                                        right: Radius.circular(12.w)),
                                onPressed: (_) async {
                                  await context.navigate.push(
                                      ChargesFormView.getRoute(
                                          charge: state.charges[index]));
                                  context.read<ChargesListCubit>().loadCharges(null);
                                },
                                backgroundColor: Colors.transparent,
                                foregroundColor: primaryColor,
                                icon: Icons.edit,
                              ),
                            if (allowDeletion)
                              SlidableAction(
                                borderRadius: BorderRadius.horizontal(
                                    right: Radius.circular(12.w)),
                                onPressed: (context) {
                                  var cubit = context.read<ChargesListCubit>();
                                  showDialog(
                                    context: context,
                                    builder: (_) => ClerkDialog(
                                      body: Text(
                                        "Are you sure that you want to delete this charge?",
                                        textAlign: TextAlign.center,
                                        style: GoogleFonts.nunito(
                                          color: textColor,
                                          fontSize: 16.sp,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                      positiveLabel: "Delete",
                                      onPositivePressed: () async {
                                        var res = await cubit.deleteCharge(
                                            state.charges[index].id);
                                        if (res) {
                                          CustomSnackBar.show(
                                              title: defaultSuccessTitle,
                                              body:
                                                  "Charge deleted successfully");
                                        } else {
                                          if (state.errorMessage != null) {
                                            CustomSnackBar.show(
                                                title: defaultErrorTitle,
                                                body: defaultErrorBody);
                                          }
                                        }
                                      },
                                      negativeLabel: 'Cancel',
                                      onNegativePressed: () {},
                                    ),
                                  );
                                },
                                backgroundColor: Colors.transparent,
                                foregroundColor: primaryColor,
                                icon: Icons.delete_rounded,
                              ),
                            if (removeFromGroupCallback != null)
                              SlidableAction(
                                borderRadius: BorderRadius.horizontal(
                                    right: Radius.circular(12.w)),
                                onPressed: (context) {
                                  removeFromGroupCallback?.call();
                                },
                                backgroundColor: Colors.transparent,
                                foregroundColor: primaryColor,
                                icon: Icons.clear,
                              ),
                          ],
                        ),
                        child: ChargeVerticalListTile(
                          charge: state.charges[index],
                        ),
                      ),
                    ),
                    separatorBuilder: (context, index) => SizedBox(
                      height: 6.h,
                    ),
                  ),
                ),
                Positioned(
                  right: 12,
                  bottom: 16,
                  child: fabActionCallback != null
                      ? SizedBox(
                          height: 32.h,
                          width: 156.w,
                          child: FloatingActionButton.extended(
                            onPressed: () async {
                              fabActionCallback?.call();
                            },
                            backgroundColor: backgroundColor,
                            label: Text(
                              "Manage Charges",
                              style: GoogleFonts.nunito(
                                color: primaryColor,
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            icon: Icon(
                              Icons.edit_rounded,
                              color: primaryColor,
                              size: 20.w,
                            ),
                          ),
                        )
                      : FloatingActionButton(
                          onPressed: () async {
                            await context.navigate
                                .push(ChargesFormView.getRoute());
                            context.read<ChargesListCubit>().loadCharges(null);
                          },
                         backgroundColor: primaryColor,
                          child: Icon(
                            Icons.edit_rounded,
                            color: Colors.white,
                            size: 24.w,
                          ),
                        ),
                ),
              ],
            ),
          );
        }
      },
    );
  }
}
