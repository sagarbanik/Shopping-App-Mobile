import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopping_app/controller/cart_controller.dart';
import 'package:shopping_app/data/repository/popular_product_repo.dart';
import 'package:shopping_app/models/popular_products_model.dart';
import 'package:shopping_app/utils/colors.dart';

import '../models/cart_model.dart';

class PopularProductController extends GetxController{
  final PopularProductRepo popularProductRepo;
  PopularProductController({required this.popularProductRepo});

  List<ProductModel> _popularProductList = [];
  List<ProductModel> get popularProductList => _popularProductList;
  late CartController _cartController;

  bool _isLoaded = false;
  bool get isLoaded => _isLoaded;

  int _quantity = 0;
  int get quantity => _quantity;
  int _inCartItems = 0;
  int get inCartItems => _inCartItems + _quantity;


  Future<void> getPopularProductList() async{
    Response response = await popularProductRepo.getPopularProductList();
    if(response.statusCode == 200){
      _popularProductList = [];
      _popularProductList.addAll(Product.fromJson(response.body).products);
      _isLoaded = true;
      update();//Like setState
    }else{
      print('!Error');
    }
  }

  void setQuantity(bool isIncrement){
    if(isIncrement){
      //Increase Qty
      _quantity = checkQuantity(_quantity+1);
    }else{
      //Decrease Qty
      _quantity = checkQuantity(_quantity-1);
    }
    update();
  }

  int checkQuantity(int qty){
    if((_inCartItems+qty) < 0){
      Get.snackbar('Item Count', "You can't reduce more!",
        backgroundColor: Colors.pink,
        colorText: Colors.white,
        duration: const Duration(seconds: 1),
          snackPosition: SnackPosition.TOP,
          icon: const Icon(Icons.warning_amber_sharp,color: Colors.white),
          shouldIconPulse: true,
          borderRadius: 5,
          leftBarIndicatorColor: Colors.amber,
          barBlur: 5,
          overlayBlur: .5,
          overlayColor: Colors.black26
      );
      if(_inCartItems > 0){
        _quantity = -_inCartItems;
        return _quantity;
      }
      return 0;
    }else if((_inCartItems+qty) > 20){
      Get.snackbar('Item Count', "You can't add more!",
        backgroundColor: Colors.pink,
        colorText: Colors.white,
        duration: const Duration(seconds: 1),
        snackPosition: SnackPosition.TOP,
        icon: const Icon(Icons.warning_amber_sharp,color: Colors.white),
        shouldIconPulse: true,
        borderRadius: 5,
        leftBarIndicatorColor: Colors.amber,
        barBlur: 5,
        overlayBlur: .5,
        overlayColor: Colors.black26
      );
      return 20;
    }else{
      return qty;
    }
  }

  void initProduct(ProductModel product,CartController controller){
    _quantity = 0;
    _inCartItems = 0;
    _cartController = controller;
    var exist = false;
    exist = _cartController.existInCart(product);
    if(exist){
      _inCartItems = _cartController.getQuantity(product);
    }
  }

  void addItem(ProductModel product){
    _cartController.addItem(product, _quantity);
    _quantity = 0;
    _inCartItems = _cartController.getQuantity(product);
    _cartController.items.forEach((key, value) {
      print("ID : "+value.id.toString()+" Qty : "+value.quantity.toString());
    });

    update();
  }

  int get totalItems{
    return _cartController.getTotalItems;
  }

  List<CartModel> get getItemList{

    return _cartController.getItemList;

  }

}