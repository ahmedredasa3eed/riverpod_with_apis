import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:go_shop/style/app_colors.dart';
import 'package:go_shop/utils/enums.dart';
import 'package:go_shop/utils/helper_functions.dart';
import 'package:go_shop/utils/page_router.dart';
import 'package:go_shop/style/text_styles.dart';
import 'package:go_shop/view/screens/register/register.dart';
import 'package:go_shop/view/widgets/custom_button.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../providers/providers.dart';

class MiddleButtons extends HookWidget {
  final AuthType authType;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final FocusNode emailNode;
  final FocusNode passwordNode;

  const MiddleButtons({
    Key key,
    this.authType,
    this.emailNode,
    this.passwordNode,
    this.passwordController,
    this.emailController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 40.w,
      ),
      child: Row(
        children: [
          // TODO: New Register Button
          Expanded(
            child: CustomButton(
              onPressed: () {

                if (authType == AuthType.register) {
                  // Get.off(() => RegisterPage());
                  PageRouter.pushReplacementScreen(
                      context: context, screen: RegisterView());
                  print("register button clicked");
                }
              },
              title: tr('new_register'),
              color: authType == AuthType.login
                  ? Colors.white
                  : AppColors.secondaryColor,
              hasBorder: true,
              verticalPadding: 8.h,
              horizontalPadding: 12.w,
              hasRightRadius: HelperFunctions.isEnglish(context) ? false : true,
              hasLeftRadius: HelperFunctions.isEnglish(context) ? true : false,
              textStyle: TextStyles.style16SBB.copyWith(
                color: authType == AuthType.login
                    ? AppColors.secondaryColor
                    : Colors.white,
              ),
            ),
          ),
          // TODO: Enter Button
          Expanded(
            child: CustomButton(
              onPressed: () {
                if (authType == AuthType.login) {
                  emailNode.unfocus();
                  passwordNode.unfocus();
                  context.read(authViewModelProvider).login(
                        email: emailController.text,
                        password: passwordController.text,
                        context: context,
                      );
                }
              },
              title: tr('login'),
              color: authType == AuthType.login
                  ? AppColors.secondaryColor
                  : Colors.white,
              hasBorder: true,
              verticalPadding: 8.h,
              horizontalPadding: 12.w,
              hasRightRadius: HelperFunctions.isEnglish(context) ? true : false,
              hasLeftRadius: HelperFunctions.isEnglish(context) ? false : true,
              textStyle: TextStyles.style16SBB.copyWith(
                color: authType == AuthType.login
                    ? Colors.white
                    : AppColors.secondaryColor,
              ),
            ),
          )
        ],
      ),
    );
  }
}
