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

class ProductDetailsServices {
  void addToCart({
    required BuildContext context,
    required var product,
  }) async {
    final userProvider = Provider.of<AuthViewModel>(context, listen: false);

    try {
      http.Response res = await http.post(
        Uri.parse('$uri/api/add-to-cart'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token':
              "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjYyZTBlYzA4OTE5ZGJlZGQ3NjE3ZWM2NSIsImlhdCI6MTY1ODkwODU2Mn0.dIs1dpzQU3U1NvjsaYJlsRqy2310JXfsrwUtrOi94UI",
        },
        body: jsonEncode({
          'id': product!,
        }),
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

  void rateProduct({
    required BuildContext context,
    required var product,
    required double rating,
  }) async {
    final userProvider = Provider.of<AuthViewModel>(context, listen: false);

    try {
      http.Response res = await http.post(
        Uri.parse('$uri/api/rate-product'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token':
              "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjYyZTBlYzA4OTE5ZGJlZGQ3NjE3ZWM2NSIsImlhdCI6MTY1ODkwODU2Mn0.dIs1dpzQU3U1NvjsaYJlsRqy2310JXfsrwUtrOi94UI",
        },
        body: jsonEncode({
          'id': product.id!,
          'rating': rating,
        }),
      );

      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {},
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }
}
