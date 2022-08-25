import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:i_shop/src/core/utilities/constants/utils.dart';

void   httpErrorHandle({
  required http.Response response,
  required BuildContext context,
  required VoidCallback onSuccess,
}) {
  switch (response.statusCode) {
    case 200:
      onSuccess();
      break;
    case 400:
      showSnackBar(context, jsonDecode(response.body)['msg']);
      break;
    case 101:
      showSnackBar(context, "Please check your connection");
      break;
    case 102:
      showSnackBar(context, "Invalid format");
      break;
    case 103:
      showSnackBar(context, "Unkwon Error");
      break;
    case 500:
      showSnackBar(context, jsonDecode(response.body)['error']);
      break;
    default:
      showSnackBar(context, response.body);
  }
}
