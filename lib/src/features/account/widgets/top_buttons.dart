import 'package:flutter/material.dart';
import 'package:i_shop/src/features/account/widgets/modal_pop.dart';
import 'package:i_shop/src/features/authentication/view_model/auth_view_modal.dart';
import 'package:provider/provider.dart';

import '../services/account_services.dart';
import 'account_button.dart';

class TopButtons extends StatelessWidget {
  const TopButtons({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 10),
        Row(
          children: [
            Consumer<AuthViewModel>(builder: (context, val, _) {
              return AccountButton(
                text: val.userModel!.type == "user"
                    ? 'Become A Seller'
                    : val.isSeller == true
                        ? "Switch to Buyer"
                        : "Switch to Seller",
                onTap: val.userModel!.type == "user"
                    ? () {
                        showModalBottomSheet<dynamic>(
                            isScrollControlled: true,
                            backgroundColor: Colors.black.withOpacity(0.6),
                            barrierColor: Colors.black.withOpacity(0.6),
                            context: context,
                            builder: ((builder) => const ModalPopUp(
                                title: "Become A Seller",
                                description:
                                    "You atr about to become a seller")));
                      }
                    : () {
                        val.toggleUserRole(true);
                      },
              );
            }),
            AccountButton(
              text: 'Log Out',
              onTap: () => AccountServices().logOut(context),
            ),
          ],
        ),
        const SizedBox(height: 10),
        // Row(
        //   children: [
        //     AccountButton(
        //       text: 'Log Out',
        //       onTap: () => AccountServices().logOut(context),
        //     ),
        //     AccountButton(
        //       text: 'Your Wish List',
        //       onTap: () {},
        //     ),
        //   ],
        // ),
      ],
    );
  }
}
