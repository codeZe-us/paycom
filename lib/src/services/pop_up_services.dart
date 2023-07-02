import 'package:flutter/material.dart';

import '../core/constants/managers/color_manager.dart';
import '../core/constants/managers/error_string_managers.dart';
import '../core/global_variables.dart';
import '../view/widgets/dialogue/mini_info_dialogue.dart';



class PopUpService {
  PopUpService._();


  static showAuthenticationErrorDialog({required String message, Alignment position = Alignment.topCenter}) {
    showDialog(
      context: navigatorKey.currentContext!,
      barrierColor: ColorManager.darkBlue.withOpacity(0.2),
      barrierDismissible: true,
      builder: (context) => MiniInfoDialog(title: ErrorStringManager.authenticationFailed, body: message, alignment: position),
    );
  }

}
