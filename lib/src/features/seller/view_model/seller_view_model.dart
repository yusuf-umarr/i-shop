import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:i_shop/src/features/account/model/product_model.dart';
import 'package:i_shop/src/features/seller/services/seller_services.dart';
import '../../../core/utilities/constants/utils.dart';

class SellerViewModel extends ChangeNotifier {
  SellerViewModel() {
    getAllProducts();
  }

  AdminServices adminService = AdminServices();
  List<ProductModel> _productListModel = [];

  List<ProductModel> get productListModel => _productListModel;

  setProductModel(List<ProductModel> productListModel) async {
    _productListModel = productListModel;
    notifyListeners();
  }

  getAllProducts() async {
    var response = await adminService.getAllProducts();
    //  print(response);
    if (response is Success) {
      // print(response.respon se);

      setProductModel(response.response as List<ProductModel>);
      notifyListeners();
    }
    if (response is Failure) {
      UserError userError = UserError(
        code: response.code,
        message: response.errorResponse,
      );

      // ScaffoldMessenger.of(context).showSnackBar(
      //   SnackBar(
      //     content: const Text(" Error"),
      //     backgroundColor: Colors.red,
      //     action: SnackBarAction(
      //       label: userError.message.toString(),
      //       onPressed: () {
      //         // Code to execute.
      //       },
      //     ),
      //     behavior: SnackBarBehavior.floating,
      //     shape: RoundedRectangleBorder(
      //       borderRadius: BorderRadius.circular(20),
      //     ),
      //   ),
      // );
    }
  }
}
