import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:paycom/src/core/constants/managers/color_manager.dart';
import 'package:paycom/src/core/constants/managers/label_manager.dart';
import 'package:paycom/src/core/constants/managers/string_manager.dart';
import 'package:paycom/src/core/constants/text_styles/poppins_style.dart';

import '../../../core/constants/managers/spacing_manager.dart';
import '../../../core/constants/routes/routes.dart';
import '../../../core/global_variables.dart';
import '../../../services/api_service.dart';
import '../../../services/dialoge_services.dart';
import '../../../services/pop_up_services.dart';
import '../../../services/snackbar_services.dart';
import '../../../viewmodel/controllers/new_user_controller.dart';
import '../../widgets/auth/personal_details_form.dart';
import '../../widgets/elements/wide_main_button.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> with WidgetsBindingObserver {
  final _formKey = GlobalKey<FormState>();
  bool _isKeyboardVisible = false;

  void _revertSystemUIOverlay() {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: ColorManager.backgroundColor,
        statusBarBrightness: Brightness.light,
        statusBarIconBrightness: Brightness.light,
        systemNavigationBarColor: ColorManager.backgroundColor,
        systemNavigationBarIconBrightness: Brightness.dark,
        systemNavigationBarContrastEnforced: true,
        systemStatusBarContrastEnforced: true,
      ),
    );
  }

  void _setSystemUIOverlay() {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: ColorManager.backgroundColor,
        statusBarBrightness: Brightness.dark,
        statusBarIconBrightness: Brightness.dark,
        systemNavigationBarColor: ColorManager.backgroundColor,
        systemNavigationBarIconBrightness: Brightness.dark,
        systemNavigationBarContrastEnforced: true,
        systemStatusBarContrastEnforced: true,
      ),
    );
  }

  @override
  void initState() {
    _setSystemUIOverlay();
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void didChangeMetrics() {
    if (View.of(context).viewInsets.bottom > 1) {
      setState(() {
        _isKeyboardVisible = true;
      });
      return;
    }
    if (View.of(context).viewInsets.bottom < 1) {
      setState(() {
        _isKeyboardVisible = false;
      });
      return;
    }
  }

  @override
  void dispose() {
    _revertSystemUIOverlay();
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  _switchToLogin() {
    Navigator.of(context).pushReplacementNamed(Routes.signIn);
  }

  void _submit() async {
    if (!_formKey.currentState!.validate()) return;
    _formKey.currentState!.save();
    try {
      final ref = await ApiService.registerUser(FormData.fromMap(NewUserController().registerInfo()));
      print(ref.data.toString());
      SnackBarService.showSuccessSnackBar();
    } on DioException catch (e) {
      log(e.response.toString());
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("error occured")));
    } catch (e) {
      print(e.toString());
      DialogService.closeDialog();
      PopUpService.showAuthenticationErrorDialog(message: e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          color: ColorManager.backgroundColor, 
          width: usableWidth,
          height: usableHeight,
          padding: EdgeInsets.symmetric(horizontal: usableHeight * (32 / 800)),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SpacingManager.h15,
              Center(
                child: Text(
                          LabelManager.payCOM,
                          style: PoppinsStyle.bold15.copyWith(color: ColorManager.darkBlue),
                        ),
              ),
                
                SpacingManager.h15,
                Text(LabelManager.join, style: PoppinsStyle.medium15.copyWith(color: ColorManager.darkBlue2)),
                SpacingManager.h22,
                Form(key: _formKey, child: const PersonalDetailsForm()),
                SpacingManager.h5,
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(StringManager.loginWarning, style: PoppinsStyle.bold10a.copyWith(color: ColorManager.darkBlue)),
                ),
                SizedBox(height: usableHeight * 0.0187),
                Align(
                    alignment: Alignment.centerLeft,
                    child: Text(StringManager.accountType, style: PoppinsStyle.b600.copyWith(color: ColorManager.darkBlue2))),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    UserTypeRadio(userType: UserType.user, icon: Icons.person_outline),
                    UserTypeRadio(userType: UserType.merchant, icon: Icons.account_balance_outlined),
                  ],
                ),
                Visibility(
                  visible: !_isKeyboardVisible,
                  child: Column(
                    children: [
                      SizedBox(height: usableHeight * 0.005),
                      Text(StringManager.termsandconditon, style: PoppinsStyle.bold10b.copyWith(color: ColorManager.darkBlue)),
                      SpacingManager.h26,
                      WideMainButton(function: _submit),
                      RichText(
                        text: TextSpan(
                          children: [
                            WidgetSpan(
                                child: Text(StringManager.alreadyHaveAnAccount, style: PoppinsStyle.bold6.copyWith(color: ColorManager.darkBlue))),
                            WidgetSpan(
                              child: GestureDetector(
                                onTap: _switchToLogin,
                                child: Text(LabelManager.signin, style: PoppinsStyle.bold6.copyWith(color: ColorManager.darkBlue, fontWeight: FontWeight.bold)),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

enum UserType {
  user,
  merchant;

  @override
  String toString() {
    final buffer = StringBuffer();
    buffer.write(name.characters.first.toUpperCase());
    buffer.write(name.replaceFirst(buffer.toString().toLowerCase(), ""));
    return buffer.toString();
  }
}

class UserTypeRadio extends StatefulWidget {
  const UserTypeRadio({required this.userType, required this.icon, super.key});
  final UserType userType;
  final IconData icon;
  @override
  State<UserTypeRadio> createState() => _UserTypeRadioState();
}

class _UserTypeRadioState extends State<UserTypeRadio> {
  bool get _isSelected {
    if (NewUserController().usertype == widget.userType) return true;
    return false;
  }

  Color get _background {
    if (_isSelected) return const Color(0xFFDAFFFB);
    return const Color(0xFFFFFFFF);
  }

  Color get _borderColor {
    if (_isSelected) return const Color(0xFF176B87);
    return const Color(0xFF64CCC5);
  }

  void _updateUserType() {
    setState(() {
      NewUserController().updateUserType = widget.userType;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _updateUserType,
      child: Container(
        width: usableWidth * (140 / 360),
        padding: EdgeInsets.symmetric(vertical: usableHeight * (11 / 800)),
        decoration: BoxDecoration(color: _background, border: Border.all(color: _borderColor), borderRadius: BorderRadius.circular(8)),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [Icon(widget.icon, size: 20), Text(widget.userType.toString())],
            ),
            Visibility(
                visible: _isSelected, child: const Positioned(top: 0, left: 7, child: CircleAvatar(radius: 3, backgroundColor: Color(0xFF001C30)))),
          ],
        ),
      ),
    );
  }
}
