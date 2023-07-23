import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopping_app/base/no_data_page.dart';
import 'package:shopping_app/controller/auth_controller.dart';
import 'package:shopping_app/controller/cart_controller.dart';
import 'package:shopping_app/controller/location_controller.dart';
import 'package:shopping_app/controller/popular_product_controller.dart';
import 'package:shopping_app/controller/recommended_product_controller.dart';
import 'package:shopping_app/utils/colors.dart';
import 'package:shopping_app/utils/constants.dart';
import 'package:shopping_app/utils/dimentions.dart';
import 'package:shopping_app/widgets/app_icon.dart';
import 'package:shopping_app/widgets/big_text.dart';
import 'package:shopping_app/widgets/small_text.dart';

import '../../routes/route_helper.dart';

class CartPage extends StatelessWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Icons
          Positioned(
            top: Dimensions.height20*3 ,
            left: Dimensions.width20,
            right: Dimensions.width20,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween ,
              children: [
                GestureDetector(
                  child: AppIcon(
                    icon: Icons.arrow_back_ios,
                    iconColor: Colors.white,
                    backgroundColor: AppColors.mainColor,
                    iconSize: Dimensions.iconSize24,
                  ),
                  onTap: (){
                    Get.toNamed(RouteHelper.getInitial());
                  },
                ),
                SizedBox(width: Dimensions.width20*10),
                GestureDetector(
                  child: AppIcon(
                    icon: Icons.home_outlined,
                    iconColor: Colors.white,
                    backgroundColor: AppColors.mainColor,
                    iconSize: Dimensions.iconSize24,
                  ),
                  onTap: (){
                    Get.toNamed(RouteHelper.getInitial());
                  },
                ),
                AppIcon(
                  icon: Icons.shopping_cart,
                  iconColor: Colors.white,
                  backgroundColor: AppColors.mainColor,
                  iconSize: Dimensions.iconSize24,
                ),
              ],
            ),
          ),
          // List
          GetBuilder<CartController>(builder: (_cartController){
            return _cartController.getItemList.isNotEmpty ? Positioned(
              top: Dimensions.height20*5,
              left: Dimensions.width20,
              right: Dimensions.width20,
              bottom: 0,
              child: Container(
                //color: Colors.pink,
                margin: EdgeInsets.only(top: Dimensions.height15),
                child: MediaQuery.removePadding(
                    context: context,
                    removeTop: true,
                    child: GetBuilder<CartController>(builder: (controller){

                      var _cartList = controller.getItemList;

                      return ListView.builder(
                          itemCount: _cartList.length,
                          itemBuilder: (_,index){
                            return Container(
                              height: Dimensions.height20*5,
                              width: double.maxFinite,
                              child: Row(
                                children: [
                                  GestureDetector(
                                    child: Container(
                                      width: Dimensions.width20*5,
                                      height: Dimensions.height20*5,
                                      margin: EdgeInsets.only(bottom: Dimensions.height10),
                                      decoration: BoxDecoration(
                                          image: DecorationImage(
                                              fit: BoxFit.cover,
                                              image: NetworkImage(Constants.BASE_URL+Constants.UPLOAD_URL+controller.getItemList[index].img!)
                                          ),
                                          borderRadius: BorderRadius.circular(Dimensions.radius20),
                                          color: Colors.white
                                      ),
                                    ),
                                    onTap: (){
                                      var popularIndex = Get.find<PopularProductController>()
                                          .popularProductList
                                          .indexOf(_cartList[index].product!);
                                      if(popularIndex >= 0){
                                        Get.toNamed(RouteHelper.getPopularFood(popularIndex,'cartPage'));
                                      }else{
                                        var recommendedIndex = Get.find<RecommendedProductController>()
                                            .recommendedProductList
                                            .indexOf(_cartList[index].product!);

                                        if(recommendedIndex<0){
                                          Get.snackbar(
                                              'History Product',
                                              'Product review is not available for history products!',
                                              backgroundColor: AppColors.mainColor,
                                              colorText: Colors.white
                                          );
                                        }else{
                                          Get.toNamed(RouteHelper.getRecommendedrFood(recommendedIndex,'cartPage'));
                                        }
                                      }
                                    },
                                  ),
                                  SizedBox(width: Dimensions.width10),
                                  Expanded(
                                    child: Container(
                                      height: Dimensions.height20*5,
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                        children: [
                                          BigText(
                                            text: controller.getItemList[index].name!,
                                            color: Colors.black54,
                                          ),
                                          SmallText(
                                            text: 'spicy',
                                          ),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              BigText(
                                                text: '\$ ${controller.getItemList[index].price.toString()}',
                                                color: Colors.redAccent,
                                              ),
                                              Container(
                                                padding: EdgeInsets.only(top: Dimensions.height10,bottom: Dimensions.height10,left: Dimensions.width10,right: Dimensions.width10),
                                                decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.circular(Dimensions.radius20),
                                                    color: Colors.white
                                                ),
                                                child: Row(
                                                  children: [
                                                    GestureDetector(
                                                      child: const Icon(
                                                          Icons.remove,
                                                          color: AppColors.signColor
                                                      ),
                                                      onTap: (){
                                                        controller.addItem(_cartList[index].product!, -1);
                                                      },
                                                    ),
                                                    SizedBox(width: Dimensions.width10/2),
                                                    BigText(text: _cartList[index].quantity.toString()),//popularProduct.inCartItems.toString()),
                                                    SizedBox(width: Dimensions.width10/2),
                                                    GestureDetector(
                                                      child: const Icon(
                                                          Icons.add,
                                                          color: AppColors.signColor
                                                      ),
                                                      onTap: (){
                                                        controller.addItem(_cartList[index].product!, 1);
                                                      },
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }
                      );
                    })
                ),
              ),
            ) : const NoDataPage(text: 'Your cart is empty!');
          })
        ],
      ),
      bottomNavigationBar: GetBuilder<CartController>(builder: (controller){
        return Container(
          height: Dimensions.bottomHeightBar,
          padding: EdgeInsets.only(top: Dimensions.height30,bottom: Dimensions.height30,left: Dimensions.width20,right: Dimensions.width20),
           decoration: BoxDecoration(
              color: AppColors.buttonBackgroundColor,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(Dimensions.radius20*2),
                topRight: Radius.circular(Dimensions.radius20*2),
              )
          ),
          child: controller.getItemList.isNotEmpty ? Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              //Plus Minus
              Container(
                padding: EdgeInsets.only(top: Dimensions.height20,bottom: Dimensions.height20,left: Dimensions.width20,right: Dimensions.width20),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(Dimensions.radius20),
                    color: Colors.white
                ),
                child: Row(
                  children: [
                    SizedBox(width: Dimensions.width10/2),
                    BigText(text: '\$ '+controller.totalAmount.toString()),
                    SizedBox(width: Dimensions.width10/2),
                  ],
                ),
              ),
              //Button
              GestureDetector(
                child: Container(
                  padding: EdgeInsets.only(top: Dimensions.height20,bottom: Dimensions.width20,left: Dimensions.width20,right: Dimensions.width20),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(Dimensions.radius20),
                      color: AppColors.mainColor
                  ),

                  child: BigText(
                      text: "Checkout",
                      color: Colors.white
                  ),
                ),
                onTap: (){
                  if(Get.find<AuthController>().isUserLoggedIn()){
                    if(Get.find<LocationController>().addressList.isEmpty){
                      Get.toNamed(RouteHelper.getAddAddressPage());
                    }
                    //controller.addToHistory();
                  }else{
                    Get.toNamed(RouteHelper.getSignInPage());
                  }
                },
              ),
            ],
          ) : Container(),
        );
      }),
    );
  }
}
