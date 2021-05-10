import 'package:go_shop/model/banners/banners_model.dart';
import 'package:go_shop/network/api/api_constants.dart';
import '../api_client.dart';

class BannersServices {
  final _apiClient = ApiClient();

  Future<BannersModel> fetchAllBanners() async {
    try {
      final response = await _apiClient.get(
        ApiConstants.BANNERS_URL,
      );
      final result = BannersModel.fromJson(response);
      return result;
    } catch (error) {
      print(error);
    }
  }
}
