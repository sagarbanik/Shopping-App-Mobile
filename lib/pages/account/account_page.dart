import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shopping_app/base/custom_loader.dart';
import 'package:shopping_app/controller/auth_controller.dart';
import 'package:shopping_app/controller/cart_controller.dart';
import 'package:shopping_app/controller/user_controller.dart';
import 'package:shopping_app/routes/route_helper.dart';
import 'package:shopping_app/utils/colors.dart';
import 'package:shopping_app/utils/dimentions.dart';
import 'package:shopping_app/widgets/account_widget.dart';
import 'package:shopping_app/widgets/app_icon.dart';
import 'package:shopping_app/widgets/big_text.dart';
import 'package:get/get.dart';

class AccountPage extends StatelessWidget {
  const AccountPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    bool isUserLoggedIn = Get.find<AuthController>().isUserLoggedIn();
    if(isUserLoggedIn){
      Get.find<UserController>().getUserInfo();
      print('Already logged in!');
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.mainColor,
        title: BigText(
          text: 'Profile',
          size: 24,
          color: Colors.white,
        ),
      ),
      body: GetBuilder<UserController>(builder: (userController){

        print(userController.isLoading.toString());

        return isUserLoggedIn ? (userController.isLoading ? Container(
          width: double.maxFinite,
          margin: EdgeInsets.only(top: Dimensions.height20),
          child: Column(
            children: [
              //Profile Icon
              AppIcon(
                icon: Icons.person,
                backgroundColor: AppColors.mainColor,
                iconColor: Colors.white,
                iconSize: Dimensions.height15*5,
                size: Dimensions.height15*10,
              ),
              SizedBox(height: Dimensions.height30),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      //User Name
                      AccountWidget(
                        appIcon: AppIcon(
                          icon: Icons.person,
                          backgroundColor: AppColors.mainColor,
                          iconColor: Colors.white,
                          iconSize: Dimensions.height10*5/2,
                          size: Dimensions.height10*5,
                        ),
                        bigText: BigText(
                          text: userController.userModel.name,
                        ),
                      ),
                      SizedBox(height: Dimensions.height10),
                      //Phone
                      AccountWidget(
                        appIcon: AppIcon(
                          icon: Icons.phone,
                          backgroundColor: AppColors.yellowColor,
                          iconColor: Colors.white,
                          iconSize: Dimensions.height10*5/2,
                          size: Dimensions.height10*5,
                        ),
                        bigText: BigText(
                          text: userController.userModel.phone,
                        ),
                      ),
                      SizedBox(height: Dimensions.height10),
                      //Email
                      AccountWidget(
                        appIcon: AppIcon(
                          icon: Icons.alternate_email_outlined,
                          backgroundColor: Colors.pink,
                          iconColor: Colors.white,
                          iconSize: Dimensions.height10*5/2,
                          size: Dimensions.height10*5,
                        ),
                        bigText: BigText(
                          text: userController.userModel.email,
                        ),
                      ),
                      SizedBox(height: Dimensions.height10),
                      //Address
                      AccountWidget(
                        appIcon: AppIcon(
                          icon: Icons.location_on,
                          backgroundColor: Colors.blueAccent,
                          iconColor: Colors.white,
                          iconSize: Dimensions.height10*5/2,
                          size: Dimensions.height10*5,
                        ),
                        bigText: BigText(
                          text: 'Address',
                        ),
                      ),
                      SizedBox(height: Dimensions.height10),
                      //Logout
                      GestureDetector(
                        onTap: (){
                          if(Get.find<AuthController>().isUserLoggedIn()){
                            Get.find<AuthController>().clearSharedData();
                            Get.find<CartController>().clear();
                            Get.find<CartController>().clearCartHistory();
                            Get.offNamed(RouteHelper.getSignInPage());
                          }else{
                            print('You are already logged out!');
                          }

                        },
                        child: AccountWidget(
                          appIcon: AppIcon(
                            icon: Icons.logout_rounded,
                            backgroundColor: Colors.green,
                            iconColor: Colors.white,
                            iconSize: Dimensions.height10*5/2,
                            size: Dimensions.height10*5,
                          ),
                          bigText: BigText(
                            text: 'Logout',
                          ),
                        ),
                      ),
                      SizedBox(height: Dimensions.height10),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ) : CustomLoader()) : Container(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: double.maxFinite,
                  height: Dimensions.height20*10,
                  margin: EdgeInsets.symmetric(horizontal: Dimensions.width20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(Dimensions.radius20),
                    image: const DecorationImage(
                        fit: BoxFit.contain,
                        image: AssetImage(
                            'assets/image/circle_icon.png'
                        ),
                    ),
                  ),
                ),
                SizedBox(height: Dimensions.height10),
                GestureDetector(
                  onTap: (){
                    Get.toNamed(RouteHelper.getSignInPage());
                  },
                  child: Container(
                    width: double.maxFinite,
                    height: Dimensions.height20*4,
                    margin: EdgeInsets.symmetric(horizontal: Dimensions.width20),
                    decoration: BoxDecoration(
                      color: AppColors.mainColor,
                      borderRadius: BorderRadius.circular(Dimensions.radius20),
                    ),
                    child: Center(
                      child: BigText(
                        text: "Sign in",
                        color: Colors.white,
                        size: Dimensions.font26,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
