import 'dart:convert';

import '../../view/screens/auth/sign_up_screen.dart';

class NewUserController {
  NewUserController._internal();
  static final _instance = NewUserController._internal();
  factory NewUserController() => _instance;

  String? _fullname = "";
  String? _email = "";
  String? _phoneNumber = "";
  String? _password = "";
  UserType _usertype = UserType.user;

  String get fullname {
    _fullname ??= "";
    return _fullname!;
  }

  String get email {
    _email ??= "";
    return _email!;
  }

  String get phoneNumber {
    _phoneNumber ??= "";
    return _phoneNumber!;
  }

  String get password {
    _password ??= "";
    return _password!;
  }

  UserType get usertype {
    return _usertype;
  }

 

  Map<String, String> get jsonData {
    return {"fullname": _fullname!, "email": _email!, "phoneNumber": _phoneNumber!};
  }

  Map<String, String> get credentials {
    return {"email": _email!, "password": password};
  }

  set updateFullname(String value) {
    _fullname = value;
  }

  set updateEmail(String value) {
    _email = value;
  }

  set updatephoneNumber(String value) {
    _phoneNumber = value;
  }

  set updatepassword(String value) {
    _password = value;
  }

  set updateUserType(UserType value) {
    _usertype = value;
  }



  void credentialsFromJson(String? json) {
    if (json == null) return;
    final data = jsonDecode(json);
    _email = data["email"];
    _password = data["password"];
  }

  Map<String, String?> loginInfo() {
    return {"email": _email, "password": _password};
  }

  Map<String, String?> registerInfo() {
    return {
      "first_name": _fullname!.split(" ").first,
      "last_name": _fullname!.split(" ").last,
      "email": _email,
      "password": _password,
      "type": "user",
      
    };
  }

  void dispose() {
    _fullname = null;
    _email = null;
    _phoneNumber = null;
    _password = null;
  }
}
