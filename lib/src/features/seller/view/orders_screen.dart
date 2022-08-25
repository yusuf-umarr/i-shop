import 'package:flutter/material.dart';
import 'package:i_shop/src/features/account/model/order_model.dart';
import 'package:i_shop/src/features/other_detail/view/other_detail_screen.dart';
import 'package:i_shop/src/features/seller/services/seller_services.dart';
import 'package:i_shop/src/widgets/loader.dart';


class OrdersScreen extends StatefulWidget {
  const OrdersScreen({Key? key}) : super(key: key);

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  List<Order>? orders;
  final AdminServices adminServices = AdminServices();

  @override
  void initState() {
    super.initState();
    fetchOrders();
  }

  void fetchOrders() async {
    orders = (await adminServices.fetchAllOrders(context)).cast<Order>();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
          AppBar(title: const Text("Seller"), backgroundColor: Colors.green), 
      body: SafeArea(
        child: Column(
          children: [
            orders == null
                ? const Loader()
                : GridView.builder(
                    itemCount: orders!.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2),
                    itemBuilder: (context, index) {
                      final orderData = orders![index];
                      // print(orderData.products);
                      return Column(
                        children: [
                          // Text(orderData.)
                          GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(
                                context,
                                OrderDetailScreen.routeName,
                                arguments: orderData,
                              );
                            },
                            child: const SizedBox(
                              height: 140,
                              // child: SingleProduct(
                              //   image: orderData.products[0].images[0],
                              // ),
                            ),
                          ),
                        ],
                      );
                    },
                  )
          ],
        ),
      ),
    );
  }
}
