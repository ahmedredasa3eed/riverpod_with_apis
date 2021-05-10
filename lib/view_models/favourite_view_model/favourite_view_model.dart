import 'package:flutter/cupertino.dart';
import 'package:go_shop/entities/snack_bar_entity.dart';
import 'package:go_shop/model/favourite/favourite_model.dart';
import 'package:go_shop/providers/providers.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class FavouriteViewModel extends ChangeNotifier{
  final Reader reader;

  FavouriteViewModel(this.reader);

  Future<FavouriteModel> loadFavourites() async {

    final favouriteServicesProvider = reader(favouriteServiceProvider);
    final snackBarProvider = reader(snackBarStateProvider);
    final loadingProvider = reader(loadingStateProvider);

    final result = await favouriteServicesProvider.fetchFavourite();

    loadingProvider.state = false;

    if (result.status) {
      snackBarProvider.state = SnackBarEntity.success(message: "Success");
      notifyListeners();
      return  result;
    } else {
      snackBarProvider.state = SnackBarEntity.error(message: "Fails");
    }

  }

  Future<FavouriteModel> addAndDeleteFromFavourites(int productId) async {

    final favouriteServicesProvider = reader(favouriteServiceProvider);
    final snackBarProvider = reader(snackBarStateProvider);
    final loadingProvider = reader(loadingStateProvider);

    loadingProvider.state = true;

    final result = await favouriteServicesProvider.addAndDeleteFavourite(productId);

    loadingProvider.state = false;

    if (result.status) {
      notifyListeners();
      snackBarProvider.state = SnackBarEntity.success(message: result.message);
      return result;
    } else {
      snackBarProvider.state = SnackBarEntity.error(message: result.message);
      notifyListeners();
    }

  }

}