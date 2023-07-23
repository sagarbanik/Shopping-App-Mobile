

import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopping_app/controller/popular_product_controller.dart';
import 'package:shopping_app/controller/recommended_product_controller.dart';
import 'package:shopping_app/models/popular_products_model.dart';
import 'package:shopping_app/pages/food/popular_food_detail.dart';
import 'package:shopping_app/pages/home/main_food_page.dart';
import 'package:shopping_app/routes/route_helper.dart';
import 'package:shopping_app/utils/colors.dart';
import 'package:shopping_app/utils/constants.dart';
import 'package:shopping_app/utils/dimentions.dart';
import 'package:shopping_app/widgets/app_column.dart';
import 'package:shopping_app/widgets/big_text.dart';
import 'package:shopping_app/widgets/icon_and_text_widget.dart';
import 'package:shopping_app/widgets/small_text.dart';


class FoodPageBody extends StatefulWidget {
  const FoodPageBody({Key? key}) : super(key: key);

  @override
  State<FoodPageBody> createState() => _FoodPageBodyState();
}

class _FoodPageBodyState extends State<FoodPageBody> {

  PageController pageController = PageController(viewportFraction: 0.85);

  var _currentPageValue = 0.0;
  double scaleFactor = 0.8;
  double height = Dimensions.pageViewContainer;

  @override
  void initState() {
    super.initState();

    pageController.addListener(() {
      setState(() {
        _currentPageValue = pageController.page!;
        //print('Current page value: '+_currentPageValue.toString());
      });
    });
    

  }

  @override
  void dispose() {
    super.dispose();

    pageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        //Slider
        GetBuilder<PopularProductController>(builder: (popularProducts){
          return popularProducts.isLoaded ? Container(
            height: Dimensions.pageView,
            //color: Colors.lightBlue,
            child: PageView.builder(
                  controller: pageController,
                  itemCount: popularProducts.popularProductList.length ,
                  itemBuilder: (context,position){
                    return _buildPageItem(position,popularProducts.popularProductList[position]);
                  }
              ),
          ):CircularProgressIndicator(
            color: AppColors.mainColor,
          );
        }),
        //Slider Dots
        GetBuilder<PopularProductController>(builder: (popularProducts){
          return DotsIndicator(
            dotsCount: popularProducts.popularProductList.isEmpty ? 1 : popularProducts.popularProductList.length ,
            position: _currentPageValue,
            decorator: DotsDecorator(
              size: const Size.square(9.0),
              activeSize: const Size(18.0, 9.0),
              activeShape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
              activeColor: AppColors.mainColor,
            ),
          );
        }),
        SizedBox(height: Dimensions.height30),
        //Popular Text
        Container(
          margin: EdgeInsets.only(left: Dimensions.width30),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              BigText(text: 'Recommended'),
              SizedBox(width: Dimensions.width10,),
              Container(
                margin: const EdgeInsets.only(bottom: 3),
                child: BigText(text: ".",color: Colors.black26,),
              ),
              SizedBox(width: Dimensions.width10,),
              Container(
                margin: const EdgeInsets.only(bottom: 2),
                child: SmallText(text: "Food Pairing"),
              ),
            ],
          ),//
        ),
        //Recommended List View
        GetBuilder<RecommendedProductController>(builder: (recommendedProduct){
          return  recommendedProduct.isLoaded ? ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: recommendedProduct.recommendedProductList.length,
              itemBuilder: (context,index){
                return GestureDetector(
                  onTap: (){
                    Get.toNamed(RouteHelper.getRecommendedrFood(index,'home'));
                  },
                  child: Container(
                    margin: EdgeInsets.only(left: Dimensions.width20,right: Dimensions.width20,bottom: Dimensions.height10),
                    child: Row(
                      children: [
                        //Image
                        Container(
                          height: Dimensions.listViewImgSize,
                          width: Dimensions.listViewImgSize,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(Dimensions.radius20),
                            color: Colors.white38,
                            image: DecorationImage(
                              fit: BoxFit.cover,
                              image: NetworkImage(
                                  Constants.BASE_URL+Constants.UPLOAD_URL+recommendedProduct.recommendedProductList[index].img!
                              ),
                            ),
                          ),
                        ),
                        //Text Container
                        Expanded(
                          child: Container(
                            height: Dimensions.listViewTextContainerSize,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(Dimensions.radius20),
                                  bottomRight: Radius.circular(Dimensions.radius20),
                                ),
                                color: Colors.white
                            ),
                            child: Padding(
                              padding: EdgeInsets.only(left: Dimensions.width10,right: Dimensions.width10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  BigText(text: recommendedProduct.recommendedProductList[index].name),
                                  SizedBox(height: Dimensions.height10),
                                  SmallText(text: 'With Chinese Flavor'),
                                  SizedBox(height: Dimensions.height10),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      IconAndTextWidget(
                                          icon: Icons.circle_sharp,
                                          text: 'Normal',
                                          iconColor: AppColors.iconColor1
                                      ),
                                      IconAndTextWidget(
                                          icon: Icons.location_on,
                                          text: '1.7km',
                                          iconColor: AppColors.mainColor
                                      ),
                                      IconAndTextWidget(
                                          icon: Icons.access_time_rounded,
                                          text: '32min',
                                          iconColor: AppColors.iconColor2
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }) : CircularProgressIndicator(
            color: AppColors.mainColor,
          );
        })
      ],
    );
  }

  Widget _buildPageItem(int position,ProductModel popularProduct) {


    Matrix4 matrix = Matrix4.identity();

    if(position == _currentPageValue.floor()){
      var currentScale = 1-(_currentPageValue-position)*(1-scaleFactor);
      var currentTransition = height*(1-currentScale)/2;
      matrix = Matrix4.diagonal3Values(1, currentScale, 1)..setTranslationRaw(0, currentTransition, 0);
    }

    else if(position == _currentPageValue.floor()+1){
      var currentScale = scaleFactor+(_currentPageValue-position+1)*(1-scaleFactor);
      var currentTransition = height*(1-currentScale)/2;
      matrix = Matrix4.diagonal3Values(1, currentScale, 1);
      matrix = Matrix4.diagonal3Values(1, currentScale, 1)..setTranslationRaw(0, currentTransition, 0);
    }

    else if(position == _currentPageValue.floor()-1){
      var currentScale = 1-(_currentPageValue-position)*(1-scaleFactor);
      var currentTransition = height*(1-currentScale)/2;
      matrix = Matrix4.diagonal3Values(1, currentScale, 1);
      matrix = Matrix4.diagonal3Values(1, currentScale, 1)..setTranslationRaw(0, currentTransition, 0);
    }

    else{
      var curScale = 0.8;
      matrix = Matrix4.diagonal3Values(1, curScale, 1)..setTranslationRaw(0, height*(1-scaleFactor)/2, 1);
    }

    return Transform(
      transform: matrix,
      child: Stack(
        children: [
          GestureDetector(
            onTap: (){
              //Get.to(()=>MainFoodPage());
              //Get.toNamed(RouteHelper.popularFood);
              Get.toNamed(RouteHelper.getPopularFood(position,'home'));
            },
            child: Container(
              height: Dimensions.pageViewContainer,
              margin: EdgeInsets.only(left: Dimensions.width10,right: Dimensions.width10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(Dimensions.radius30),
                color: position.isEven ? Color(0xFF69c5df) : Color(0xFF9294cc),
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(
                      Constants.BASE_URL+Constants.UPLOAD_URL+popularProduct.img!
                  ),
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: Dimensions.pageViewTextContainer,
              margin: EdgeInsets.only(left: Dimensions.width30,right: Dimensions.width30,bottom: Dimensions.height30),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(Dimensions.radius20),
                boxShadow: const [
                  BoxShadow(
                    color: Color(0xFFe8e8e8),
                    offset: Offset(0,5),
                    blurRadius: 5.0
                  ),
                  BoxShadow(
                      color: Colors.white,
                      offset: Offset(-5,0),
                  ),
                  BoxShadow(
                    color: Colors.white,
                    offset: Offset(5,0),
                  )
                ],
                color: Colors.white,

              ),
              child: Container(
                padding: EdgeInsets.only(left: Dimensions.height15,right: Dimensions.height15,top: Dimensions.height15),
                child: AppColumn(text: popularProduct.name!),
              ),
            ),
          ),
        ]
      ),
    );
  }
}
