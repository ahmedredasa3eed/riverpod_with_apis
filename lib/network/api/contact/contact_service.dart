import 'package:go_shop/model/contact/contact_model.dart';
import 'package:go_shop/network/api/api_constants.dart';
import '../api_client.dart';

class ContactService {
  final _apiClient = ApiClient();

  Future<ContactModel> fetchContact() async {
    try {
      final response = await _apiClient.get(
        ApiConstants.CONTACT_URL,
        headers: {
          'lang': 'ar',
          'Content-Type' : 'application/json',
        },
      );
      final result = ContactModel.fromJson(response);
      return result;
    } catch (error) {
      print(error);
    }
  }
}
