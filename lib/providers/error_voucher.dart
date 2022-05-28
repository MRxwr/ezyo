import 'package:ezyo/Models/cart_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
class VoucherError  extends ChangeNotifier{
  String Error="";

  addError(String ee){
Error  = ee;
    notifyListeners();
  }


}