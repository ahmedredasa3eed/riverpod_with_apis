import 'package:go_shop/model/products/product_details_model.dart';
import 'package:go_shop/model/products/products_model.dart';
import 'package:go_shop/network/api/api_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../api_client.dart';

class ProductsService {
  final _apiClient = ApiClient();

  Future<ProductsModel> fetchProductsByCategoryId(int id) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    final token = preferences.getString('token');
    try {
      final response = await _apiClient.get(
        ApiConstants.PRODUCTS_URL,
        parameters: {
          'category_id' : '$id',
        },
        headers: {
          'lang': 'ar',
          'Content-Type' : 'application/json',
          'Authorization':'$token',
        },
      );
      final result = ProductsModel.fromJson(response);
      return result;
    } catch (error) {
      print(error);
    }
  }

  Future<ProductDetailsModel> fetchProductsDetails(int id) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    final token = preferences.getString('token');
    try {
      final response = await _apiClient.get(
        ApiConstants.PRODUCTS_URL+'/$id',
        headers: {
          'lang': 'ar',
          'Content-Type' : 'application/json',
          'Authorization':'$token',
        },
      );
      final result = ProductDetailsModel.fromJson(response);
      return result;
    } catch (error) {
      print(error);
    }
  }
}
