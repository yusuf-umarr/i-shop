import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../../../core/utilities/constants/error_handling.dart';
import '../../../core/utilities/constants/global_variables.dart';
import '../../../core/utilities/constants/utils.dart';
import '../model/user_model.dart';

class AuthService {

  static Future signUp(UserModel model, context) async {
    try {
      http.Response res = await http.post(
        Uri.parse('$uri/api/signup'),
        body: jsonEncode(model.toJson()),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );

      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          showSnackBar(
            context,
            'Account created! Login with the same credentials!',
          );
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  static Future<Object> login(UserModel model) async {

    try {
      http.Response res = await http.post(
        Uri.parse('$uri/api/signin'),
        body: jsonEncode(model.toJson()),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      if (res.statusCode == 200) {
        SharedPreferences prefs = await SharedPreferences.getInstance();

        await prefs.setString('x-auth-token', jsonDecode(res.body)['token']);
        await prefs.setString('role-type', jsonDecode(res.body)['type']);



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
      return Failure(code: USER_INVALID_RESPONSE, errorResponse: 'Unknown Error');
    }
  }

  // get user data
  static Future getUserData(
   
  ) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('x-auth-token');

      if (token == null) {
        prefs.setString('x-auth-token', '');
      }

      var tokenRes = await http.post(
        Uri.parse('$uri/tokenIsValid'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token':
              token!
        },
      );

      var response = jsonDecode(tokenRes.body);

      if (response == true) {
        http.Response userRes = await http.get(
          Uri.parse('$uri/'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'x-auth-token':
                token
          },
        );

      return Success(response: userModelFromJson(userRes.body));
      }
        return Failure(
          code: UNKNOWN_ERROR, errorResponse: jsonDecode(tokenRes.body)['msg']);

    } on HttpException {
      return Failure(
          code: NO_INTERNET, errorResponse: 'Please check your connection');
    } on SocketException {
      return Failure(
          code: NO_INTERNET, errorResponse: 'Please check your connection');
    } on FormatException {
      return Failure(code: INVALID_FORMAT, errorResponse: 'Invalid Format');
    } catch (e) {
      return Failure(code: USER_INVALID_RESPONSE, errorResponse: 'Invalid Response');
    }
  }


}
