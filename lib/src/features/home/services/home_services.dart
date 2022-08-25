import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:i_shop/src/features/account/model/product_deal_day.dart';
import 'package:i_shop/src/features/authentication/view_model/auth_view_modal.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

import '../../../core/utilities/constants/error_handling.dart';
import '../../../core/utilities/constants/global_variables.dart';
import '../../../core/utilities/constants/utils.dart';
import '../../account/model/product_model.dart';

class HomeServices {
  Future<Object> fetchCategoryProducts({
    required BuildContext context,
    required String category,
  }) async {
    // final userProvider = Provider.of<AuthViewModel>(context, listen: false);
    try {
      http.Response res = await http
          .get(Uri.parse('$uri/api/products?category=$category'), headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'x-auth-token':
            "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjYyZTBlYzA4OTE5ZGJlZGQ3NjE3ZWM2NSIsImlhdCI6MTY1ODkwODU2Mn0.dIs1dpzQU3U1NvjsaYJlsRqy2310JXfsrwUtrOi94UI",
      });

      if (200 == res.statusCode) {
        // print("seen!!!!");
        // print("seen!!!!");
        // print(res.body);

        return Success(response: productModelFromJson(res.body));
      }
      return Failure(
          code: USER_INVALID_RESPONSE,
          errorResponse: jsonDecode(res.body)['msg']);
    } on HttpException {
      return Failure(
          code: NO_INTERNET, errorResponse: 'Please check your connection');
    } on SocketException {
      return Failure(
          code: NO_INTERNET, errorResponse: 'Please check your connection');
    } on FormatException {
      return Failure(code: INVALID_FORMAT, errorResponse: 'Invalid Format');
    } catch (e) {
      return Failure(code: UNKNOWN_ERROR, errorResponse: 'Unknown Error');
    }
  }

  Future<DealOfTheDayModel> fetchDealOfDay({
    required BuildContext context,
  }) async {
    final userProvider = Provider.of<AuthViewModel>(context, listen: false);
    DealOfTheDayModel product = DealOfTheDayModel(
      name: '',
      description: '',
      quantity: 0,
      images: [],
      category: '',
      price: 0,
    );

    try {
      http.Response res =
          await http.get(Uri.parse('$uri/api/deal-of-day'), headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'x-auth-token':
            "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjYyZTBlYzA4OTE5ZGJlZGQ3NjE3ZWM2NSIsImlhdCI6MTY1ODkwODU2Mn0.dIs1dpzQU3U1NvjsaYJlsRqy2310JXfsrwUtrOi94UI",
      });

      // print(res.body);

      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          product = dealOfTheDayFromJson(res.body);
        },
      );

     
    } catch (e) {
      showSnackBar(context, e.toString());
    }
    return product;
  }
}
