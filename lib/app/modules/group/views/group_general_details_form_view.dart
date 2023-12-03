import 'package:clerk/app/custom_widgets/custom_text_field.dart';
import 'package:clerk/app/modules/group/bloc/cubits/group_form_cubit.dart';
import 'package:clerk/app/utils/validators.dart';
import 'package:clerk/app/values/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class GroupGeneralDetails extends StatelessWidget {
  const GroupGeneralDetails({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var cubit = context.read<GroupsFormCubit>();
    return Form(
      key: cubit.generalFormState,
      child: SingleChildScrollView(
        child: Column(
          children: [
            Text(
              "General Details",
              style: GoogleFonts.nunito(
                  color: backgroundColor,
                  // color: backgroundColor,
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 1.2),
            ),
            SizedBox(
              height: 20.h,
            ),
            CustomTextField(
                isOutlined: true,
                controller: cubit.nameController,
                label: "Name",
                inputType: TextInputType.name,
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.allow(RegExp("[ a-zA-Z]")),
                  FilteringTextInputFormatter.deny(RegExp(r'\s\s'),
                      replacementString: " "),
                ],
                validator: (value) {
                  return value!.validateAsName();
                },
                helperText: "Physics Batch",
                leading: Icons.group_rounded),
            SizedBox(
              height: 20.h,
            ),
            CustomTextField(
                trailing: Icons.access_time_rounded,
                editable: false,
                onTrailingTapped: () async {
                  var timePicked = await showTimePicker(
                      context: context,
                      initialTime: _parseTimeOfDay(
                          cubit.startTimeController.text.trim()),
                      builder: (context, child) => Theme(
                            data: ThemeData.light().copyWith(
                              colorScheme: ColorScheme.light(
                                primary: primaryColor,
                                onSurface: primaryColor,
                              ),
                            ),
                            child: child!,
                          ));
                  cubit.startTimeController.text =
                      timePicked!.format(context).toString();
                },
                isOutlined: true,
                inputType: TextInputType.none,
                controller: cubit.startTimeController,
                label: "Start Time (optional)",
                helperText: "4:00 PM",
                leading: Icons.access_time_rounded),
            SizedBox(
              height: 20.h,
            ),
            CustomTextField(
                editable: false,
                trailing: Icons.access_time_rounded,
                isOutlined: true,
                onTrailingTapped: () async {
                  var timePicked = await showTimePicker(
                      context: context,
                      initialTime:
                          _parseTimeOfDay(cubit.endTimeController.text.trim()),
                      builder: (context, child) => Theme(
                            data: ThemeData.light().copyWith(
                              colorScheme: ColorScheme.light(
                                primary: primaryColor,
                                onSurface: primaryColor,
                              ),
                            ),
                            child: child!,
                          ));
                  cubit.endTimeController.text =
                      timePicked!.format(context).toString();
                },
                inputType: TextInputType.none,
                controller: cubit.endTimeController,
                label: "End Time (optional)",
                helperText: "5:00 PM",
                leading: Icons.access_time_rounded),
            SizedBox(
              height: 20.h,
            ),
          ],
        ),
      ),
    );
  }

  TimeOfDay _parseTimeOfDay(String time) {
    try {
      if (time.isNotEmpty) {
        var hour = num.tryParse(time.split(" ")[0].split(":")[0]);
        var minute = num.tryParse(time.split(" ")[0].split(":")[1]);
        return TimeOfDay(hour: hour!.toInt(), minute: minute!.toInt());
      } else {
        return TimeOfDay.now();
      }
    } catch (e) {
      return TimeOfDay.now();
    }
  }
}
