import 'package:flutter/material.dart';
import 'package:i_shop/router.dart';
import 'package:i_shop/src/core/utilities/constants/global_variables.dart';
import 'package:i_shop/src/features/account/view_model/account_view_model.dart';

import 'package:i_shop/src/features/authentication/services/auth_service.dart';
import 'package:i_shop/src/features/authentication/view/auth_screen.dart';
import 'package:i_shop/src/features/authentication/view_model/auth_view_modal.dart';
import 'package:i_shop/src/features/bottomNav/view/bottom_nav_bar.dart';
import 'package:i_shop/src/features/home/view_model/home_view_model.dart';
import 'package:i_shop/src/features/search/view_model/search_view_model.dart';
import 'package:i_shop/src/features/seller/view_model/seller_view_model.dart';

import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences sharePreference = await SharedPreferences.getInstance();
  var token = sharePreference.getString('x-auth-token');
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(
      create: (context) => AuthViewModel(),
    ),
    ChangeNotifierProvider(
      create: (context) => SellerViewModel(),
    ),
    ChangeNotifierProvider(
      create: (context) => HomeViewModel(),
    ),
    ChangeNotifierProvider(
      create: (context) => SearchViewModel(),
    ),
    ChangeNotifierProvider(
      create: (context) => AccountViewModel(),
    ),
  ], child: MyApp(token: token,)));
}

class MyApp extends StatefulWidget {
  var token;

  MyApp({Key? key, required this.token, })
      : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
   final _messangerKey = GlobalKey<ScaffoldMessengerState>();

  final AuthService authService = AuthService();

  @override
  void initState() {
    super.initState();
    getUserData();
  }

  getUserData() async {
    await Provider.of<AuthViewModel>(context, listen: false)
        .getUserData(context);
  }

  @override
  Widget build(BuildContext context) {
    // print(widget.roleType);
    return MaterialApp(
      scaffoldMessengerKey: _messangerKey,
        title: 'iShop',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          scaffoldBackgroundColor: GlobalVariables.backgroundColor,
          colorScheme: const ColorScheme.light(
            primary: GlobalVariables.secondaryColor,
          ),
          appBarTheme: const AppBarTheme(
            elevation: 0,
            iconTheme: IconThemeData(
              color: Colors.black,
            ),
          ),
          useMaterial3: true,
        ),
        onGenerateRoute: (settings) => generateRoute(settings),
        // home: const AuthScreen()

        home: widget.token != null ? const BottomBar() : const AuthScreen());
  }
}
