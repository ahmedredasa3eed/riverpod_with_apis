import 'package:flutter/cupertino.dart';
import 'package:go_shop/entities/snack_bar_entity.dart';
import 'package:go_shop/model/banners/banners_model.dart';
import 'package:go_shop/model/categories/categories_model.dart';
import 'package:go_shop/model/contact/contact_model.dart';
import 'package:go_shop/providers/providers.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class BannersViewModel extends ChangeNotifier{
  final Reader reader;

  BannersViewModel(this.reader);

  Future<BannersModel> loadBanners() async {

    final bannersServicesProvider = reader(bannersServiceProvider);
    final snackBarProvider = reader(snackBarStateProvider);
    final loadingProvider = reader(loadingStateProvider);

    final result = await bannersServicesProvider.fetchAllBanners();

    loadingProvider.state = false;

    if (result.status) {
      snackBarProvider.state = SnackBarEntity.success(message: "Banners Loaded Successfully");
      return  result;
    } else {
      snackBarProvider.state = SnackBarEntity.error(message: "Fails");
    }

  }

}