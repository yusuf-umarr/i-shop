import 'package:flutter/material.dart';
import 'package:i_shop/src/features/account/model/product_model.dart';
import 'package:i_shop/src/features/search/services/search_services.dart';
import '../../../core/utilities/constants/utils.dart';

class SearchViewModel extends ChangeNotifier {
 

  SearchServices searchServices = SearchServices();
  List<ProductModel> _searchedProductList = [];

  List<ProductModel> get searchedProductList => _searchedProductList;

  setSearchedProduct(List<ProductModel> searchedProductList) async {
    print(searchedProductList);
    _searchedProductList = searchedProductList;
  }

  fetchSearchedProduct(context, searchQuery) async {
    var response = await searchServices.fetchSearchedProduct(context:context,  searchQuery: searchQuery);
    //  print(response);
    if (response is Success) {
      print(response.response);

      setSearchedProduct(response.response as List<ProductModel>);
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
