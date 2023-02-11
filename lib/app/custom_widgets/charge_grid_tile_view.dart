import 'package:clerk/app/data/models/charge_data_model.dart';
import 'package:clerk/app/utils/enums/payment_type.dart';
import 'package:clerk/app/utils/enums/payment_interval_enums.dart';
import 'package:clerk/app/values/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class ChargeGridTile extends StatelessWidget {
  const ChargeGridTile(
      {required this.charge,
      Key? key,
      required this.selected,
      required this.onPressed})
      : super(key: key);

  final Charge charge;
  final bool selected;
  final Function(String) onPressed;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // onPressed("-1");
        onPressed(charge.id);
      },
      child: Container(
        width: double.infinity,
        child: Stack(
          children: [
            Column(
              children: [
                Expanded(
                  child: Container(),
                  flex: 1,
                ),
                Expanded(
                    flex: 3,
                    child: Card(
                      elevation: 6,
                      shadowColor: backgroundColor,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(6.w))),
                      clipBehavior: Clip.hardEdge,
                      child: Container(
                        foregroundDecoration: BoxDecoration(
                            color: Colors.transparent
                            // selected
                                // ? Colors.black.withOpacity(0.3)
                                // : Colors.transparent
                        ),
                        width: double.infinity,
                        padding: EdgeInsets.symmetric(horizontal: 10.w),
                        decoration: BoxDecoration(
                          color: primaryColor,
                        ),
                        child: Column(
                          children: [
                            Spacer(
                              flex: 1,
                            ),
                            Expanded(
                              flex: 2,
                              child: Column(
                                children: [
                                  Spacer(flex: 10,),
                                  Text(charge.name,   maxLines: 1 , style: GoogleFonts.poppins(
                                    color: backgroundColor,
                                    fontSize: 16.sp,

                                    fontWeight: FontWeight.w500,
                                    letterSpacing: 0,
                                    height: 1.25
                                  ),),
                                  Text("( ${charge.interval.label ?? charge.paymentType.label} )", style: GoogleFonts.kadwa(
                                    color:backgroundColor,
                                    fontSize: 14.sp,
                                    height: 1.5,
                                    fontWeight: FontWeight.w500,
                                    letterSpacing: 0,
                                  ),),
                                  Row(
                                    children: [
                                      Spacer(),
                                      selected ? Icon(Icons.check_circle, color: backgroundColor,) : SizedBox(),
                                    ],
                                  ),
                                  Spacer(flex: 20,),

                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ))
              ],
            ),
            Column(
              children: [
                Expanded(
                  child: Card(
                    color: backgroundColor,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(6.w))),
                    shadowColor: backgroundColor,
                    elevation: 0,
                    margin:
                        EdgeInsets.symmetric(vertical: 12.h, horizontal: 16.h),
                    child: Container(
                        foregroundDecoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.all(Radius.circular(6.w)),
                            color: Colors.transparent,
                            // selected
                            //     ? Colors.black.withOpacity(0.3)
                            //     : Colors.transparent
                        ),
                        width: double.infinity,
                        alignment: Alignment.center,
                        child: Text(
                          "\u20b9 ${charge.amount.toStringAsFixed(2)}",
                          textAlign: TextAlign.center,
                          style: GoogleFonts.poppins(
                              color: primaryColor,
                              fontSize: 18.sp,
                              fontWeight: FontWeight.w500,
                              letterSpacing: 1,
                              ),
                        )),
                  ),
                ),
                Expanded(
                  child: Container(),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
