import 'package:clerk/app/values/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    Key? key,
    required this.controller,
    this.label,
    required this.helperText,
    required this.leading,
    this.trailing,
    this.leadingWidget,
    this.onTrailingTapped,
    this.inputFormatters,
    this.obscure = false,
    this.isOutlined = false,
    this.maxLines,
    this.validator,
    this.editable = true,
    this.maxLength,
    this.textAlign = TextAlign.start,
    this.inputType = TextInputType.text,
    this.autovalidateMode = AutovalidateMode.disabled,
  }) : super(key: key);

  final TextEditingController controller;
  final String? label;
  final String helperText;
  final IconData? leading;
  final Widget? leadingWidget;
  final IconData? trailing;
  final Function? onTrailingTapped;
  final bool obscure;
  final bool editable;
  final bool isOutlined;
  final int? maxLines;
  final int? maxLength;
  final TextInputType inputType;
  final TextAlign textAlign;
  final String? Function(String?)? validator;
  // final void Function(String?)? onChanged;
  final AutovalidateMode autovalidateMode;
  final List<TextInputFormatter>? inputFormatters;
  @override
  Widget build(BuildContext context) {
    return Flex(
      direction: Axis.vertical,
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        if (label != null) ...[
          Text("  " + label!,
              style: GoogleFonts.nunito(
                fontSize: 14.sp,
                color: textColor,
                fontWeight: FontWeight.normal,
              )),
          // SizedBox(height: 4.h),
        ],
        TextFormField(
          onTap: !editable ? () => onTrailingTapped!() : null,
          readOnly: !editable,
          textAlign: textAlign,
          textAlignVertical: TextAlignVertical.center,
          keyboardType: inputType,
          cursorColor: primaryColor,
          controller: controller,
          maxLines: maxLines,
          style: GoogleFonts.nunitoSans(color: textColor),
          validator: validator,
          inputFormatters: inputFormatters,
          maxLength: maxLength ?? 20,
          autovalidateMode: autovalidateMode,
          decoration: InputDecoration(
            counter: Offstage(
              child: SizedBox(
                height: 0,
              ),
            ),
            contentPadding: EdgeInsets.all(0),
            fillColor: backgroundColor,
            filled: true,
            hintText: helperText,
            hintStyle:
                GoogleFonts.nunitoSans(color: textColor.withOpacity(0.4)),
            helperMaxLines: 0,
            focusColor: primaryColor,
            prefixIcon: leadingWidget ?? (leading == null
                ? null
                : Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(top: 0.h),
                        child: Icon(leading, color: primaryColor),
                      ),
                    ],
                  )) ,
            errorMaxLines: 2,
            suffixIcon: trailing == null
                ? null
                : GestureDetector(
                    child: Icon(trailing, color: primaryColor),
                    onTap: () {
                      onTrailingTapped!();
                    },
                  ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(12.w)),
              gapPadding: 0,
              borderSide: BorderSide(
                  color: primaryColor,
                  width: 1,
                  style: isOutlined ? BorderStyle.solid : BorderStyle.none),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(12.w)),
              borderSide: BorderSide(
                  color: Colors.red,
                  width: 1,
                  style: isOutlined ? BorderStyle.solid : BorderStyle.none),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(12.w)),
              borderSide: BorderSide(
                  color: Colors.red,
                  width: 1,
                  style: isOutlined ? BorderStyle.solid : BorderStyle.none),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(12.w)),
              borderSide: BorderSide(
                  color: primaryColor,
                  width: 1,
                  style: isOutlined ? BorderStyle.solid : BorderStyle.none),
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(12.w)),
              borderSide: BorderSide(
                  color: primaryColor,
                  width: 1,
                  style: isOutlined ? BorderStyle.solid : BorderStyle.none),
            ),
          ),
        ),
      ],
    );
  }
}
