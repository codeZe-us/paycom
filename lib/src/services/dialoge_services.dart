import 'package:flutter/material.dart';

import '../core/global_variables.dart';


class DialogService {
  DialogService._();
  static closeDialog() {
    Navigator.of(navigatorKey.currentContext!).pop();
  }
}
