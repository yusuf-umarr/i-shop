import 'dart:async';

import 'package:flutter/material.dart';
import 'package:i_shop/src/core/utilities/constants/utils.dart';
import 'package:i_shop/src/features/account/services/account_services.dart';
import 'package:i_shop/src/features/authentication/services/auth_service.dart';
import 'package:i_shop/src/features/bottomNav/view/bottom_nav_bar.dart';
import '../model/user_model.dart';

class AuthViewModel extends ChangeNotifier {
  bool isLoading = false;
  User _user = User(
    id: '',
    name: '',
    email: '',
    password: '',
    address: '',
    type: '',
    token: '',
    cart: [],
  );

  // bool isUser = false;

  User get user => _user;

  UserModel? _userModel;

  UserModel? get userModel => _userModel;

// var _isBuyer;

// bool get isBuyer =>userModel!.type =="user";
//userModel!.type
  bool isSeller = false;

  toggleUserRole(role) {
    isSeller = !isSeller;
    // isSeller = role ? true : false;

    notifyListeners();
  }

  void setUser(String user) {
    _user = User.fromJson(user);
    notifyListeners();
  }

  void getUser(User user) {
    _user = user;
    notifyListeners();
  }

  void setUserFromModel(User user) {
    _user = user;
    notifyListeners();
  }

  void setUserModel(UserModel userModel) {
    _userModel = userModel;

    notifyListeners();
  }

  setLoading(bool loading) async {
    isLoading = loading;
    notifyListeners();
  }

  register(model, context) {
    AuthService.signUp(model, context);
    notifyListeners();
  }

//login
  loginResponse(model, context) async {
    String password = model.password;

    if (password.length < 6) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.red,
          content: const Text("Password Error"),
          action: SnackBarAction(
            label: "Password must be 6 characters long",
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

      setLoading(false);

      return;
    }

    var response = await AuthService.login(model);
    if (response is Success) {
      setLoading(false);

      setUserModel(response.response as UserModel);
      notifyListeners();

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.green,
          content: const Text("Success!!!"),
          action: SnackBarAction(
            label: "Login Successfull!",
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

      Timer(const Duration(seconds: 3), () {
        Navigator.pushNamedAndRemoveUntil(
          context,
          BottomBar.routeName,
          (route) => false,
        );
      });
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

      setLoading(false);
    }
  }

  getUserData(context) async {
    var response = await AuthService.getUserData();
    if (response is Success) {
      setUserModel(response.response as UserModel);
      notifyListeners();
    }
    if (response is Failure) {
      UserError userError = UserError(
        code: response.code,
        message: response.errorResponse,
      );

      print(userError.message.toString());

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

  becomeSeller(context) async {
    var response = await AccountServices.becomeSeller();
    if (response is Success) {
      setUserModel(response.response as UserModel);
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
