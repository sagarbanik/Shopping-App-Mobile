import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shopping_app/data/api/api_client.dart';
import 'package:shopping_app/models/signup_body_model.dart';
import 'package:shopping_app/utils/constants.dart';

class AuthRepo{
  final ApiClient apiClient;
  final SharedPreferences preferences;

  AuthRepo({
    required this.apiClient,
    required this.preferences
  });

  Future<Response> registration(SignUpBody body) async{
    return await apiClient.postData(Constants.REGISTRATION_URL, body.toJson());
  }

  Future<Response> login(String email, String password) async{
    return await apiClient.postData(Constants.LOGIN_URL, {"email":email,"password":password});
  }

  Future<bool> saveUserToken(String token) async {
    print("saveUserToken :"+token);
    apiClient.token = token;
    apiClient.updateHeader(token);

    return await preferences.setString(Constants.TOKEN, token);
  }

  Future<void> saveUserPhoneAndPassword(String phone,String password) async{
    try{
      await preferences.setString(Constants.PHONE, phone);
      await preferences.setString(Constants.PASSWORD, password);
    }catch(e){
      throw e;
    }
  }

  Future<String> getUserToken() async {
    return await preferences.getString(Constants.TOKEN) ?? 'None';
  }

  bool isUserLoggedIn(){
    return preferences.containsKey(Constants.TOKEN);
  }

  bool clearSharedData(){
    preferences.remove(Constants.TOKEN);
    preferences.remove(Constants.PASSWORD);
    preferences.remove(Constants.PHONE);
    apiClient.token='';
    apiClient.updateHeader('');
    return true;
  }



}