import 'package:flutter/cupertino.dart';

class AppImages {
  static Image appLogo({double width,double  height}) {
    return Image.asset(
      'lib/src/assets/images/testt.jpg',
      width: width ?? null,
      height: height ?? null,
    );
  }
}
