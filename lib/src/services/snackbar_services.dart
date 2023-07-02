import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../core/constants/managers/color_manager.dart';
import '../core/constants/managers/icon_manager.dart';
import '../core/constants/managers/spacing_manager.dart';
import '../core/constants/text_styles/heading_style.dart';
import '../core/global_variables.dart';



class SnackBarService {
  SnackBarService._();

  
  static void showSuccessSnackBar() {
    ScaffoldMessenger.of(navigatorKey.currentContext!).removeCurrentSnackBar();
    ScaffoldMessenger.of(navigatorKey.currentContext!).showSnackBar(
      SnackBar(
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                SvgPicture.asset(IconManager.informationCircle),
                SpacingManager.w8,
                Text("Success", style: HeadingSmall.semiBold.copyWith(color: ColorManager.lightBlue)),
              ],
            ),
            SpacingManager.h8,
            Padding(
              padding: EdgeInsets.only(left: SpacingManager.w32.width!, right: SpacingManager.w12.width!),
              child: Text("Successful", style:  BodyTextSmall.regular.copyWith(color: ColorManager.lightBlue)),
            ),
          ],
        ),
        backgroundColor: ColorManager.darkBlue,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        behavior: SnackBarBehavior.floating,
        margin: EdgeInsets.only(left: usableWidth * 0.05, right: usableWidth * 0.05, bottom: usableHeight * 0.8),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  

 
   


}
