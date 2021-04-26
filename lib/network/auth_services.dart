import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_shop/model/auth/user_model.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../providers/providers.dart';


class AuthServices extends ChangeNotifier{

  Future<void> login(String email, String password,BuildContext context) async {

    try {

      final url = Uri.parse('https://student.valuxapps.com/api/login');
      final response = await http.post(url,
        headers: <String, String>{
          'Content-Type': 'application/json',
          'lang': 'ar'
        },
        body: jsonEncode(<String, String>{
          'email': email,
          'password': password
        }),
      );
      if (response.statusCode == 200) {
        final result = json.decode(response.body);

        if (result != null) {
          if (result['status'] == true) {
            context.read(userAuthStatusProvider).state.status = result['status'];
            context.read(userAuthStatusProvider).state.message = result['message'];
            context.read(userAuthStatusProvider).state.userData = UserData.fromJson(result['data']);
            final token = result['data']['token'];
            print(token);
            SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
            sharedPreferences.setString('token', token);

          }
          else {
            context.read(userAuthStatusProvider).state.status = result['status'];
            context.read(userAuthStatusProvider).state.message = result['message'];

          }
        }
      }
    }
    catch (error) {
      print(error);
    }
  }



}