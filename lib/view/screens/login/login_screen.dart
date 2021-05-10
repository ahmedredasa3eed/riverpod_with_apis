import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:easy_localization/easy_localization.dart' as lang;
import 'package:go_shop/style/app_colors.dart';
import 'package:go_shop/style/app_padding.dart';
import 'package:go_shop/style/decorations.dart';
import 'package:go_shop/utils/enums.dart';
import 'package:go_shop/utils/helper_functions.dart';
import 'package:go_shop/utils/images.dart';
import 'package:go_shop/style/text_styles.dart';
import 'package:go_shop/view/screens/login/widgets/middle_buttons.dart';
import 'package:go_shop/view/widgets/loading_alert_widget.dart';
import 'package:go_shop/view/widgets/auth_bar_title.dart';
import 'package:go_shop/view/widgets/auth_divider.dart';
import 'package:go_shop/view/widgets/circle_button.dart';
import 'package:go_shop/view/widgets/email_field.dart';
import 'package:go_shop/view/widgets/password_field.dart';

class LoginScreen extends StatefulWidget {

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final emailNode = FocusNode();
  final passwordNode = FocusNode();

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
    emailNode.dispose();
    passwordNode.dispose();
  }
  @override
  Widget build(BuildContext context) {
    //final emailController = useTextEditingController();
    //final passwordController = useTextEditingController();
    //final emailNode = useFocusNode();
    //final passwordNode = useFocusNode();

    return Stack(
      children: [
        Directionality(
          textDirection: HelperFunctions.isEnglish(context)
              ? TextDirection.ltr
              : TextDirection.rtl,
          child: GestureDetector(
            onTap: () {
              emailNode.unfocus();
              passwordNode.unfocus();
            },
            child: Scaffold(
              resizeToAvoidBottomInset: false,
              body: Container(
                decoration: Decorations.authDecoration,
                child: Scaffold(
                  backgroundColor: Colors.transparent,
                  body: ListView(
                    padding: AppPadding.padding24v26h,
                    children: [
                      // TODO: app bar title
                      AuthAppBarTitle(title: lang.tr('login')),
                      // TODO: form
                      Column(
                        children: [
                          EmailField(
                            emailController: emailController,
                            emailNode: emailNode,
                            nextNode: passwordNode,
                          ),
                          PasswordField(
                            passwordController: passwordController,
                            passwordNode: passwordNode,
                          ),
                        ],
                      ),
                      // TODO: Buttons
                      MiddleButtons(
                        emailController: emailController,
                        passwordController: passwordController,
                        emailNode: emailNode,
                        passwordNode: passwordNode,
                        authType: AuthType.login,
                      ),
                      // TODO: Forgot Password
                      SizedBox(
                        height: 19.h,
                      ),
                      // TODO: Forgot Text
                      Center(
                        child: InkWell(
                          onTap: () {},
                          child: Text(
                            'did_you_forget_password',
                            style: TextStyles.style14SBB,
                          ).tr(),
                        ),
                      ),
                      AuthDivider(),
                      // TODO: Register Text
                      Center(
                        child: Text(
                          'you_can_subscribe_here',
                          style: TextStyles.style16SBB,
                        ).tr(),
                      ),
                      SizedBox(
                        height: 16.h,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CircleButton(
                            onPressed: () {},
                            color: AppColors.googleColor,
                            icon: Images.googleIcon,
                          ),
                          SizedBox(
                            width: 26.w,
                          ),
                          CircleButton(
                            onPressed: () {},
                            color: AppColors.facebookColor,
                            icon: Images.facebookIcon,
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
        LoadingAndAlertWidget(),
      ],
    );
  }
}
