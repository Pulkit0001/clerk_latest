


import 'package:clerk/app/values/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomFab extends StatelessWidget {
  const CustomFab({Key? key,this.icon = Icons.arrow_back_ios,required this.onPressed }) : super(key: key);


  final IconData icon;
  final Function onPressed;
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      backgroundColor: backgroundColor,
      onPressed: () {
        onPressed();
      },
      child: Icon(
        icon,
        // size: 24.h,
        color: primaryColor,
      ),
    );
  }
}
