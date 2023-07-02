import 'dart:async';

import 'package:flutter/material.dart';

import '../../../core/global_variables.dart';


class LoginData with ChangeNotifier {
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  void startLogin() {
    _isLoading = true;
    notifyListeners();

    // Simulating a login process
    Timer(const Duration(seconds: 30), () {
      _isLoading = false;
      notifyListeners();
      _showSuccessDialog();
    });
  }

  void _showSuccessDialog() {
    showDialog(
      context: navigatorKey.currentContext!,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Success'),
          content: const Text('Login successful.'),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }
}
