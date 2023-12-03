
import 'package:clerk/app/modules/charge/views/charges_vertical_list_view.dart';
import 'package:clerk/app/utils/enums/payment_interval_enums.dart';
import 'package:clerk/app/utils/enums/payment_type.dart';
import 'package:clerk/app/utils/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../values/colors.dart';

class ChargeTabView extends StatefulWidget {
  const ChargeTabView({Key? key}) : super(key: key);

  static Route<dynamic> getRoute() {
    return MaterialPageRoute(
      builder: (context) => ChargeTabView(),
    );
  }

  @override
  State<ChargeTabView> createState() => _ChargeTabViewState();
}

class _ChargeTabViewState extends State<ChargeTabView>
    with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    var tabController = TabController(
      length: PaymentInterval.values.length,
      initialIndex: 0,
      vsync: this,
    );
    return SafeArea(
      child: Scaffold(
        backgroundColor: backgroundColor,
        body: Container(
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
                            bottom: Radius.circular(12.w))),
                    child: Column(
                      children: [
                        Expanded(
                          flex: 3,
                          child: Container(
                            decoration: BoxDecoration(
                                color: primaryColor,
                                borderRadius: BorderRadius.vertical(
                                    bottom: Radius.circular(12.w))),
                            child: Row(
                              children: [
                                SizedBox(
                                  width: 12.w,
                                ),
                                GestureDetector(
                                  onTap: () {
                                    context.navigate.pop();
                                  },
                                  child: Container(
                                    padding: EdgeInsets.all(8.w),
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: backgroundColor,
                                    ),
                                    child: Icon(
                                      Icons.arrow_back_ios_rounded,
                                      color: primaryColor,
                                      size: 24.w,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 12.w,
                                ),
                                Text(
                                  "Charges",
                                  style: GoogleFonts.nunito(
                                      color: backgroundColor,
                                      fontSize: 24.sp,
                                      fontWeight: FontWeight.bold,
                                      letterSpacing: 1),
                                )
                              ],
                            ),
                          ),
                        ),
                        Container(
                          color: primaryColor,
                          child: TabBar(
                            labelColor: Colors.white,
                            isScrollable: true,
                            labelStyle: GoogleFonts.nunito(
                              fontSize: 16.sp,
                              letterSpacing: 1,
                              fontWeight: FontWeight.w500,
                            ),
                            labelPadding: EdgeInsets.symmetric(vertical: 2.h),
                            unselectedLabelColor: Colors.white.withOpacity(0.8),
                            indicatorColor: Colors.white,
                            controller: tabController,
                            tabs: [
                              Padding(
                                padding:  EdgeInsets.symmetric(horizontal: 12.w ),
                                child: Tab(text: PaymentType.oneTime.label),
                              ),
                              ...(PaymentInterval.values.sublist(1).reversed.toList()
                                  .map((e) => Padding(
                                    padding:  EdgeInsets.symmetric(horizontal: 12.w ),
                                    child: Tab(text: e.label),
                                  ))
                                  .toList())
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                flex: 1,
              ),
              SizedBox(
                height: 12.h,
              ),
              Expanded(
                flex: 6,
                child: Container(
                  margin: EdgeInsets.symmetric(
                    horizontal: 12.w,
                  ),
                  child: Column(
                    children: [
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 0.w, vertical: 8.h),
                          decoration: BoxDecoration(
                            color: lightPrimaryColor,
                            gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [lightPrimaryColor, backgroundColor]),
                            borderRadius: BorderRadius.vertical(
                                top: Radius.circular(12.w)),
                          ),
                          child: TabBarView(
                            physics: NeverScrollableScrollPhysics(),
                            controller: tabController,
                            children: [
                              ChargeVerticalListView.getWidget([],
                                  type: PaymentType.oneTime),
                              ...PaymentInterval.values.sublist(1).reversed.toList()
                                  .map((e) => ChargeVerticalListView.getWidget(
                                      [],
                                      interval: e))
                                  .toList()
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  color: Colors.transparent,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
