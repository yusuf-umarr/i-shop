import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:i_shop/src/core/utilities/constants/error_handling.dart';
import 'package:i_shop/src/core/utilities/constants/global_variables.dart';
import 'package:i_shop/src/core/utilities/constants/utils.dart';
import 'package:i_shop/src/features/account/model/product_model.dart';
import 'package:i_shop/src/features/authentication/model/user_model.dart';
import 'package:i_shop/src/features/authentication/view_model/auth_view_modal.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class CartServices {
  void removeFromCart({
    required BuildContext context,
    required var product,
  }) async {
    final userProvider = Provider.of<AuthViewModel>(context, listen: false);

    try {
      http.Response res = await http.delete(
        Uri.parse('$uri/api/remove-from-cart/${product}'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userProvider.user.token,
        },
      );

      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          User user =
              userProvider.user.copyWith(cart: jsonDecode(res.body)['cart']);
          userProvider.setUserFromModel(user);
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }
}
