import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:go_shop/model/categories/categories_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:http/http.dart' as http;

import '../providers/providers.dart';

class CategoriesServices extends ChangeNotifier{

  Future<CategoriesModel> fetchAllCategories(BuildContext context) async {

    try {
      final url = Uri.parse('https://student.valuxapps.com/api/categories');
      final response = await http.get(url,
        headers: <String, String>{
          'lang': 'ar'
        },
      );
      if (response.statusCode == 200) {
        final result = json.decode(response.body);
        if (result.isNotEmpty) {
          if(result['status'] == true){
            context.read(categoriesResponseStatusProvider).state.status = result['status'];
            CategoriesModel loadedCategories = CategoriesModel.fromJson(result);
            return loadedCategories;
          }
          else{
            context.read(categoriesResponseStatusProvider).state.status = result['status'];
          }
        }
        }else{
        context.read(categoriesResponseStatusProvider).state.message = "Bad Response";
      }
    }
    catch (error) {
      print(error);
    }
  }

}