import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:i_shop/src/features/authentication/model/user_model.dart';
import 'package:i_shop/src/features/authentication/view/auth_screen.dart';
import 'package:i_shop/src/features/authentication/view_model/auth_view_modal.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../../../core/utilities/constants/error_handling.dart';
import '../../../core/utilities/constants/global_variables.dart';
import '../../../core/utilities/constants/utils.dart';
import '../model/order_model.dart';

class AccountServices {
  Future<List<Order>> fetchMyOrders({
    required BuildContext context,
  }) async {
    final authViewModel = Provider.of<AuthViewModel>(context, listen: false);
    List<Order> orderList = [];
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('x-auth-token');

      if (token == null) {
        prefs.setString('x-auth-token', '');
      }

      http.Response res =
          await http.get(Uri.parse('$uri/api/orders/me'), headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'x-auth-token': token!,
      });

      // httpErrorHandle(
      //   response: res,
      //   context: context,
      //   onSuccess: () {
      //     for (int i = 0; i < jsonDecode(res.body).length; i++) {
      //       orderList.add(
      //         Order.fromJson(
      //           jsonEncode(
      //             jsonDecode(res.body)[i],
      //           ),
      //         ),
      //       );
      //     }
      //   },
      // );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
    return orderList;
  }

  Future<Object> fetchMyOrder() async {
    // final authViewModel = Provider.of<AuthViewModel>(context, listen: false);
    // List<Order> orderList = [];
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('x-auth-token');

      if (token == null) {
        prefs.setString('x-auth-token', '');
      }

      http.Response res =
          await http.get(Uri.parse('$uri/api/orders/me'), headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'x-auth-token': token!,
      });

      if (200 == res.statusCode) {

        return Success(response: orderModelFromJson(res.body));
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

  static Future<Object> becomeSeller() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('x-auth-token');

    if (token == null) {
      prefs.setString('x-auth-token', '');
    }
    try {
      http.Response res = await http.post(
        Uri.parse('$uri/api/become-seller'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': token!
        },
      );
      if (res.statusCode == 200) {
        return Success(response: userModelFromJson(res.body));
      }
      return Failure(
          code: UNKNOWN_ERROR, errorResponse: jsonDecode(res.body)['msg']);
    } on HttpException {
      return Failure(
          code: NO_INTERNET, errorResponse: 'Please check your connection');
    } on SocketException {
      return Failure(
          code: NO_INTERNET, errorResponse: 'Please check your connection');
    } on FormatException {
      return Failure(code: INVALID_FORMAT, errorResponse: 'Invalid Format');
    } catch (e) {
      return Failure(
          code: USER_INVALID_RESPONSE, errorResponse: 'Unknown Error');
    }
  }

  void logOut(BuildContext context) async {
    try {
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      await sharedPreferences.remove('x-auth-token');
      Navigator.pushNamedAndRemoveUntil(
        context,
        AuthScreen.routeName,
        (route) => false,
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }
}
