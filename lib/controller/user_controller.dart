import 'package:get/get.dart';
import 'package:shopping_app/data/repository/auth_repo.dart';
import 'package:shopping_app/data/repository/user_repo.dart';
import 'package:shopping_app/models/response_model.dart';

import '../models/signup_body_model.dart';
import '../models/user_model.dart';

class UserController extends GetxController implements GetxService{
  final UserRepo userRepo;

  UserController({
    required this.userRepo
  });

  bool _isLoading = false;
  late UserModel _userModel;

  bool get isLoading => _isLoading;
  UserModel get userModel => _userModel;

  Future<ResponseModel> getUserInfo() async {

    Response response = await userRepo.getUserInfo();
    print("Response" + response.body.toString());
    late ResponseModel responseModel;
    if(response.statusCode == 200){
      _userModel = UserModel.fromJson(response.body);
      _isLoading = true ;
      responseModel = ResponseModel(true, 'Success');
    }else{
      responseModel = ResponseModel(false, response.statusText!);
    }

    update();
    return responseModel;
  }

}