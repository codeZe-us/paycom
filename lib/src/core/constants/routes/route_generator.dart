import 'package:flutter/material.dart';
import 'package:paycom/src/core/constants/routes/routes.dart';
import 'package:paycom/src/view/screens/auth/sign_up_screen.dart';

import '../../../view/screens/auth/sign_in_screen.dart';


class RouteGenerator {
  static Route? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      /*case Routes.splashScreen:
        return MaterialPageRoute(builder: (context) => const SplashScreen(key: ValueKey(Routes.splashScreen)), settings: settings);*/
        case Routes.signUp:
        return MaterialPageRoute(builder: (context) => const SignUpScreen(key: ValueKey(Routes.signUp)), settings: settings);
      case Routes.signIn:
        return MaterialPageRoute(builder: (context) => const SignIn(key: ValueKey(Routes.signIn)), settings: settings);
      default:
        return null;
    }
  }

  static Route unKnownRoute(_) {
    return MaterialPageRoute(
      builder: (context) => const Scaffold(
        body: Center(child: Text("Page Not Found")),
      ),
    );
  }
}
