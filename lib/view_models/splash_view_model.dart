import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_shop/utils/page_router.dart';
import 'package:go_shop/view/screens/login/login_screen.dart';
import '../utils/enums.dart';


class SplashChangeNotifier extends ChangeNotifier {
  init(BuildContext context) {
    Future.delayed(const Duration(seconds: 3), () {
      PageRouter.pushReplacementScreen(
        context: context,
        transition: AppTransition.zoom,
        screen: LoginScreen(),
      );
    });
  }
}
