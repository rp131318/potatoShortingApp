import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nexus/util/colors.dart';
import 'package:nexus/util/constants.dart';
import 'package:nexus/util/text_styles.dart' as rahul;

class NewButton extends StatelessWidget {
  final BuildContext context;
  final String buttonText;
  final double width;
  final double height;
  final Function function;
  var color;
  bool border = false;
  bool isRadius = true;
  final Widget child;
  final bool rDefaultWidget;
  final TextStyle? textStyle;
  final margin;
  final borderRadius;

  NewButton({
    required this.context,
    this.buttonText = "Text",
    required this.function,
    this.border = false,
    this.width = double.infinity,
    this.height = 46,
    this.color = colorDark,
    this.isRadius = true,
    this.rDefaultWidget = true,
    this.child = const Text("default"),
    this.textStyle,
    this.margin,
    this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: margin ?? EdgeInsets.zero,
      child: SizedBox(
        height: height,
        width: width,
        child: ElevatedButton(
          onPressed: () => function(),
          style: ButtonStyle(
            overlayColor: MaterialStateProperty.resolveWith(
              (states) {
                return states.contains(MaterialState.pressed)
                    ? border
                        ? colorCustom.shade50
                        : Colors.white.withOpacity(0.3)
                    : null;
              },
            ),
            backgroundColor: border
                ? MaterialStateProperty.all(Colors.white)
                : MaterialStateProperty.all(color),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: borderRadius ?? constants.borderRadius,
                side: border
                    ? BorderSide(
                        color: color,
                      )
                    : BorderSide.none,
              ),
            ),
          ),
          child: rDefaultWidget
              ? Center(
                  child: Text(
                  buttonText,
                  style: textStyle ?? rahul.textStyle.button,
                ))
              : child,
        ),
      ),
    );
  }
}
