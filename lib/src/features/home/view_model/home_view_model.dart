import 'package:flutter/material.dart';
import 'package:i_shop/src/features/account/model/product_deal_day.dart';
import 'package:i_shop/src/features/account/model/product_model.dart';
import 'package:i_shop/src/features/home/services/home_services.dart';
import '../../../core/utilities/constants/utils.dart';

class HomeViewModel extends ChangeNotifier {
 

  HomeServices homeServices = HomeServices();
  List<ProductModel> _productCategoryList = [];

  List<ProductModel> get productCategoryList => _productCategoryList;


  DealOfTheDayModel? _dealOfDayProduct;

  DealOfTheDayModel? get dealOfDayProduct => _dealOfDayProduct;
  var _selectedProduct;

   get selectedProduct => _selectedProduct;






  setProductCategory(List<ProductModel> productCategoryList) async {
    // print(productCategoryList);
    _productCategoryList = productCategoryList;
  }


  setProductDealDay(DealOfTheDayModel dealOfDayProduct) async {
   
    _dealOfDayProduct = dealOfDayProduct;
    notifyListeners();
  }
  setSelectedProduct( selectedProduct) async {
   
    _selectedProduct = selectedProduct;
    notifyListeners();
  }

  fetchCategoryProducts(context, category) async {
    var response = await homeServices.fetchCategoryProducts(context:context,  category: category);
    //  print(response);
    if (response is Success) {
      // print(response.response);

      setProductCategory(response.response as List<ProductModel>);
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
  fetchDealOfDay(context) async {
    var response = await homeServices.fetchDealOfDay(context:context,  );
    //  print(response);
    // if (response is Success) {
      // print(response);

      setProductDealDay(response );
      notifyListeners();
    // }
    // if (response is Failure) {
    //   UserError userError = UserError(
    //     code: response.code,
    //     message: response.errorResponse,
    //   );

    //   ScaffoldMessenger.of(context).showSnackBar(
    //     SnackBar(
    //       content: const Text(" Error"),
    //       backgroundColor: Colors.red,
    //       action: SnackBarAction(
    //         label: userError.message.toString(),
    //         onPressed: () {
    //           // Code to execute.
    //         },
    //       ),
    //       behavior: SnackBarBehavior.floating,
    //       shape: RoundedRectangleBorder(
    //         borderRadius: BorderRadius.circular(20),
    //       ),
    //     ),
    //   );
    // }
  }
}


/*
 setSelectedUser(UserModel selectedUser) { //  UserModel? get selectedUser => _selectedUser; // UserModel? _selectedUser;

    _selectedUser = selectedUser;
  }

*/