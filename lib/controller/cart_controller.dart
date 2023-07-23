import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopping_app/data/repository/cart_repo.dart';
import 'package:shopping_app/models/popular_products_model.dart';

import '../models/cart_model.dart';

class CartController extends GetxController{
  final CartRepo cartRepo;
  CartController({required this.cartRepo});

  Map<int,CartModel> _items = {};
  Map<int,CartModel> get items => _items;
  //For shared prefs
  List<CartModel> storageItems = [];

  void addItem(ProductModel product,int quantity){

    var totalQuantity = 0;

    if(_items.containsKey(product.id!)){
      _items.update(product.id!, (value) {

        totalQuantity = value.quantity!+quantity;

        return CartModel(
          id: value.id!,
          name: value.name,
          price: value.price,
          img: value.img,
          quantity: value.quantity!+quantity,
          isExist: true,
          time: DateTime.now().toString(),
          product: product
        );
      });

      if(totalQuantity <= 0){
        _items.remove(product.id);
      }

    }else{
      if(quantity > 0){
        _items.putIfAbsent(product.id!, () {
          return CartModel(
            id: product.id!,
            name: product.name,
            price: product.price,
            img: product.img,
            quantity: quantity,
            isExist: true,
            time: DateTime.now().toString(),
            product: product
          );
        });
      }else{
        Get.snackbar('Warning', "You should add item first!",
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
      }
    }

    cartRepo.addToCartList(getItemList);
    update();

  }

  bool existInCart(ProductModel product){
    if(_items.containsKey(product.id)){
      return true;
    }else{
      return false;
    }
  }

  int getQuantity(ProductModel product){

    var qty = 0;

    if(_items.containsKey(product.id)){
      _items.forEach((key, value) {
        if(key == product.id){
          qty = value.quantity!;
        }
      });
    }

    return qty;
  }

  int get getTotalItems{
    var totalQty = 0;

    _items.forEach((key, value) {
      totalQty += value.quantity!;
    });

    return totalQty;
  }

  List<CartModel> get getItemList{

    return _items.entries.map((e) {
      return e.value;
    }).toList();

  }

  int get totalAmount{
    var total = 0;

    _items.forEach((key, value) {
      total += value.quantity!*value.price!;
    });

    return total;
  }

  List<CartModel> getCartData(){
    setCart = cartRepo.getCartList();
    return storageItems;
  }

  set setCart(List<CartModel> items){
    storageItems = items;
    print('Stored object lenth :'+storageItems.length.toString());
    for(int i = 0; i<storageItems.length; i++){
      _items.putIfAbsent(storageItems[i].product!.id!, () => storageItems[i]);
    }
  }

  void addToHistory(){
    cartRepo.addToCartHistoryList();
    clear();
  }

  void clear(){
    _items = {};
    update();
  }

  List<CartModel> getCartHistoryList(){
    return cartRepo.getCartHistoryList();
  }

  set setItems(Map<int,CartModel> map){
    _items = {};
    _items = map;
  }

  void addToCardList(){
    cartRepo.addToCartList(getItemList);
    update();
  }

  void clearCartHistory(){
    cartRepo.clearCartHistory();
    update();
  }

}