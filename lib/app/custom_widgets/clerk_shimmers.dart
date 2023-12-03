import 'package:clerk/app/values/colors.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

abstract class ClerkShimmers {
  static Widget buildFormShimmer(
          {int formFieldsLength = 4, required double height}) =>
      Column(
        children: List.generate(
          formFieldsLength,
          (index) => _buildShimmerTile(height),
        ),
      );

  static Widget buildListShimmer(
          {int listItemsLength = 8, required double height, EdgeInsets? margin}) =>
      ListView.builder(
          shrinkWrap: true,
          padding: EdgeInsets.zero,
          itemCount: listItemsLength,
          itemBuilder: (_, __) {
            return _buildShimmerTile(height, null, BoxShape.rectangle, margin);
          });

  static Widget buildGridShimmer(
          {int crossAxisCount = 2,
          int itemsLength = 8,
          required double height}) =>
      LayoutBuilder(builder: (context, constraints) {
        return GridView.builder(
          shrinkWrap: true,
          itemCount: itemsLength,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              childAspectRatio:
                  (constraints.maxWidth / crossAxisCount) / height,
              crossAxisCount: crossAxisCount),
          itemBuilder: (_, __) {
            return _buildShimmerTile(height, height, BoxShape.circle, EdgeInsets.zero);
          },
        );
      });

  static Widget buildChipsShimmer(
          {int itemsLength = 8, required double height}) =>
      Wrap(
        children: List.generate(
          itemsLength,
          (index) => _buildShimmerTile(height, 72, BoxShape.rectangle,
              const EdgeInsets.symmetric(vertical: 4, horizontal: 4)),
        ),
      );

  static Widget _buildShimmerTile(
      [double? height,
      double? width,
      BoxShape shape = BoxShape.rectangle,
      EdgeInsets? margin]) {
    return Shimmer.fromColors(
      baseColor: lightPrimaryColor.withOpacity(0.1),
      highlightColor: shimmerHighlightColor,
      direction: ShimmerDirection.ltr,
      child: Container(
        margin:
            margin ?? const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
        decoration: BoxDecoration(
            shape: shape,
            color: lightGreyColor,
            borderRadius:
                shape == BoxShape.circle ? null : BorderRadius.circular(12)),
        height: height ?? double.infinity,
        width: width ?? double.infinity,
      ),
    );
  }
}
