import 'package:flutter/material.dart';
import 'package:go_shop/providers/providers.dart';
import 'package:go_shop/utils/helper_functions.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class LoadingAndAlertWidget extends ConsumerWidget {
  @override
  Widget build(BuildContext context , watch) {
    final loadingProvider = watch(loadingStateProvider);
    final snackBarProvider = watch(snackBarStateProvider);

    if (snackBarProvider.state.showSnackBar) {
      HelperFunctions.showSnackBar(
        context: context,
        snackBarEntity: snackBarProvider.state,
      );
    }
    return loadingProvider.state
        ? Stack(
            children: [
              Container(
                color: Colors.black12,
              ),
              AlertDialog(
                scrollable: true,
                content: Row(
                  children: [
                    CircularProgressIndicator(),
                    SizedBox(
                      width: 24,
                    ),
                    Text('Loading...'),
                  ],
                ),
              ),
            ],
          )
        : SizedBox.shrink();
  }
}
