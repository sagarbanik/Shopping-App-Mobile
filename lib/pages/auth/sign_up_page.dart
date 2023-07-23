import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopping_app/base/custom_loader.dart';
import 'package:shopping_app/base/show_custom_snakebar.dart';
import 'package:shopping_app/controller/auth_controller.dart';
import 'package:shopping_app/models/signup_body_model.dart';
import 'package:shopping_app/utils/colors.dart';
import 'package:shopping_app/utils/dimentions.dart';
import 'package:shopping_app/widgets/app_text_field.dart';
import 'package:shopping_app/widgets/big_text.dart';

import '../../routes/route_helper.dart';


class SignUpPage extends StatelessWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    var emailController = TextEditingController();
    var passwordController = TextEditingController();
    var nameController = TextEditingController();
    var phoneController = TextEditingController();

    var imageList = [
      'g.png',
      'f.png',
      't.png'
    ];

    void registration(AuthController authController){

      //var authController = Get.find<AuthController>();

      String name = nameController.text.trim();
      String phone = phoneController.text.trim();
      String email = emailController.text.trim();
      String password = passwordController.text.trim();

      if(name.isEmpty){
        showCustomSnakebar(
          'Type in your name',
          title: "Name"
        );
      }else if(phone.isEmpty){
        showCustomSnakebar(
            'Type in your phone',
            title: "Phone"
        );
      }else if(email.isEmpty){
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

        SignUpBody body = SignUpBody(
            name: name,
            phone: phone,
            email: email,
            password: password
        );

        authController.registration(body).then((status){
          if(status.isSuccess){
            Get.offNamed(RouteHelper.getInitial());
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
                child: Center(
                  child: CircleAvatar(
                    backgroundColor: Colors.white,
                    radius: 80,
                    backgroundImage: AssetImage(
                        'assets/image/logo part 1.png'
                    ),
                  ),
                ),
              ),
              //Email
              AppTextField(
                textEditingController: emailController,
                hintText: 'Email',
                prefixIcon: Icons.email,
              ),
              SizedBox(height: Dimensions.height20),
              //Password
              AppTextField(
                textEditingController: passwordController,
                hintText: 'Password',
                prefixIcon: CupertinoIcons.lock_shield_fill,
                isObsecure: true,
              ),
              SizedBox(height: Dimensions.height20),
              //Name
              AppTextField(
                textEditingController: nameController,
                hintText: 'Name',
                prefixIcon: Icons.person,
              ),
              SizedBox(height: Dimensions.height20),
              //Phone
              AppTextField(
                textEditingController: phoneController,
                hintText: 'Phone',
                prefixIcon: Icons.phone,
              ),
              SizedBox(height: Dimensions.height20),

              //Bottom Section
              //Sign Up button
              GestureDetector(
                onTap: (){
                  registration(authController);
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
                      text: 'Sign Up',
                      size: Dimensions.font20*1.5,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              SizedBox(height: Dimensions.height10),
              //Tagline
              RichText(
                text: TextSpan(
                    recognizer: TapGestureRecognizer()..onTap=()=>Get.back(),
                    text: "Have an account already?",
                    style: TextStyle(
                        color: Colors.grey[500],
                        fontSize: Dimensions.font20
                    )
                ),
              ),
              SizedBox(height: Dimensions.screenHeight*0.05),
              //Sign up methods
              RichText(
                text: TextSpan(
                    text: "Sign up using ",
                    style: TextStyle(
                        color: Colors.grey[500],
                        fontSize: Dimensions.font16
                    )
                ),
              ),
              //Social
              Wrap(
                children: List.generate(3, (index) =>
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CircleAvatar(
                        radius: Dimensions.radius30,
                        backgroundColor: Colors.white,
                        backgroundImage: AssetImage(
                            'assets/image/'+imageList[index]
                        ),
                      ),
                    )),
              )
            ],
          ),
        ) : const CustomLoader();
      })
    );

  }
}
