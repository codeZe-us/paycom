import 'package:flutter/material.dart';

import '../../../core/constants/managers/color_manager.dart';
import '../../../core/constants/managers/label_manager.dart';
import '../../../core/constants/managers/spacing_manager.dart';
import '../../../core/helpers/input_formatter.dart';
import '../../../core/helpers/validators.dart';
import '../../../viewmodel/controllers/new_user_controller.dart';

class PersonalDetailsForm2 extends StatefulWidget {
  const PersonalDetailsForm2({super.key});

  @override
  State<PersonalDetailsForm2> createState() => _PersonalDetailsForm2State();
}

class _PersonalDetailsForm2State extends State<PersonalDetailsForm2> {
  final NewUserController _newUserController = NewUserController();
  bool _isHidden = true;
    final _passwordFocusNode = FocusNode();

  void _saveEmail(String? value) {
    if (value == null) return;
    _newUserController.updateEmail = value;
  }

  void _updatePassword(String? value) {
    if (value == null) return;
    _newUserController.updatepassword = value;
  }

void _switchVisibility() {
    setState(() {
      _isHidden = !_isHidden;
    });
  }

  Widget get _suffixIcon {
    if (_isHidden) return const Icon(Icons.visibility_off, size: 14);
    return const Icon(Icons.visibility, size: 14);
  }

  @override
  void dispose() {
    _newUserController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        TextFormField(
          decoration: const InputDecoration(
            hintText: LabelManager.email,
            prefixIcon: Icon(Icons.email_outlined, size: 20),
          ),
          inputFormatters: InputFormatter.email,
          validator: InputValidator.email,
          onSaved: _saveEmail,
        ),
        SpacingManager.h15,
        TextFormField(
          decoration: InputDecoration(
            hintText: LabelManager.passWord,
            prefixIcon: const Icon(Icons.lock_outline_rounded, size: 15),
            suffix: IconButton(onPressed: _switchVisibility, icon: _suffixIcon, color: ColorManager.darkBlue)
          ),
          inputFormatters: InputFormatter.email,
          validator: InputValidator.password,
             focusNode: _passwordFocusNode,
          onSaved: _updatePassword,
          obscureText: _isHidden,
        ),
      ],
    );
  }
}
