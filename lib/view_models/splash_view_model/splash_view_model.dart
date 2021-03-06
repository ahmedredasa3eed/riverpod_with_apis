import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_shop/utils/page_router.dart';
import 'package:go_shop/view/screens/categories/categories_screen.dart';
import 'package:go_shop/view/screens/login/login_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../utils/enums.dart';


class SplashScreenViewModel extends ChangeNotifier {
  init(BuildContext context) {
    Future.delayed(const Duration(seconds: 3), () async{
      SharedPreferences preferences =  await SharedPreferences.getInstance();
      if(preferences.getString('token') != null){
        print(preferences.getString('token'));
        PageRouter.pushReplacementScreen(
          context: context,
          transition: AppTransition.bottom_to_top,
          screen: CategoriesScreen(),);
      }
      else{
        PageRouter.pushReplacementScreen(
          context: context,
          transition: AppTransition.bottom_to_top,
          screen: LoginScreen(),);
      }
    });
  }
}
