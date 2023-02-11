import 'package:clerk/app/custom_widgets/clerk_dialog.dart';
import 'package:clerk/app/custom_widgets/others_page.dart';
import 'package:clerk/app/modules/app/cubit/app_cubit.dart';
import 'package:clerk/app/modules/payments/views/invoice_list_view.dart';
import 'package:clerk/app/modules/profile/bloc/cubits/profile_detail_cubit.dart';
import 'package:clerk/app/modules/profile/bloc/states/profile_detail_state.dart';
import 'package:clerk/app/modules/profile/views/profile_form_view.dart';
import 'package:clerk/app/repository/user_profile_repo/user_profile_repo.dart';
import 'package:clerk/app/utils/extensions.dart';
import 'package:clerk/app/utils/locator.dart';
import 'package:clerk/app/values/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfileTabView extends StatelessWidget {
  static Widget getWidget() => BlocProvider(
      create: (context) =>
          UserProfileDetailsCubit(repo: getIt<UserProfileRepo>()),
      child: ProfileTabView());

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserProfileDetailsCubit, ProfileDetailState>(
        builder: (context, state) {
      return SafeArea(
        child: Scaffold(
          body: Stack(
            children: [
              Container(
                child: Column(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 12.w),
                        child: GestureDetector(
                          onTap: () {},
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
                                  Expanded(
                                    flex: 14000,
                                    child: Column(
                                      children: [
                                        SizedBox(
                                          height: 12.h,
                                        ),
                                        Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 12.w),
                                          child: Row(
                                            children: [
                                              Flexible(
                                                child: Text(
                                                  state.userProfile
                                                          ?.businessName ??
                                                      "",
                                                  softWrap: true,
                                                  maxLines: 2,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  textAlign: TextAlign.start,
                                                  style: GoogleFonts.nunito(
                                                    color: backgroundColor,
                                                    letterSpacing: 2,
                                                    fontSize: 24.sp,
                                                    // fontStyle: FontStyle.italic
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Spacer(),
                                      ],
                                    ),
                                  ),
                                  Spacer(
                                    flex: 8230,
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
                      ),
                      flex: 2,
                    ),
                    Expanded(
                      child: Container(),
                      flex: 7,
                    )
                  ],
                ),
              ),
              Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Spacer(
                      flex: 14000,
                    ),
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 12.w),
                        child: GestureDetector(
                          onTap: () {},
                          child: Container(
                            padding: EdgeInsets.all(8.h),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: lightPrimaryColor.withOpacity(0.7),
                            ),
                            child: Icon(
                              Icons.person,
                              color: backgroundColor,
                              size: 62.h,
                            ),
                          ),
                        ),
                      ),
                      flex: 12500,
                    ),
                    Expanded(
                      child: Container(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Text(
                              (state.userProfile?.firstName ?? "") +
                                  (state.userProfile?.lastName ?? ""),
                              textAlign: TextAlign.center,
                              style: GoogleFonts.poppins(
                                  color: lightPrimaryColor,
                                  fontSize: 18.sp,
                                  letterSpacing: 1,
                                  fontWeight: FontWeight.w600),
                            ),
                            Text(
                              "(${state.userProfile?.occupation ?? ""})",
                              textAlign: TextAlign.center,
                              style: GoogleFonts.poppins(
                                  color: lightPrimaryColor,
                                  fontSize: 18.sp,
                                  letterSpacing: 1,
                                  fontWeight: FontWeight.w400),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 12.w, vertical: 12.h),
                              child: Row(
                                children: [
                                  Expanded(
                                      child: ContactChip(
                                          label: "Email",
                                          value: state
                                                  .userProfile?.businessEmail ??
                                              "")),
                                  SizedBox(width: 6.w),
                                  Expanded(
                                      child: ContactChip(
                                          label: "Phone",
                                          value:
                                              "+91 ${state.userProfile?.businessContact ?? ""}")),
                                ],
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                padding: EdgeInsets.only(
                                  top: 6.h,
                                ),
                                child: ListView(
                                  children: [
                                    ProfileListItem(
                                      onPressed: () {},
                                      title: "Charges",
                                      icon: Icons.monetization_on_rounded,
                                    ),
                                    ProfileListItem(
                                      onPressed: () {
                                        context.navigate
                                            .push(InvoiceListView.getRoute());
                                      },
                                      title: "Invoices",
                                      icon: Icons.person,
                                    ),
                                    ProfileListItem(
                                      onPressed: () {
                                        context.navigate
                                            .push(UserProfileFormPage.getRoute(
                                          profile: context
                                              .read<UserProfileDetailsCubit>()
                                              .state
                                              .userProfile!,
                                          initialFormStep: 0,
                                        ));
                                      },
                                      title: "Personal Details",
                                      icon: Icons.person,
                                    ),
                                    ProfileListItem(
                                      onPressed: () {
                                        context.navigate
                                            .push(UserProfileFormPage.getRoute(
                                          profile: context
                                              .read<UserProfileDetailsCubit>()
                                              .state
                                              .userProfile!,
                                          initialFormStep: 1,
                                        ));
                                      },
                                      title: "Business Details",
                                      icon: Icons.business_center_rounded,
                                    ),
                                    ProfileListItem(
                                      onPressed: () {},
                                      title: "Bank Details",
                                      icon: Icons.business_rounded,
                                    ),
                                    ProfileListItem(
                                      onPressed: () {
                                        context.navigate.push(MaterialPageRoute(
                                            builder: (context) =>
                                                OthersPage()));
                                      },
                                      title: "Others",
                                      icon: Icons.other_houses_rounded,
                                    ),
                                    ProfileListItem(
                                      onPressed: () {
                                        showDialog(
                                            context: context,
                                            builder: (context) => ClerkDialog(
                                                  title: 'Logout',
                                                  body: Text(
                                                    "Are you sure that you want to logout?",
                                                    textAlign: TextAlign.center,
                                                    style: GoogleFonts.nunito(
                                                      color: textColor,
                                                      fontSize: 16.sp,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                    ),
                                                  ),
                                                  positiveLabel: "Logout",
                                                  onPositivePressed: () async {
                                                    context
                                                        .read<AppCubit>()
                                                        .logout();
                                                  },
                                                  negativeLabel: 'Cancel',
                                                  onNegativePressed: () {},
                                                ));
                                      },
                                      title: "Logout",
                                      icon: Icons.logout_rounded,
                                    ),
                                    SizedBox(
                                      height: 18.h,
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      flex: 73500,
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}

class ProfileListItem extends StatelessWidget {
  const ProfileListItem({
    Key? key,
    required this.onPressed,
    required this.title,
    required this.icon,
  }) : super(key: key);

  final Function onPressed;
  final String title;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 6.h, horizontal: 12.w),
      child: InkWell(
        onTap: () {
          onPressed.call();
        },
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 12.h),
          height: 48.h,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12.w),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    offset: Offset(4, 4),
                    blurRadius: 10)
              ]),
          child: Row(
            children: [
              Icon(
                icon,
                color: primaryColor,
                size: 24.w,
              ),
              SizedBox(
                width: 12.w,
              ),
              Text(
                title,
                style: GoogleFonts.nunito(
                    color: textColor,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w500),
              ),
              Spacer(),
              Icon(
                Icons.arrow_forward_ios_rounded,
                color: primaryColor,
                size: 18.w,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ContactChip extends StatelessWidget {
  const ContactChip({Key? key, required this.label, required this.value})
      : super(key: key);

  final String label;
  final String value;
  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(12.w)),
      ),
      color: lightPrimaryColor,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 8.w, horizontal: 8.h),
        child: Column(
          children: [
            Row(
              children: [
                Text(label,
                    style: GoogleFonts.nunito(
                        color: backgroundColor, fontSize: 11.sp)),
                Spacer(),
                Icon(
                  Icons.edit,
                  color: backgroundColor,
                  size: 20.w,
                ),
              ],
            ),
            SizedBox(
              height: 2.w,
            ),
            Text(value,
                maxLines: 1,
                softWrap: true,
                overflow: TextOverflow.ellipsis,
                style: GoogleFonts.poppins(
                    color: backgroundColor, fontSize: 12.sp, letterSpacing: 1)),
          ],
        ),
      ),
    );
  }
}
