import 'package:flutter/material.dart';

import '../../helpers/font_family.dart';
import '../../helpers/font_size.dart';
import '../../helpers/line_height.dart';

class HeadingSmall{
    static const semiBold = TextStyle(
    fontFamily: FontFamily.sfPro,
    fontSize: FontSize.s15,
    fontWeight: FontWeight.w600,
    height: LineHeight.h1_3,
  );
}

class BodyTextSmall {
    static const TextStyle regular = TextStyle(
    fontFamily: FontFamily.sfProText,
    fontSize: FontSize.s14,
    fontWeight: FontWeight.w400,
    height: LineHeight.h1_5,
  );
}