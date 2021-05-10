import 'package:flutter/cupertino.dart';
import 'package:go_shop/entities/snack_bar_entity.dart';
import 'package:go_shop/model/auth_model/user_model.dart';
import 'package:go_shop/model/home/home_data_model.dart';
import 'package:go_shop/providers/providers.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class HomeDataViewModel extends ChangeNotifier{
  final Reader reader;

  HomeDataViewModel(this.reader);

  Future<HomeDataModel> loadHomeData() async {

    final homeServicesProvider = reader(homeServiceProvider);
    final snackBarProvider = reader(snackBarStateProvider);
    final loadingProvider = reader(loadingStateProvider);

    final result = await homeServicesProvider.fetchHomeData();

    loadingProvider.state = false;

    if (result.status) {
      snackBarProvider.state = SnackBarEntity.success(message: "Success");
      return  result;
    } else {
      snackBarProvider.state = SnackBarEntity.error(message: "Fails");
    }

  }

}