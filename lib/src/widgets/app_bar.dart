import 'package:flutter/material.dart';
import 'package:i_shop/src/features/authentication/view_model/auth_view_modal.dart';
import 'package:i_shop/src/widgets/toggle_btn.dart';
import 'package:provider/provider.dart';

class AppBarWidget extends StatelessWidget {
  const AppBarWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<AuthViewModel>(context).userModel!.type;

    return Container(
      decoration: BoxDecoration(color: Colors.green),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(provider == "user" ? "Buyer" : "Seller"),
          const ToggleBotton(),
        ],
      ),
    );
  }
}
