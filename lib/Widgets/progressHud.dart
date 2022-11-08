import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nexus/util/colors.dart';
import 'package:nexus/util/constants.dart';
import 'package:nexus/util/text_styles.dart';

class ProgressHUD extends StatelessWidget {
  final Widget child;
  final bool isLoading;
  final double opacity;
  final Color color;

  ProgressHUD({
    required this.child,
    required this.isLoading,
    this.opacity = 0.5,
    this.color = Colors.black,
  });

  @override
  Widget build(BuildContext context) {
    List<Widget> widgetList = List<Widget>.empty(growable: true);
    widgetList.add(child);
    if (isLoading) {
      final modal = Stack(
        children: [
          Opacity(
            opacity: opacity,
            child: ModalBarrier(dismissible: false, color: color),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Image.asset(
                  "images/loading.gif",
                  width: 111,
                  height: 111,
                ),
                Text(
                  "Loading...",
                  style: textStyle.heading.copyWith(color: colorWhite),
                ),
                const SizedBox(
                  height: constants.defaultPadding * 8,
                )
              ],
            ),
          ),
        ],
      );
      widgetList.add(modal);
    }
    return Stack(
      children: widgetList,
    );
  }
}
