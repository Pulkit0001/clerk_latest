import 'package:clerk/app/custom_widgets/charge_grid_tile_view.dart';
import 'package:clerk/app/modules/candidate/bloc/cubits/candidate_form_cubit.dart';
import 'package:clerk/app/modules/charge/bloc/cubits/charges_list_cubit.dart';
import 'package:clerk/app/modules/charge/bloc/states/charge_list_state.dart';
import 'package:clerk/app/modules/charge/views/charges_form_view.dart';
import 'package:clerk/app/repository/charge_repo/charge_repo.dart';
import 'package:clerk/app/utils/enums/view_state_enums.dart';
import 'package:clerk/app/utils/extensions.dart';
import 'package:clerk/app/utils/locator.dart';
import 'package:clerk/app/values/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../custom_widgets/clerk_progress_indicator.dart';
import '../../../custom_widgets/empty_state_view.dart';
import '../bloc/states/candidate_form_state.dart';

class ApplyExtraChargeView extends StatelessWidget {
  const ApplyExtraChargeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var cubit = context.read<CandidatesFormCubit>();
    return Container(
      child: BlocBuilder<CandidatesFormCubit, CandidateFormState>(
        builder: (context, state) => Column(
          children: [
            Text(
              "Apply Extra Charges",
              style: GoogleFonts.nunito(
                  color: backgroundColor,
                  // color: backgroundColor,
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 1),
            ),
            SizedBox(
              height: 4.h,
            ),
            Expanded(
              child: BlocProvider<ChargesListCubit>(
                create: (context) => ChargesListCubit(
                    repo: getIt<ChargeRepo>(),
                    charges: null,
                    excludeCharges: cubit.state.candidate.groupCharges),
                child: Builder(builder: (context) {
                  return BlocBuilder<ChargesListCubit, ChargesListState>(
                    builder: (context, state) {
                      switch (state.viewState) {
                        case ViewState.loading:
                          {
                            return ClerkProgressIndicator();
                          }
                        case ViewState.empty:
                          {
                            return EmptyStateWidget(
                              message:
                                  "Don't you have created \n  any charges yet?",
                              image: '',
                              onActionPressed: () async {
                                context.navigate
                                    .push(ChargesFormView.getRoute());
                              },
                            );
                          }
                        case ViewState.idle:
                          {
                            return Column(
                              children: [
                                SizedBox(
                                  height: 4.h,
                                ),
                                Expanded(
                                  child: Container(
                                    child: GridView.builder(
                                      shrinkWrap: true,
                                      itemCount: state.charges.length,
                                      gridDelegate:
                                          SliverGridDelegateWithFixedCrossAxisCount(
                                              crossAxisSpacing: 12.h,
                                              mainAxisSpacing: 12.w,
                                              crossAxisCount: 2),
                                      itemBuilder: (context, index) {
                                        return ChargeGridTile(
                                          charge: state.charges[index],
                                          selected: cubit
                                              .state.candidate.extraCharges
                                              .contains(
                                                  state.charges[index].id),
                                          onPressed: (String value) {
                                            if (!cubit
                                                .state.candidate.groupCharges
                                                .contains(value)) {
                                              if (cubit
                                                  .state.candidate.extraCharges
                                                  .contains(value)) {
                                                cubit.removeCharge(value);
                                              } else {
                                                cubit.addCharge(value);
                                              }
                                            }
                                          },
                                        );
                                      },
                                    ),
                                  ),
                                ),
                              ],
                            );
                          }
                        default:
                          {
                            return Container();
                          }
                      }
                    },
                  );
                }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
