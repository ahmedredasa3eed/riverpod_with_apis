import 'package:flutter/cupertino.dart';
import 'package:go_shop/entities/snack_bar_entity.dart';
import 'package:go_shop/model/products/product_details_model.dart';
import 'package:go_shop/model/products/products_model.dart';
import 'package:go_shop/providers/providers.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ProductsViewModel extends ChangeNotifier{
  final Reader reader;

  ProductsViewModel(this.reader);

  Future<ProductsModel> loadProductsByCategory(int id) async {

    final productsServicesProvider = reader(productServiceProvider);
    final snackBarProvider = reader(snackBarStateProvider);
    final loadingProvider = reader(loadingStateProvider);

    final result = await productsServicesProvider.fetchProductsByCategoryId(id);

    loadingProvider.state = false;

    if (result.status) {
      snackBarProvider.state = SnackBarEntity.success(message: "Products Loaded Successfully");
      return result;

    } else {
      snackBarProvider.state = SnackBarEntity.error(message: "Fails");
    }

  }

  Future<ProductDetailsModel> loadProductsDetails(int id) async {

    final productsServicesProvider = reader(productServiceProvider);
    final snackBarProvider = reader(snackBarStateProvider);
    final loadingProvider = reader(loadingStateProvider);

    final result = await productsServicesProvider.fetchProductsDetails(id);

    loadingProvider.state = false;

    if (result.status) {
      snackBarProvider.state = SnackBarEntity.success(message: "Product Details Loaded");
      return result;

    } else {
      snackBarProvider.state = SnackBarEntity.error(message: result.message);
    }

  }


}