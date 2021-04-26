import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_shop/entities/snack_bar_entity.dart';
import 'package:go_shop/providers/providers.dart';
import 'package:go_shop/utils/page_router.dart';
import 'package:go_shop/view/screens/home_view.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../utils/enums.dart';


class LoginViewModel extends ChangeNotifier {
  final Reader reader;

  LoginViewModel(this.reader);

  Future<void> login(
      {@required String email, @required String password, @required BuildContext context}) async {
    reader(userAuthNotifier).login(email, password,context);

    final snackBarProvider = reader(snackBarStateProvider);
    final loadingProvider = reader(loadingStateProvider);
    final loginAuthStatus = reader(userAuthStatusProvider);

    if (email.isEmpty || password.isEmpty) {
      print(loginAuthStatus.state.message);
      snackBarProvider.state = SnackBarEntity.error(
          message: loginAuthStatus.state.message ?? "Fill All inputs");
      return;
    }
    loadingProvider.state = true;

    // calling Api Login Service
    await reader(userAuthNotifier).login(email, password,context);

    if (loginAuthStatus.state.status == true) {
      print("Token is  : ${loginAuthStatus.state.userData.token}");
      PageRouter.pushReplacementScreen(
        context: context,
        transition: AppTransition.bottom_to_top,
        screen: HomeView(),
      );

      loadingProvider.state = false;
      snackBarProvider.state = SnackBarEntity.success(
          message: loginAuthStatus.state.message);
    }
    else{
      loadingProvider.state = false;
      snackBarProvider.state = SnackBarEntity.error(
          message: loginAuthStatus.state.message);
    }
  }
}
