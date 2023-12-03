import 'package:clerk/app/data/models/invoice_data_model.dart';
import 'package:clerk/app/data/models/user_profile_data_model.dart';
import 'package:clerk/app/services/utility_service.dart';
import 'package:clerk/app/values/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

class InvoiceActionsWidget extends StatelessWidget {
  InvoiceActionsWidget({
    Key? key,
    required this.userProfile,
    required this.invoice,
  }) : super(key: key) {
    isDialOpen = ValueNotifier<bool>(false);
  }

  late final ValueNotifier<bool> isDialOpen;
  final UserProfile userProfile;
  final Invoice invoice;

  @override
  Widget build(BuildContext context) {
    return SpeedDial(
      elevation: 6,
      overlayColor: Colors.transparent,
      overlayOpacity: 0.0,
      openCloseDial: isDialOpen,
      useRotationAnimation: true,
      spaceBetweenChildren: 6,
      spacing: 6,
      buttonSize: Size(56.0, 56.0),
      childPadding: EdgeInsets.zero,
      childrenButtonSize: Size(56.0, 56.0),
      direction: SpeedDialDirection.up,
      backgroundColor: Colors.transparent,
      childMargin: EdgeInsets.zero,
      child: Container(
        width: double.infinity,
        height: double.infinity,

        decoration: BoxDecoration(color: primaryColor, shape: BoxShape.circle),
        child: InkWell(
          onTap: () {
            isDialOpen.value = !isDialOpen.value;
          },
          child: Icon(
            Icons.keyboard_arrow_up_rounded,
            color: Colors.white,
            size: 28,
          ),
        ),
      ),
      children: [
        SpeedDialChild(
          elevation: 6,
          backgroundColor: Colors.transparent,
          child: InkWell(
            onTap: () {
              UtilityService.launchMailIntent(invoice, userProfile);
            },
            child: Container(
              decoration:
              BoxDecoration(color: primaryColor, shape: BoxShape.circle),
              padding: EdgeInsets.all(12.w),
              child: Icon(
                Icons.mail,
                color: Colors.white,
              ),
            ),
          ),
        ),
        SpeedDialChild(
          elevation: 6,
          backgroundColor: Colors.transparent,
          child: InkWell(
            onTap: () {
              UtilityService.launchSMSIntent(invoice, userProfile);
            },
            child: Container(
              decoration:
                  BoxDecoration(color: primaryColor, shape: BoxShape.circle),
              padding: EdgeInsets.all(12.w),
              child: Icon(
                Icons.sms,
                color: Colors.white,
              ),
            ),
          ),
        ),
        SpeedDialChild(
          elevation: 6,
          backgroundColor: Colors.transparent,
          child: InkWell(
            onTap: () {
              UtilityService.launchPhoneIntent(invoice,);
            },
            child: Container(
              decoration:
              BoxDecoration(color: primaryColor, shape: BoxShape.circle),
              padding: EdgeInsets.all(12.w),
              child: Icon(
                Icons.phone,
                color: Colors.white,
              ),
            ),
          ),
        )
      ],
    );
  }
}
