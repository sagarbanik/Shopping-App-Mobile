import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get/get.dart';
import 'package:shopping_app/controller/cart_controller.dart';
import 'package:shopping_app/controller/popular_product_controller.dart';
import 'package:shopping_app/controller/recommended_product_controller.dart';
import 'package:shopping_app/pages/auth/sign_in_page.dart';
import 'package:shopping_app/pages/auth/sign_up_page.dart';
import 'package:shopping_app/pages/cart/cart_page.dart';
import 'package:shopping_app/pages/food/popular_food_detail.dart';
import 'package:shopping_app/pages/food/recommended_food_detail.dart';
import 'package:shopping_app/pages/home/main_food_page.dart';
import 'package:shopping_app/helper/dependencies.dart' as dep;
import 'package:shopping_app/pages/splash/splash_page.dart';
import 'package:shopping_app/routes/route_helper.dart';



Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dep.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    Get.find<CartController>().getCartData();
    return GetBuilder<PopularProductController>(builder: (_){
      return GetBuilder<RecommendedProductController>(builder: (_){
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          //Calling Homepage as MainFoodPage()
          //home: SplashScreen(),
          //home: SignInPage(),
          initialRoute: RouteHelper.getSplashPage(),
          getPages: RouteHelper.routes,
        );
      });
    });


  }
}
