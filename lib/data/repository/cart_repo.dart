import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:shopping_app/utils/constants.dart';

import '../../models/cart_model.dart';

class CartRepo{
  final SharedPreferences sharedPreferences;
  CartRepo({ required this.sharedPreferences});

  List<String> cart = [];
  List<String> cartHistory = [];

  //For cart page items
  void addToCartList(List<CartModel> cartList){

    //Debug only
    //sharedPreferences.remove(Constants.CART_LIST);
    //sharedPreferences.remove(Constants.CART_HISTORY_LIST);
    var time = DateTime.now().toString();
    cart = [];
    cartList.forEach((element) {
      element.time = time;
      return cart.add(jsonEncode(element));
    });

    sharedPreferences.setStringList(Constants.CART_LIST, cart);
    print(sharedPreferences.getStringList(Constants.CART_LIST));

    //getCartList();
  }

  List<CartModel> getCartList(){

    List<String> carts = [];
    if(sharedPreferences.containsKey(Constants.CART_LIST)){
      carts = sharedPreferences.getStringList(Constants.CART_LIST)!;
      //print('getter : '+carts.toString());
    }

    List<CartModel> cartList = [];
    carts.forEach((element) => cartList.add(CartModel.fromJson(jsonDecode(element))));

    return cartList;
  }

  //For cart history in home page
  void addToCartHistoryList(){
    if(sharedPreferences.containsKey(Constants.CART_HISTORY_LIST)){
      cartHistory = sharedPreferences.getStringList(Constants.CART_HISTORY_LIST)!;
    }
    for(int i = 0; i<cart.length;i++){
      //print('History List : '+cart[i]);
      cartHistory.add(cart[i]);
    }
    removeCart();
    sharedPreferences.setStringList(Constants.CART_HISTORY_LIST, cartHistory);
  }

  List<CartModel> getCartHistoryList(){
    if(sharedPreferences.containsKey(Constants.CART_HISTORY_LIST)){
      cartHistory = sharedPreferences.getStringList(Constants.CART_HISTORY_LIST)!;
    }
    List<CartModel> cartListHistory = [];
    
    cartHistory.forEach((element) => cartListHistory.add(CartModel.fromJson(jsonDecode(element))));
    
    return cartListHistory;
  }

  void removeCart(){
    cart = [];
    sharedPreferences.remove(Constants.CART_LIST);
  }

  void clearCartHistory(){
    removeCart();
    cartHistory = [];
    sharedPreferences.remove(Constants.CART_HISTORY_LIST);
  }

}