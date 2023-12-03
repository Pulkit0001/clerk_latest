import 'package:clerk/app/custom_widgets/custom_filled_button.dart';
import 'package:clerk/app/custom_widgets/custom_snack_bar.dart';
import 'package:clerk/app/data/models/group_data_model.dart';
import 'package:clerk/app/modules/group/bloc/cubits/group_form_cubit.dart';
import 'package:clerk/app/modules/group/bloc/states/group_form_state.dart';
import 'package:clerk/app/modules/group/views/select_charges_view.dart';
import 'package:clerk/app/repository/group_repo/group_repo.dart';
import 'package:clerk/app/utils/enums/view_state_enums.dart';
import 'package:clerk/app/utils/extensions.dart';
import 'package:clerk/app/utils/locator.dart';
import 'package:clerk/app/values/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class UpdateChargesSheet extends StatelessWidget {
  const UpdateChargesSheet({super.key});

  static Widget getWidget(Group group) => BlocProvider(
    create: (_) => GroupsFormCubit(
        repo: getIt<GroupRepo>(), group: group),
    child: UpdateChargesSheet(),
  );
  @override
  Widget build(BuildContext context) {
    GroupFormState state = context.watch<GroupsFormCubit>().state;
    if (state.formState == CustomFormState.success) {
      context.navigate.pop(true);
      CustomSnackBar.show(
          title: "Yeah!!", body: state.successMessage ?? '');
    } else if (state.formState == CustomFormState.error) {
      CustomSnackBar.show(
          title: "OOPS!!", body: state.errorMessage ?? '');
    }
    return
      Stack(
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.75,
            clipBehavior: Clip.hardEdge,
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 18.h),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12.w),
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [lightPrimaryColor, backgroundColor],
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(
                  height: 4.h,
                ),
                Expanded(
                  child: SelectChargesView(),
                ),
                SizedBox(height: 12.h,),
                CustomFilledButton(
                  label: 'Update Charges',
                  onPressed: () {
                    context.read<GroupsFormCubit>().updateCharges();
                  },
                )
              ],
            ),
          ),
          Positioned(
            right: 0,
            child: InkWell(
              onTap: context.navigate.pop,
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Icon(
                  Icons.clear,
                  color: backgroundColor,
                ),
              ),
            ),
          )
        ],
      );
  }
}
