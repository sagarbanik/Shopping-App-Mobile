import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopping_app/base/custom_loader.dart';
import 'package:shopping_app/pages/auth/sign_up_page.dart';
import 'package:shopping_app/routes/route_helper.dart';
import 'package:shopping_app/utils/colors.dart';
import 'package:shopping_app/utils/dimentions.dart';
import 'package:shopping_app/widgets/app_text_field.dart';
import 'package:shopping_app/widgets/big_text.dart';

import '../../base/show_custom_snakebar.dart';
import '../../controller/auth_controller.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {

  var emailController = TextEditingController();
  var passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {

    void login(AuthController authController){

      String email = emailController.text.trim();
      String password = passwordController.text.trim();

      if(email.isEmpty){
        showCustomSnakebar(
            'Type in your email',
            title: "Email"
        );
      }else if(!GetUtils.isEmail(email)){
        showCustomSnakebar(
            'Type a valid email address',
            title: "Invalid Email"
        );
      }else if(password.isEmpty){
        showCustomSnakebar(
            'Type in your password',
            title: "Password"
        );
      }else if(password.length<6){
        showCustomSnakebar(
            'Password can\'t be less than six characters',
            title: "Password"
        );
      }else{
        authController.login(email,password).then((status){
          if(status.isSuccess){
            Get.toNamed(RouteHelper.getInitial());
          }else{
            showCustomSnakebar(status.message);
          }
        });

      }
    }

    return Scaffold(
        backgroundColor: Colors.white,
        body: GetBuilder<AuthController>(builder: (authController){
          return !authController.isLoading ? SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
              children: [
                SizedBox(height: Dimensions.height30),
                //App logo
                Container(
                  height: Dimensions.screenHeight*0.25,
                  child: const Center(
                    child: CircleAvatar(
                      backgroundColor: Colors.white,
                      radius: 80,
                      backgroundImage: AssetImage(
                          'assets/image/logo part 1.png'
                      ),
                    ),
                  ),
                ),
                //Welcome
                Container(
                  width: double.maxFinite,
                  margin: EdgeInsets.only(
                      left: Dimensions.width20
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Hello',
                        style: TextStyle(
                            fontSize: Dimensions.font20*3,
                            fontWeight: FontWeight.bold
                        ),
                      ),
                      Text(
                        'Sign into your account',
                        style: TextStyle(
                            fontSize: Dimensions.font20,
                            color: Colors.grey[500]
                          //fontWeight: FontWeight.bold
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: Dimensions.height20),
                //Email
                AppTextField(
                  textEditingController: emailController,
                  hintText: 'Email',
                  prefixIcon: Icons.email,
                ),
                SizedBox(height: Dimensions.height20),
                //Password
                AppTextField(
                  isObsecure: true,
                  textEditingController: passwordController,
                  hintText: 'Password',
                  prefixIcon: CupertinoIcons.lock_shield_fill,
                ),
                SizedBox(height: Dimensions.height20),
                //Tagline
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    RichText(
                      text: TextSpan(
                          text: "Sign into your account",
                          style: TextStyle(
                              color: Colors.grey[500],
                              fontSize: Dimensions.font20
                          )
                      ),
                    ),
                    SizedBox(width: Dimensions.width20),
                  ],
                ),
                SizedBox(height: Dimensions.screenHeight*0.05),
                //Sign IN button
                GestureDetector(
                  onTap: (){
                    login(authController);
                  },
                  child: Container(
                    width: Dimensions.screenWidth/2,
                    height: Dimensions.screenHeight/13,
                    decoration: BoxDecoration(
                      color: AppColors.mainColor,
                      borderRadius: BorderRadius.circular(Dimensions.radius30),
                    ),
                    child: Center(
                      child: BigText(
                        text: 'Sign In',
                        size: Dimensions.font20*1.5,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: Dimensions.screenHeight*0.05),
                //Sign in
                RichText(
                  text: TextSpan(
                      text: "Don\'t have an account? ",
                      style: TextStyle(
                          color: Colors.grey[500],
                          fontSize: Dimensions.font20
                      ),
                      children: [
                        TextSpan(
                            recognizer: TapGestureRecognizer()..onTap=()=>Get.to(()=>SignUpPage(),transition: Transition.fade),
                            text: "Create",
                            style: TextStyle(
                              color: AppColors.mainBlackColor,
                              fontSize: Dimensions.font20,
                              fontWeight: FontWeight.bold,

                            )
                        ),
                      ]
                  ),
                ),
              ],
            ),
          ) : CustomLoader();
        })
    );
  }
}


/*class SignInPage extends StatelessWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    var emailController = TextEditingController();
    var passwordController = TextEditingController();

    void login(AuthController authController){

      String email = emailController.text.trim();
      String password = passwordController.text.trim();

      if(email.isEmpty){
        showCustomSnakebar(
            'Type in your email',
            title: "Email"
        );
      }else if(!GetUtils.isEmail(email)){
        showCustomSnakebar(
            'Type a valid email address',
            title: "Invalid Email"
        );
      }else if(password.isEmpty){
        showCustomSnakebar(
            'Type in your password',
            title: "Password"
        );
      }else if(password.length<6){
        showCustomSnakebar(
            'Password can\'t be less than six characters',
            title: "Password"
        );
      }else{
        authController.login(email,password).then((status){
          if(status.isSuccess){
            //Get.toNamed(RouteHelper.getInitial());
            Get.toNamed(RouteHelper.getCartPage());
          }else{
            showCustomSnakebar(status.message);
          }
        });

      }
    }

    return Scaffold(
      backgroundColor: Colors.white,
      body: GetBuilder<AuthController>(builder: (authController){
        return !authController.isLoading ? SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            children: [
              SizedBox(height: Dimensions.height30),
              //App logo
              Container(
                height: Dimensions.screenHeight*0.25,
                child: const Center(
                  child: CircleAvatar(
                    backgroundColor: Colors.white,
                    radius: 80,
                    backgroundImage: AssetImage(
                        'assets/image/logo part 1.png'
                    ),
                  ),
                ),
              ),
              //Welcome
              Container(
                width: double.maxFinite,
                margin: EdgeInsets.only(
                    left: Dimensions.width20
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Hello',
                      style: TextStyle(
                          fontSize: Dimensions.font20*3,
                          fontWeight: FontWeight.bold
                      ),
                    ),
                    Text(
                      'Sign into your account',
                      style: TextStyle(
                          fontSize: Dimensions.font20,
                          color: Colors.grey[500]
                        //fontWeight: FontWeight.bold
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: Dimensions.height20),
              //Email
              AppTextField(
                textEditingController: emailController,
                hintText: 'Email',
                prefixIcon: Icons.email,
              ),
              SizedBox(height: Dimensions.height20),
              //Password
              AppTextField(
                isObsecure: true,
                textEditingController: passwordController,
                hintText: 'Password',
                prefixIcon: CupertinoIcons.lock_shield_fill,
              ),
              SizedBox(height: Dimensions.height20),
              //Tagline
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  RichText(
                    text: TextSpan(
                        text: "Sign into your account",
                        style: TextStyle(
                            color: Colors.grey[500],
                            fontSize: Dimensions.font20
                        )
                    ),
                  ),
                  SizedBox(width: Dimensions.width20),
                ],
              ),
              SizedBox(height: Dimensions.screenHeight*0.05),
              //Sign IN button
              GestureDetector(
                onTap: (){
                  login(authController);
                },
                child: Container(
                  width: Dimensions.screenWidth/2,
                  height: Dimensions.screenHeight/13,
                  decoration: BoxDecoration(
                    color: AppColors.mainColor,
                    borderRadius: BorderRadius.circular(Dimensions.radius30),
                  ),
                  child: Center(
                    child: BigText(
                      text: 'Sign In',
                      size: Dimensions.font20*1.5,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              SizedBox(height: Dimensions.screenHeight*0.05),
              //Sign in
              RichText(
                text: TextSpan(
                    text: "Don\'t have an account? ",
                    style: TextStyle(
                        color: Colors.grey[500],
                        fontSize: Dimensions.font20
                    ),
                    children: [
                      TextSpan(
                          recognizer: TapGestureRecognizer()..onTap=()=>Get.to(()=>SignUpPage(),transition: Transition.fade),
                          text: "Create",
                          style: TextStyle(
                            color: AppColors.mainBlackColor,
                            fontSize: Dimensions.font20,
                            fontWeight: FontWeight.bold,

                          )
                      ),
                    ]
                ),
              ),
            ],
          ),
        ) : CustomLoader();
      })
    );
  }
}*/
