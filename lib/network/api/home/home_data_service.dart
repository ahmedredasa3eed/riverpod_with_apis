import 'package:go_shop/model/home/home_data_model.dart';
import 'package:go_shop/network/api/api_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'api/api_client.dart';

class HomeDataServices {
  final _apiClient = ApiClient();

  Future<HomeDataModel> fetchHomeData() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    final token = preferences.getString('token');
    try {
      final response = await _apiClient.get(
        ApiConstants.HOME_DATA_URL,
        headers: {
          'lang': 'ar',
          'Content-Type' : 'application/json',
          'Authorization':'$token',
        },
      );
      final result = HomeDataModel.fromJson(response);
      return result;
    } catch (error) {
      print(error);
    }
  }
}
