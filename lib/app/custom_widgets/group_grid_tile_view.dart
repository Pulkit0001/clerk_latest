import 'package:clerk/app/values/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../data/models/group_data_model.dart';

class GroupGridTile extends StatelessWidget {
  const GroupGridTile(
      {required this.group,
      Key? key,
      required this.selected,
      required this.onPressed})
      : super(key: key);

  final Group group;
  final bool selected;
  final Function(String) onPressed;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onPressed(group.id);
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
                          borderRadius:
                              BorderRadius.all( Radius.circular(8.w))),
                      clipBehavior: Clip.hardEdge,
                      child: Container(
                        foregroundDecoration: BoxDecoration(
                            color: selected
                                ? Colors.black.withOpacity(0.3)
                                : Colors.transparent),
                        width: double.infinity,
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
                                  Text(group.name.toUpperCase(),
                                    maxLines: 1,
                                    softWrap: true,
                                    textAlign: TextAlign.center,
                                    overflow: TextOverflow.clip,
                                    style: GoogleFonts.nunito(
                                        color: backgroundColor,
                                        // color: backgroundColor,
                                        fontSize: 16.sp,
                                        fontWeight: FontWeight.w600,
                                        letterSpacing: 1.2),
                                  ),
                                  Text(
                                      "${group.startTime} - ${group.endTime}", style: GoogleFonts.nunito(
                                  color: backgroundColor,
                                      // color: backgroundColor,
                                      fontSize: 12.sp,
                                      fontWeight: FontWeight.w500,
                                      letterSpacing: 0.0))
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
                    shape:

                    RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(100.h))),
                    shadowColor: primaryColor,
                    elevation: 8,
                    margin:
                        EdgeInsets.symmetric(vertical: 12.h, horizontal: 16.h),
                    child: Container(
                      width: 42.h,
                        // height: 56.h,
                        foregroundDecoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.all(Radius.circular(100.h)),
                            color: selected
                                ? Colors.black.withOpacity(0.3)
                                : Colors.transparent),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          group.name.toUpperCase().substring(0, 1),
                          textAlign: TextAlign.center,

                          style: GoogleFonts.nunito(
                              color: primaryColor,
                              fontWeight: FontWeight.w700,
                              fontSize: 24.sp,
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
