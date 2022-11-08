import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nexus/util/text_styles.dart';

class SplaceScreen extends StatelessWidget {
  const SplaceScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        "The Ag Senses",
        style: textStyle.heading.copyWith(fontSize: 33),
      ),
      // child: Image.asset(
      //   "images/logo.png",
      //   height: 222.h,
      // ),
    );
  }
}
