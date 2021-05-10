import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:go_shop/model/categories/categories_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_shop/model/response_model.dart';
import 'package:go_shop/network/api/api_constants.dart';
import 'api/api_client.dart';

class CategoriesServices {
  final _apiClient = ApiClient();

  Future<ResponseModel<CategoryModel>>
  fetchAllCategories() async {
    try {
      final response = await _apiClient.get(
        ApiConstants.CATEGORIES_URL,
        headers: {'lang': 'ar'},
      );
      final result = ResponseModel<CategoryModel>.fromJson(response,
          (data) => data == null ? null : CategoryModel.fromJson(response));
      return result;
    } catch (error) {
      return error;
    }
  }
}
