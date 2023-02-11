import 'package:clerk/app/custom_widgets/charge_grid_tile_view.dart';
import 'package:clerk/app/modules/charge/bloc/cubits/charges_list_cubit.dart';
import 'package:clerk/app/modules/charge/bloc/states/charge_list_state.dart';
import 'package:clerk/app/modules/charge/views/charges_form_view.dart';
import 'package:clerk/app/modules/group/bloc/cubits/group_form_cubit.dart';
import 'package:clerk/app/modules/group/bloc/states/group_form_state.dart';
import 'package:clerk/app/repository/charge_repo/charge_repo.dart';
import 'package:clerk/app/utils/enums/view_state_enums.dart';
import 'package:clerk/app/utils/extensions.dart';
import 'package:clerk/app/utils/locator.dart';
import 'package:clerk/app/values/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../custom_widgets/empty_state_view.dart';

class SelectChargesView extends StatelessWidget {
  const SelectChargesView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var cubit = context.read<GroupsFormCubit>();
    return Container(child:
        BlocBuilder<GroupsFormCubit, GroupFormState>(builder: (context, state) {
      return Column(
        children: [
          Text(
            "Select Charges",
            style: GoogleFonts.nunito(
                color: backgroundColor,
                // color: backgroundColor,
                fontSize: 18.sp,
                fontWeight: FontWeight.w700,
                letterSpacing: 1.2),
          ),
          SizedBox(
            height: 4.h,
          ),
          Expanded(
            child: BlocProvider<ChargesListCubit>(
              create: (context) => ChargesListCubit(
                repo: getIt<ChargeRepo>(),
                charges: null,
              ),
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
                              await context.navigate
                                  .push(ChargesFormView.getRoute());
                              context
                                  .read<ChargesListCubit>()
                                  .loadCharges(null);
                            },
                          );
                        }
                      case ViewState.idle:
                        {
                          return Column(
                            children: [
                              Row(
                                children: [
                                  Spacer(),
                                  OutlinedButton(
                                    onPressed: () async {
                                      await context.navigate
                                          .push(ChargesFormView.getRoute());
                                      context
                                          .read<ChargesListCubit>()
                                          .loadCharges(null);
                                    },
                                    style: ButtonStyle(
                                      side: MaterialStateProperty.all(
                                          BorderSide(
                                              width: 2,
                                              color: backgroundColor)),
                                      shape: MaterialStateProperty.all(
                                          RoundedRectangleBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(30)))),
                                    ),
                                    child: Text(
                                      "Create New",
                                      style: GoogleFonts.poppins(
                                          color: backgroundColor,
                                          letterSpacing: 1,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 10.w,
                                  )
                                ],
                              ),
                              SizedBox(
                                height: 4.h,
                              ),
                              Container(
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
                                      selected: cubit.state.group.charges
                                          .contains(state.charges[index].id),
                                      onPressed: (String value) {
                                        if (cubit.state.group.charges
                                            .contains(value)) {
                                          cubit.removeCharge(value);
                                        } else {
                                          cubit.addCharge(value);
                                        }
                                      },
                                    );
                                  },
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
      );
    }));
  }
}

class ClerkProgressIndicator extends StatelessWidget {
  const ClerkProgressIndicator({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Wrap(
      direction: Axis.vertical,
      alignment: WrapAlignment.center,
      children: [
        Container(
          height: 96.h,
          width: 96.h,
          child: CircularProgressIndicator(
            color: primaryColor,
          ),
        ),
      ],
    );
  }
}
