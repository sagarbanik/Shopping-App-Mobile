

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:shopping_app/controller/cart_controller.dart';
import 'package:shopping_app/controller/popular_product_controller.dart';
import 'package:shopping_app/pages/cart/cart_page.dart';
import 'package:shopping_app/pages/home/main_food_page.dart';
import 'package:shopping_app/utils/constants.dart';
import 'package:shopping_app/utils/dimentions.dart';
import 'package:shopping_app/widgets/app_icon.dart';
import 'package:shopping_app/widgets/expandable_text_widget.dart';

import '../../routes/route_helper.dart';
import '../../utils/colors.dart';
import '../../widgets/app_column.dart';
import '../../widgets/big_text.dart';
import '../../widgets/icon_and_text_widget.dart';
import '../../widgets/small_text.dart';

class PopularFoodDetail extends StatelessWidget {
  final int pageId;
  final String page;
  const PopularFoodDetail({Key? key,required this.pageId,required this.page}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    var product = Get.find<PopularProductController>().popularProductList[pageId];
    Get.find<PopularProductController>().initProduct(product,Get.find<CartController>());

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          //Background Image
          Positioned(
              left: 0,
              right: 0,
              child: Container(
                width: double.maxFinite,
                height: Dimensions.popularFoodImgSize,
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: NetworkImage(
                        Constants.BASE_URL+Constants.UPLOAD_URL+product.img!
                      ),
                      fit: BoxFit.cover,
                   ),
                ),
              )
          ),
          //Top NavIcons
          Positioned(
            top: Dimensions.height45,
            left: Dimensions.width20,
            right: Dimensions.width20,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: (){

                    if(page == 'cartPage'){
                      Get.toNamed(RouteHelper.getCartPage());
                    }else{
                      Get.toNamed(RouteHelper.getInitial());
                    }

                  },
                  child: AppIcon(icon: Icons.arrow_back_ios),
                ),
                //
                GetBuilder<PopularProductController>(builder: (controller){
                  return GestureDetector(
                    child: Stack(
                      children: [
                        AppIcon(icon: Icons.shopping_cart_outlined),
                        controller.totalItems >= 1 ?
                        Positioned(
                          right: 0,
                          top: 0,
                          child: GestureDetector(
                            child: AppIcon(
                              icon: Icons.circle,
                              size: 20,
                              iconColor: Colors.transparent,
                              backgroundColor: Colors.pinkAccent,
                            ),
                          ),
                        ) : Container(),
                        Get.find<PopularProductController>().totalItems >= 1 ?
                        Positioned(
                          right: 3,
                          top: 4,
                          child: BigText(
                            text: Get.find<PopularProductController>().totalItems.toString(),
                            size: 12,
                            color: Colors.white,
                          ),
                        ) : Container()
                      ],
                    ),
                    onTap: (){
                      if(controller.totalItems >= 1 )
                        Get.toNamed(RouteHelper.getCartPage());
                    },
                  );
                }),
              ],
            ),
          ),
          //Introduction of food
          Positioned(
            left: 0,
            right: 0,
            top: Dimensions.popularFoodImgSize-20,
            bottom: 0,
            child: Container(
              padding: EdgeInsets.only(left: Dimensions.width20,right: Dimensions.width20,top: Dimensions.height20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(Dimensions.radius20),
                  topRight: Radius.circular(Dimensions.radius20),
                ),
                color: Colors.white
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppColumn(text: product.name!),
                  SizedBox(height: Dimensions.height20),
                  BigText(text: "Introduce"),
                  SizedBox(height: Dimensions.height20),
                  //Expandable Text widget
                  Expanded(
                    child: SingleChildScrollView(
                        child: ExpandableTextWidget(text: product.description!),
                    ),
                  ),
                ],
              ),
            ),
          ),

        ],
      ),
      bottomNavigationBar: GetBuilder<PopularProductController>(builder: (popularProduct){
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
          child: Row(
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
                    GestureDetector(
                      child: const Icon(
                          Icons.remove,
                          color: AppColors.signColor
                      ),
                      onTap: (){
                        popularProduct.setQuantity(false);
                      },
                    ),
                    SizedBox(width: Dimensions.width10/2),
                    BigText(text: popularProduct.inCartItems.toString()),
                    SizedBox(width: Dimensions.width10/2),
                    GestureDetector(
                      child: const Icon(
                          Icons.add,
                          color: AppColors.signColor
                      ),
                      onTap: (){
                        popularProduct.setQuantity(true);
                      },
                    ),
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
                      text: "\$ ${product.price!} | Add to cart",
                      color: Colors.white
                  ),
                ),
                onTap: (){
                  popularProduct.addItem(product);
                },
              ),
            ],
          ),
        );
      }),
    );
  }
}
