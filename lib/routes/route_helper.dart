import 'package:get/get.dart';
import 'package:shopping_app/pages/address/add_address_page.dart';
import 'package:shopping_app/pages/auth/sign_in_page.dart';
import 'package:shopping_app/pages/cart/cart_page.dart';
import 'package:shopping_app/pages/food/popular_food_detail.dart';
import 'package:shopping_app/pages/food/recommended_food_detail.dart';
import 'package:shopping_app/pages/home/home_page.dart';
import 'package:shopping_app/pages/splash/splash_page.dart';

import '../pages/home/main_food_page.dart';

class RouteHelper{
  static const String splashPage = "/splash-page";
  static const String initial = "/";
  static const String popularFood = "/popular-food";
  static const String recommendedFood = "/recommended-food";
  static const String cartPage = "/cart-page";
  static const String signInPage = "/sign-in";
  static const String addAddressPage = "/add-address";


  static String getSplashPage() => '$splashPage';
  static String getInitial() => '$initial';
  static String getPopularFood(int pageId,String page) => '$popularFood?pageId=$pageId&page=$page';
  static String getRecommendedrFood(int pageId,String page) => '$recommendedFood?pageId=$pageId&page=$page';
  static String getCartPage() => '$cartPage';
  static String getSignInPage() => '$signInPage';
  static String getAddAddressPage() => '$addAddressPage';


  static List<GetPage> routes = [

    GetPage(name: splashPage, page: () => SplashScreen(),transition: Transition.fadeIn),
    GetPage(name: initial, page: () => HomePage(),transition: Transition.fade),
    GetPage(name: signInPage, page: () => SignInPage(),transition: Transition.fade),


    GetPage(name: popularFood, page: () {
      var pageId = Get.parameters['pageId'];
      var pageName = Get.parameters['page'];
      return PopularFoodDetail(pageId: int.parse(pageId!),page: pageName!);
    },
      transition: Transition.fade,
    ),

    GetPage(name: recommendedFood, page: () {
      var pageId = Get.parameters['pageId'];
      var pageName = Get.parameters['page'];
      return RecommendedFoodDetail(pageId: int.parse(pageId!),page: pageName!);
    },
      transition: Transition.fade,
    ),

    GetPage(name: cartPage, page: () {
      return CartPage();
    },
      transition: Transition.fade,
    ),

    GetPage(name: addAddressPage, page: () {
      return AddAddressPage();
    },
      transition: Transition.fade,
    ),

  ];
}