import 'package:clerk/app/modules/payments/views/invoice_list_view.dart';
import 'package:clerk/app/modules/search/views/search_view.dart';
import 'package:clerk/app/utils/enums/invoice_status.dart';
import 'package:clerk/app/utils/extensions.dart';
import 'package:clerk/app/values/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../candidate/views/candidate_form_page.dart';

class HomeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          child: Column(
            children: [
              Expanded(
                child: Stack(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 12.w),
                      child: Column(
                        children: [
                          Expanded(
                            flex: 2,
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
                                decoration: BoxDecoration(
                                    // boxShadow: [BoxShadow(
                                    //   offset: Offset(2, 2),
                                    //   spreadRadius: 2,
                                    //   blurRadius: 2,
                                    //   color: lightPrimaryColor
                                    // )],
                                    color: primaryColor,
                                    borderRadius: BorderRadius.vertical(
                                        bottom: Radius.circular(24.w))),
                              ),
                            ),
                          ),
                          Expanded(
                              flex: 1,
                              child: Container(
                                color: Colors.transparent,
                              ))
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 30.w),
                      child: Column(
                        children: [
                          Expanded(
                              flex: 4,
                              child: Container(
                                color: Colors.transparent,
                              )),
                          Expanded(
                              flex: 4,
                              child: Card(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.all(
                                  Radius.circular(24.w),
                                )),
                                elevation: 12,
                                shadowColor: primaryColor,
                                color: backgroundColor,
                                child: Container(),
                              )),
                          Expanded(
                              flex: 1,
                              child: Container(
                                color: Colors.transparent,
                              ))
                        ],
                      ),
                    )
                  ],
                ),
                flex: 1,
              ),
              Expanded(
                flex: 2,
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 12.w),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: Column(
                          children: [
                            SizedBox(
                              height: (context.width - 36.w) / 2,
                              child: buildTile(
                                onPressed: () {
                                  context.navigate.push(
                                    MaterialPageRoute(
                                      builder: (context) => SearchPage(),
                                    ),
                                  );
                                },
                              ),
                            ),
                            SizedBox(
                              height: 12.w,
                            ),
                            Expanded(
                              flex: 2,
                              child: buildTile(
                                onPressed: () {
                                  context.navigate
                                      .push(CandidateFormPage.getRoute());
                                },
                              ),
                            ),
                            SizedBox(
                              height: 12.w,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: 12.w,
                      ),
                      Expanded(
                        flex: 1,
                        child: Column(
                          children: [
                            Expanded(
                              flex: 2,
                              child: buildTile(
                                onPressed: () {
                                  context.navigate.push(
                                    InvoiceListView.getRoute(
                                        status: [InvoiceStatus.paid]),
                                  );
                                },
                              ),
                            ),
                            SizedBox(
                              height: 12.w,
                            ),
                            SizedBox(
                              height: (context.width - 36.w) / 2,
                              child: buildTile(
                                onPressed: () {},
                              ),
                            ),
                            SizedBox(
                              height: 12.w,
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                  color: Colors.transparent,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget buildTile({required Function onPressed}) {
    return GestureDetector(
      onTap: () {
        onPressed();
      },
      child: Card(
        clipBehavior: Clip.hardEdge,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(24.w)),
        ),
        child: Container(
          color: backgroundColor,
        ),
        // color: Colors.red,
        elevation: 6,
        shadowColor: primaryColor,
      ),
    );
  }
}
