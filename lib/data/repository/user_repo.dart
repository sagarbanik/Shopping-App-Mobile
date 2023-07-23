import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shopping_app/data/api/api_client.dart';
import 'package:shopping_app/utils/constants.dart';

class UserRepo{
  final ApiClient apiClient;

  UserRepo({required this.apiClient});

  Future<Response> getUserInfo() async{
    return await apiClient.getData(Constants.USER_INFO_URL);
  }

}