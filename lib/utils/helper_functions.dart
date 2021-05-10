import 'package:flutter/material.dart';
import 'package:go_shop/entities/snack_bar_entity.dart';
import 'package:go_shop/providers/providers.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:easy_localization/easy_localization.dart';
import 'enums.dart';

class HelperFunctions {

  const HelperFunctions._();

  static bool isEnglish(BuildContext context) =>
      context.fallbackLocale.languageCode == 'en';

  static showSnackBar({
    @required BuildContext context,
    @required SnackBarEntity snackBarEntity,
  }) {
    WidgetsBinding.instance.addPostFrameCallback(
          (_) {
        ScaffoldMessenger.of(context).removeCurrentSnackBar();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: snackBarEntity.status == SnackBarStatus.error
                ? Colors.red
                : Colors.green,
            content: Text(
              snackBarEntity.message,
              style: TextStyle(color: Colors.white),
            ),
            duration: const Duration(seconds: 1),
          ),
        );
        context.read(snackBarStateProvider).state = SnackBarEntity.reset();
      },
    );
  }
}
