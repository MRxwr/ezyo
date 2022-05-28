import 'package:ezyo/Models/cart_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
class CartNotifier  extends ChangeNotifier{
List<CartModel> cartModelList = List();
int quantity=0;
double totalPrice = 0.0;
  addCart(CartModel cartModel){
    cartModelList.add(cartModel);
    notifyListeners();
  }

  updateCart(CartModel cartModel){
    cartModelList.add(cartModel);
    notifyListeners();

  }
  clearCart(){
    cartModelList.clear();
    notifyListeners();
  }
  removeItemCart(int i){
    cartModelList.removeAt(i);
    notifyListeners();

  }
   getQuantity(){
    quantity = cartModelList.length;
    notifyListeners();
  }
  getTotalPrice(){
    for(int i =0;i<cartModelList.length;i++){
      CartModel cartModel = cartModelList[i];
      double price = double.parse(cartModel.finalPrice)*cartModel.quantity;
      totalPrice +=price;

    }
    notifyListeners();
  }

}