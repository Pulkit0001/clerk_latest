import 'package:clerk/app/custom_widgets/group_grid_tile_view.dart';
import 'package:clerk/app/modules/group/bloc/cubits/group_list_cubit.dart';
import 'package:clerk/app/modules/group/bloc/states/group_list_state.dart';
import 'package:clerk/app/utils/extensions.dart';
import 'package:clerk/app/utils/locator.dart';
import 'package:clerk/app/values/colors.dart';
import 'package:clerk/main.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';

import '../../../repository/group_repo/group_repo.dart';

class GroupListBottomSheet extends StatelessWidget {
  const GroupListBottomSheet({Key? key, required this.selectedGroupId, required this.onGroupSelected })
      : super(key: key);

  final String selectedGroupId;
  final Function(String groupId) onGroupSelected;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<GroupListCubit>(
      create: (context) => GroupListCubit(repo: getIt<GroupRepo>()),
      child: Builder(builder: (context) {
        return BlocBuilder<GroupListCubit, GroupsListState>(
          builder: (context, state) {
            return Card(
              margin: EdgeInsets.symmetric(horizontal: 12.w),

              clipBehavior: Clip.hardEdge,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(24.w))),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 8.w),
                height: context.height * .65,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius:
                      BorderRadius.vertical(top: Radius.circular(24.w)),
                  gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [lightPrimaryColor, backgroundColor]),
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Container(),
                        ),
                        GestureDetector(
                          onTap: () {
                            onGroupSelected.call(selectedGroupId);
                            navigatorKey.currentState?.pop();
                          },
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 12.w, vertical: 8.w),
                            child: Icon(
                              Icons.clear,
                              color: backgroundColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Expanded(
                      child: GridView.builder(
                        shrinkWrap: true,
                        itemCount: state.groups.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisSpacing: 12.h,
                            mainAxisSpacing: 12.w,
                            crossAxisCount: 2),
                        itemBuilder: (context, index) {
                          return GroupGridTile(
                            group: state.groups[index],
                            selected: selectedGroupId == state.groups[index].id,
                            onPressed: (String value) {
                              onGroupSelected.call(value);
                              navigatorKey.currentState?.pop();
                            },
                          );
                        },
                      ),
                    )
                  ],
                ),
              ),
            );
          },
        );
      }),
    );
  }
}
