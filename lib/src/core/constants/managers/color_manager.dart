import 'package:flutter/material.dart' show Alignment, LinearGradient;

import '../../extensions/color_extension.dart';

class ColorManager {
  static final white = HexColor.fromHex("#FFFFFF");
    static final backgroundColor= HexColor.fromHex("#FFF2F2F2");

  static final darkBlue = HexColor.fromHex("#176B87");
  static final darkBlue2 = HexColor.fromHex("#001C30");
  static final appColor = HexColor.fromHex("#DAFFFB");
  static final lightBlue = HexColor.fromHex("#64CCC5");
  static final red = HexColor.fromHex("#FF0000");
  static final gradient1 = LinearGradient(colors: [white, white], begin: Alignment.topCenter, end: Alignment.bottomCenter);
}
