import 'package:flutter/material.dart';
import 'package:i_shop/src/features/authentication/view_model/auth_view_modal.dart';
import 'package:provider/provider.dart';

class ToggleBotton extends StatelessWidget {
  const ToggleBotton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<AuthViewModel>(context);
    return Switch.adaptive(
        value: provider.isSeller,
        onChanged: (value) {
          // final provider = Provider.of<AuthViewModel>(context, listen: false);
          provider.toggleUserRole(value);
        });
  }
}
