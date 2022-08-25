import 'package:flutter/material.dart';
import 'package:i_shop/src/features/account/view_model/account_view_model.dart';
import 'package:i_shop/src/features/account/widgets/single_product.dart';
import 'package:i_shop/src/features/other_detail/view/other_detail_screen.dart';
import 'package:provider/provider.dart';

import '../../../core/utilities/constants/global_variables.dart';
import '../../../widgets/loader.dart';
import '../model/order_model.dart';
import '../services/account_services.dart';

class Orders extends StatefulWidget {
  const Orders({Key? key}) : super(key: key);

  @override
  State<Orders> createState() => _OrdersState();
}

class _OrdersState extends State<Orders> {
  List<Order>? orders;
  List<OrderModel>? orderProducts;
  final AccountServices accountServices = AccountServices();

  @override
  void initState() {
    super.initState();

    fetchOrders();
  }

  void fetchOrders() async {
    final provider = Provider.of<AccountViewModel>(context, listen: false);

    await provider.fetchOrderProduct(context);

    orderProducts = provider.orderProductList;

    orders =
        (await accountServices.fetchMyOrders(context: context)).cast<Order>();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    AccountViewModel accountViewModel = context.watch<AccountViewModel>();
    return Column(
      children: [
        orderProducts == null
            ? const Loader()
            : orderProducts!.isEmpty
                ? const Center(child: Text("You have no order "))
                : Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            padding: const EdgeInsets.only(
                              left: 15,
                            ),
                            child: const Text(
                              'Your Orders',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.only(
                              right: 15,
                            ),
                            child: Text(
                              'See all',
                              style: TextStyle(
                                color: GlobalVariables.selectedNavBarColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                      // display orders
                      Container(
                        height: 250,
                        padding: const EdgeInsets.only(
                          left: 10,
                          top: 20,
                          right: 0,
                        ),
                        child: ListView.builder(
                          scrollDirection: Axis.vertical,
                          itemCount: accountViewModel.orderProductList.length,
                          itemBuilder: (context, index) {
                            var product =
                                accountViewModel.orderProductList[index];

                            return GestureDetector(
                                onTap: () {
                                  Navigator.pushNamed(
                                    context,
                                    OrderDetailScreen.routeName,
                                    arguments: orderProducts![index],
                                  );
                                },
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        Text("S/N - ${index + 1}"),
                                        SizedBox(width: 10),
                                        Text(product.id!),
                                      ],
                                    ),

                                    SizedBox(height: 10),

                                    Row(
                                      children: [
                                        for (int i = 0;
                                            i < product.products!.length;
                                            i++)
                                          Row(
                                            children: [
                                              Image.network(
                                                product.products![i]["product"]
                                                    ["images"][0],
                                                height: 90,
                                                width: 120,
                                              ),
                                              const SizedBox(width: 5),
                                            ],
                                          ),
                                      ],
                                    )

                                    // SingleProduct(
                                    //   image: product.products![0].images[0],
                                    // ),

                                    // Text(productList[0]["status"])
                                  ],
                                ));
                          },
                        ),
                      ),
                    ],
                  )
      ],
    );
  }
}
