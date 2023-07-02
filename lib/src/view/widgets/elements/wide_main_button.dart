import 'package:flutter/material.dart';

import '../../../core/constants/managers/color_manager.dart';
import '../../../core/constants/managers/label_manager.dart';
import '../../../core/constants/text_styles/poppins_style.dart';
import '../../../core/global_variables.dart';



class WideMainButton extends StatelessWidget {
  const WideMainButton({required VoidCallback? function, super.key}) : _function = function;
  final VoidCallback? _function;
  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: _function,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5),
      ),
      color: ColorManager.darkBlue,
      minWidth: usableWidth * 0.813,
      height: usableHeight * 0.056,
      disabledColor: ColorManager.lightBlue,
      child: Text(LabelManager.createAccount, style: PoppinsStyle.medium15.copyWith(color: ColorManager.appColor)),
    );
  }
}

class WideMainButton2 extends StatelessWidget {
  const WideMainButton2({required VoidCallback? function, super.key}) : _function = function;
  final VoidCallback? _function;
  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: _function,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5),
      ),
      color: ColorManager.darkBlue,
      minWidth: usableWidth * 0.813,
      height: usableHeight * 0.056,
      disabledColor: ColorManager.lightBlue,
      child: Text(LabelManager.signin2, style: PoppinsStyle.medium15.copyWith(color: ColorManager.appColor)),
    );
  }
}

