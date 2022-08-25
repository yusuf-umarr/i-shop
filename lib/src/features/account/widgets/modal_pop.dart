import 'dart:async';

import 'package:flutter/material.dart';
import 'package:i_shop/src/features/authentication/view_model/auth_view_modal.dart';
import 'package:provider/provider.dart';

class ModalPopUp extends StatelessWidget {
  final String? title;
  final String? description;
  final double? height;
  final double? descPadding;
  final Function()? proceedOntap;

  const ModalPopUp(
      {Key? key,
      this.title,
      this.description,
      this.height,
      this.descPadding,
      this.proceedOntap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        height: MediaQuery.of(context).size.height,
        child: Stack(children: [
          Positioned(
              child: Align(
            alignment: Alignment.center,
            child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                height: height ?? 150,
                width: MediaQuery.of(context).size.width - 40,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20)),
                child: PopupDialog(
                  titleText: title,
                  descriptionText: description,
                  descPadding: descPadding,
                  cancelOntap: () {
                    Navigator.of(context, rootNavigator: true).pop(context);
                  },
                  proceedOntap: () {
                    Provider.of<AuthViewModel>(context, listen: false)
                        .becomeSeller(context);

                    //becomeSeller(context)
                    Navigator.of(context, rootNavigator: true).pop(context);
                  },
                )),
          ))
        ]));
  }
}

class PopupDialog extends StatelessWidget {
  final String? titleText;
  final String? descriptionText;
  final Function()? cancelOntap;
  final Function()? proceedOntap;
  final double? descPadding;
  const PopupDialog(
      {Key? key,
      this.titleText,
      this.descriptionText,
      this.cancelOntap,
      this.proceedOntap,
      this.descPadding})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height - 85,
      child: ListView(
        children: [
          Column(
            children: [
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text(titleText!,
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                    )),
              ),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: descPadding ?? 20),
                child: Text(
                  descriptionText!,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  children: [
                    InkWell(
                      onTap: cancelOntap,
                      child: const Text("Cancel",
                          style: TextStyle(color: Colors.red)),
                    ),
                    const Spacer(),
                    InkWell(
                      onTap: proceedOntap,
                      child: const Text("Proceed",
                          style: TextStyle(color: Colors.blue)),
                    ),
                  ],
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
