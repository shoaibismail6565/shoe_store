 import 'package:flutter/material.dart';

class CartProvider extends ChangeNotifier {
List <Map<String , dynamic>> cartList=[];

void addProduct(Map<String, dynamic> product){
  product.remove('sizes');
  cartList.add(product);
  notifyListeners();
}

void removeProduct (Map<String, dynamic> product){
cartList.remove(product);
notifyListeners();
}

void clearCart (){
  cartList.clear();
  notifyListeners();
}

}