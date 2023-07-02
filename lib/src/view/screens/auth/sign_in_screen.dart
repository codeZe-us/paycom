import 'package:dio/dio.dart';
import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:paycom/src/services/api_service.dart';
import 'package:paycom/src/viewmodel/auth/providers/loading_provider.dart';
import 'package:paycom/src/viewmodel/controllers/new_user_controller.dart';

import '../../../core/constants/managers/color_manager.dart';
import '../../../core/constants/managers/label_manager.dart';
import '../../../core/constants/managers/spacing_manager.dart';
import '../../../core/constants/managers/string_manager.dart';
import '../../../core/constants/routes/routes.dart';
import '../../../core/constants/text_styles/poppins_style.dart';
import '../../../core/global_variables.dart';
import '../../../services/dialoge_services.dart';
import '../../../services/pop_up_services.dart';
import '../../../services/snackbar_services.dart';
import '../../widgets/auth/personal_details_form2.dart';
import '../../widgets/elements/wide_main_button.dart';

class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> with WidgetsBindingObserver {
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

  _switchToSignUp() {
    Navigator.of(context).pushReplacementNamed(Routes.signUp);
  }

  void _submit() async {
    var response;
    print("pressed");
    if (!_formKey.currentState!.validate()) return;
    _formKey.currentState!.save();
    try {
      print("api call");
      final ref = await ApiService.loginUser(FormData.fromMap(NewUserController().loginInfo()));
      SnackBarService.showSuccessSnackBar();
      print(ref.data.toString());
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
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: ColorManager.backgroundColor,
          elevation: 0,
          title: Text(
            LabelManager.payCOM,
            style: PoppinsStyle.bold15.copyWith(color: ColorManager.darkBlue),
          ),
        ),
        body: Container(
          width: usableWidth,
          padding: EdgeInsets.symmetric(horizontal: usableHeight * (32 / 800)),
          child: Column(
            children: [
              SpacingManager.h15,
              Text(
                LabelManager.welcome,
                style: PoppinsStyle.medium15.copyWith(color: ColorManager.darkBlue2),
              ),
              SpacingManager.h22,
              Form(key: _formKey, child: const PersonalDetailsForm2()),
              SpacingManager.h5,
              Align(
                alignment: Alignment.centerRight,
                child: Text(StringManager.forgottenPassword,
                    style: PoppinsStyle.bold10a.copyWith(color: ColorManager.darkBlue, fontWeight: FontWeight.bold)),
              ),
              SizedBox(height: usableHeight * 0.03),
              Visibility(visible: !_isKeyboardVisible,
                child: Column(
                  children: [
                    WideMainButton2(function: _submit),
                    SpacingManager.h26,
                    RichText(
                      text: TextSpan(
                        children: [
                          WidgetSpan(child: Text(StringManager.dontHaveAnAcoount, style: PoppinsStyle.bold6.copyWith(color: ColorManager.darkBlue))),
                          WidgetSpan(
                            child: GestureDetector(
                              onTap: _switchToSignUp,
                              child: Text(LabelManager.register,
                                  style: PoppinsStyle.bold6.copyWith(color: ColorManager.darkBlue, fontWeight: FontWeight.bold)),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
