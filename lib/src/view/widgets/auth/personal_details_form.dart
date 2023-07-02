import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

import '../../../core/constants/managers/color_manager.dart';
import '../../../core/constants/managers/label_manager.dart';
import '../../../core/constants/managers/spacing_manager.dart';
import '../../../core/helpers/input_formatter.dart';
import '../../../core/helpers/validators.dart';
import '../../../viewmodel/controllers/new_user_controller.dart';

class PersonalDetailsForm extends StatefulWidget {
  const PersonalDetailsForm({super.key});
  @override
  State<PersonalDetailsForm> createState() => _PersonalDetailsFormState();
}

class _PersonalDetailsFormState extends State<PersonalDetailsForm> {
  final NewUserController _newUserController = NewUserController();
  bool _isHidden = true;

  void _saveFullname(String? value) {
    if (value == null) return;
    _newUserController.updateFullname = value;
  }

  void _saveEmail(String? value) {
    if (value == null) return;
    _newUserController.updateEmail = value;
  }

  void _updatePassword(String? value) {
    if (value == null) return;
    _newUserController.updatepassword = value;
  }

  @override
  void dispose() {
    _newUserController.dispose();
    super.dispose();
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
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        TextFormField(
          inputFormatters: InputFormatter.fullname,
          textCapitalization: TextCapitalization.words,
          decoration: InputDecoration(
            hintText: LabelManager.fullname,
            prefixIcon: const Icon(Icons.person_2_outlined, size: 15),
          ),
          validator: InputValidator.fullname,
          onSaved: _saveFullname,
        ),
        SpacingManager.h15,
        TextFormField(
          inputFormatters: InputFormatter.email,
          decoration: InputDecoration(
            hintText: LabelManager.email,
            prefixIcon: const Icon(Icons.email_outlined, size: 15),
          ),
          validator: InputValidator.email,
          onSaved: _saveEmail,
        ),
        SpacingManager.h15,
        IntlPhoneField(
          disableLengthCheck: true,
          inputFormatters: InputFormatter.phoneNumber,
          decoration: InputDecoration(
            hintText: LabelManager.phoneNumber,
            prefixIcon: const Icon(Icons.lock_outline_rounded, size: 15),
          ),
          languageCode: "en",
          onChanged: (phone) {
            print(phone.completeNumber);
          },
          onCountryChanged: (country) {
            print('Country changed to: ' + country.name);
          },
        ),
        SpacingManager.h15,
        TextFormField(
          inputFormatters: InputFormatter.password,
          decoration: InputDecoration(
              hintText: LabelManager.passWord,
              prefixIcon: const Icon(Icons.lock_outline_rounded, size: 15),
              suffix: IconButton(
                onPressed: _switchVisibility,
                icon: _suffixIcon,
                color: ColorManager.darkBlue,
              )),
          validator: InputValidator.password,
          onSaved: _updatePassword,
          obscureText: _isHidden,
        ),
      ],
    );
  }
}
