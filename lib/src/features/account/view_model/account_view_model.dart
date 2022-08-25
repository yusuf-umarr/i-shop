import 'package:flutter/material.dart';
import 'package:i_shop/src/core/utilities/constants/utils.dart';
import 'package:i_shop/src/features/account/model/order_model.dart';
import 'package:i_shop/src/features/account/services/account_services.dart';

class AccountViewModel extends ChangeNotifier {
  AccountServices accountServices =AccountServices();

  List<OrderModel> _orderProductList =[];
  List<OrderModel> get orderProductList =>_orderProductList;

  List _orderData = [];
  List get orderData => _orderData;


  setOrderProduct(List<OrderModel> orderProductList)async{
    _orderProductList= orderProductList;

    notifyListeners();
  }


  setOrder(orderData){


  
  }


  fetchOrderProduct(context)async{

    var response = await accountServices.fetchMyOrder(  );
    if (response is Success) {

      setOrderProduct(response.response as List<OrderModel>);
      notifyListeners();
    }
    if (response is Failure) {
      UserError userError = UserError(
        code: response.code,
        message: response.errorResponse,
      );

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text(" Error"),
          backgroundColor: Colors.red,
          action: SnackBarAction(
            label: userError.message.toString(),
            onPressed: () {
              // Code to execute.
            },
          ),
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
      );
    }
  }
}