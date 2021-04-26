import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_shop/entities/snack_bar_entity.dart';
import 'package:go_shop/model/categories/categories_model.dart';
import 'package:go_shop/providers/providers.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class CategoriesViewModel extends ChangeNotifier {


  CategoriesModel _categories = CategoriesModel();
  CategoriesModel get categories => _categories;

  final Reader reader;
  CategoriesViewModel(this.reader);

  Future<CategoriesModel> loadCategories(BuildContext context) async {

    final snackBarProvider = reader(snackBarStateProvider);

    //read response status of API
    final categoriesResponseProviders = reader(categoriesResponseStatusProvider);
    final categoriesServicesProvider = reader(categoriesServiceProvider);


    // calling Api Categories Service
    _categories = await categoriesServicesProvider.fetchAllCategories(context);
    print(_categories.data.categoryItem[0].name);

    if (categoriesResponseProviders.state.status == true) {
      snackBarProvider.state = SnackBarEntity.success(
          message: 'تم تحميل الاقسام بنجاح');
      return _categories;

    } else {
      snackBarProvider.state = SnackBarEntity.error(
          message: categoriesResponseProviders.state.message);
    }
  }
}
