


class InputValidator {
  static String? email(String? value) {
    if (value == null || value.isEmpty) return "required";
    if (!RegExp(r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$").hasMatch(value)) return "invalid email";
    return null;
  }

  static String? fullname(String? value) {
    if (value == null || value.isEmpty) return "required";
    value.trim();
    if (value.split(" ").length < 2) return "enter your fullname";
    return null;
  }

  static String? password(String? value) {
    if (value == null || value.isEmpty) return "please enter the correct password";
    if (value.contains(RegExp(r"[A-Z][a-z][0-9]"))) return "Make use of capital letters, small letter and numbers";
    if (value.length < 8) return "Too short";
    return null;
  }

  static String? phoneNumber(String? value) {
    if (value == null || value.isEmpty) return null;
    if (value.split(" ").length != 10) return "Invalid phone number";
    return null;
  }

}
