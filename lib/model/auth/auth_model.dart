

import 'package:go_shop/model/auth/user_model.dart';

class Auth{
  bool status;
  String message;
  UserData userData;

  Auth({this.status, this.message,this.userData});
}