import 'package:flutter/cupertino.dart';
import 'package:go_shop/entities/snack_bar_entity.dart';
import 'package:go_shop/model/categories/categories_model.dart';
import 'package:go_shop/model/contact/contact_model.dart';
import 'package:go_shop/providers/providers.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class CategoryViewModel extends ChangeNotifier{
  final Reader reader;

  CategoryViewModel(this.reader);

  Future<CategoriesModel> loadCategories() async {

    final categoryServicesProvider = reader(categoryServiceProvider);
    final snackBarProvider = reader(snackBarStateProvider);
    final loadingProvider = reader(loadingStateProvider);

    final result = await categoryServicesProvider.fetchAllCategories();

    loadingProvider.state = false;

    if (result.status) {
      snackBarProvider.state = SnackBarEntity.success(message: "Success");
      return  result;
    } else {
      snackBarProvider.state = SnackBarEntity.error(message: "Fails");
    }

  }

}