import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nexus/util/constants.dart';
import 'package:nexus/util/text_styles.dart';

import '../util/colors.dart';

class MyTextFiled extends StatelessWidget {
  const MyTextFiled({
    Key? key,
    required this.controller,
    required this.hint,
    this.length,
    this.inputType,
    this.margin,
    this.maxLine,
    this.onChange,
    this.height = 0,
    this.readOnly = false,
  }) : super(key: key);

  final TextEditingController controller;
  final String hint;
  final int? length;
  final inputType;
  final margin;
  final int? maxLine;
  final Function(String)? onChange;
  final double height;
  final bool readOnly;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height == 0 ? 60.h : height,
      child: Padding(
        padding: margin ??
            const EdgeInsets.only(
                top: constants.defaultPadding,
                left: constants.defaultPadding,
                right: constants.defaultPadding),
        child: TextFormField(
          readOnly: readOnly,
          onChanged: onChange,
          controller: controller,
          textAlignVertical: TextAlignVertical.center,
          inputFormatters: length != null
              ? [
                  LengthLimitingTextInputFormatter(length),
                ]
              : [],
          keyboardType: inputType,
          maxLines: maxLine ?? 1,
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderSide: const BorderSide(width: 2),
              borderRadius: constants.borderRadius,
            ),
            hintText: hint,
            hintStyle: textStyle.subHeading.copyWith(
              color: colorDark,
              fontSize: 13.sp,
            ),
            // labelText: hint,
            // labelStyle: textStyle.subHeading.copyWith(color: colorDark,fontSize: 20.sp),
          ),
        ),
      ),
    );
  }
}
