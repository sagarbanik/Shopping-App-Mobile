import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shopping_app/utils/constants.dart';

class ApiClient extends GetConnect implements GetxService{
  late String token;
  final String appBaseUrl;

  late Map<String,String> _mainHeader;
  late SharedPreferences preferences;

  ApiClient({required this.appBaseUrl,required this.preferences}){
    baseUrl = appBaseUrl;
    timeout = const Duration(seconds: 30);
    token = preferences.getString(Constants.TOKEN) ?? "";
    //token = '';
    _mainHeader = {
      'Content-type' : 'application/json; charset=UTF-8',
      'Authorization' : 'Bearer $token',
    };
  }

  void updateHeader(String token){
    _mainHeader = {
      'Content-type' : 'application/json; charset=UTF-8',
      'Authorization' : 'Bearer $token',
    };
  }

  Future<Response> getData(String url, {Map<String, String>? headers}) async{
    try{
      Response response = await get(
        url,
        headers: headers ?? _mainHeader
      );
      return response;
    }catch(e){
      return Response(statusCode: 1,statusText: e.toString());
    }
  }

  Future<Response> postData(String uri, dynamic body) async{
    try{
      Response response = await post(uri, body,headers: _mainHeader);
      return response;
    }catch(e){
      print(e.toString());
      return Response(statusCode: 1,statusText: e.toString());
    }
  }

}