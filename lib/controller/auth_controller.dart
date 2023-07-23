import 'package:get/get.dart';
import 'package:shopping_app/data/repository/auth_repo.dart';
import 'package:shopping_app/models/response_model.dart';

import '../models/signup_body_model.dart';

class AuthController extends GetxController implements GetxService{
  final AuthRepo authRepo;

  AuthController({
    required this.authRepo
  });

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  Future<ResponseModel> registration(SignUpBody body) async {
    _isLoading = true;
    update();
    Response response = await authRepo.registration(body);
    late ResponseModel responseModel;
    if(response.statusCode == 200){
      authRepo.saveUserToken(response.body["token"]);
      responseModel = ResponseModel(true, response.body["token"]);
    }else{
      responseModel = ResponseModel(false, response.statusText!);
    }
    _isLoading = false;
    update();
    return responseModel;
  }

  Future<ResponseModel> login(String email,String password) async {
    _isLoading = true;
    update();

    Response response = await authRepo.login(email,password);
    late ResponseModel responseModel;
    if(response.statusCode == 200){
      authRepo.saveUserToken(response.body["token"]);
      responseModel = ResponseModel(true, response.body["token"]);
    }else{
      responseModel = ResponseModel(false, response.statusText!);
    }
    _isLoading = false;
    update();
    return responseModel;
  }

  void saveUserPhoneAndPassword(String phone,String password){
    authRepo.saveUserPhoneAndPassword(phone, password);
  }

  bool isUserLoggedIn(){
    return authRepo.isUserLoggedIn();
  }

  bool clearSharedData(){
    return authRepo.clearSharedData();
  }

}