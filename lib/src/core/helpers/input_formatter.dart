import 'package:flutter/services.dart';

class InputFormatter {
  static final email = [FilteringTextInputFormatter.allow(RegExp(r"[a-zA-Z0-9@.-_$#]"))];
  static final fullname = [
    FilteringTextInputFormatter.allow(RegExp(r"[A-Z a-z]")),
    FilteringTextInputFormatter.deny(RegExp(r"[A-Z][A-Z]")),
    FilteringTextInputFormatter.deny(RegExp(r"[a-z][A-Z]")),
  ];
  static final password = [
    FilteringTextInputFormatter.allow(RegExp(r"[A-Z0-9a-z&$%@#~!]")),
  ];
  static final phoneNumber = [
    FilteringTextInputFormatter.allow(RegExp(r"[0-9]")),
  ];
}
