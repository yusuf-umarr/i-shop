import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:i_shop/src/core/utilities/constants/global_variables.dart';
import 'package:i_shop/src/core/utilities/constants/utils.dart';
import 'package:i_shop/src/features/account/model/product_model.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class SearchServices {
  Future<Object> fetchSearchedProduct({
    required BuildContext context,
    required String searchQuery,
  }) async {
    // final userProvider = Provider.of<UserProvider>(context, listen: false);
    List<Object> productList = [];
    try {
      http.Response res = await http.get(
        Uri.parse('$uri/api/products/search/$searchQuery'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjYyZTBlYzA4OTE5ZGJlZGQ3NjE3ZWM2NSIsImlhdCI6MTY1ODkwODU2Mn0.dIs1dpzQU3U1NvjsaYJlsRqy2310JXfsrwUtrOi94UI",
        },
      );

       if (200 == res.statusCode) {

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

}
