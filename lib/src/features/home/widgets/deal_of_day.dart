import 'package:flutter/material.dart';
import 'package:i_shop/src/features/account/model/product_deal_day.dart';
import 'package:i_shop/src/features/home/view_model/home_view_model.dart';
import 'package:i_shop/src/features/product_details/view/product_details_screen.dart';
import 'package:provider/provider.dart';

import '../../../widgets/loader.dart';
import '../../account/model/product_model.dart';
import '../services/home_services.dart';

class DealOfDay extends StatefulWidget {
  const DealOfDay({Key? key}) : super(key: key);

  @override
  State<DealOfDay> createState() => _DealOfDayState();
}

class _DealOfDayState extends State<DealOfDay> {
  var product;
  final HomeServices homeServices = HomeServices();

  @override
  void initState() {
    super.initState();
    fetchDealOfDay();
  }

  void fetchDealOfDay() async {
    final provider = Provider.of<HomeViewModel>(context, listen: false);

    provider.fetchDealOfDay(context);
    // product = await homeServices.fetchDealOfDay(context: context);
  }

  navigateToDetailScreen(productDeal) {
    final provider = Provider.of<HomeViewModel>(context, listen: false);

    provider.setSelectedProduct(productDeal);

    Navigator.pushNamed(
      context,
      ProductDetailScreen.routeName,
      arguments: product,
    );
  }

  @override
  Widget build(BuildContext context) {
    var productDeal = context.watch<HomeViewModel>().dealOfDayProduct;
    var homeViewModel = context.watch<HomeViewModel>();
    // product = homeViewModel.dealOfDayProduct;
    // print(productDeal);
    return productDeal == null
        ? const Loader()
        : productDeal!.name!.isEmpty
            ? const SizedBox()
            : GestureDetector(
                // onTap: navigateToDetailScreen(productDeal),
                 onTap: () {
                    homeViewModel.setSelectedProduct(productDeal);
                    Navigator.pushNamed(
                      context,
                      ProductDetailScreen.routeName,
                      // arguments: productDeal,
                    );
                  },
                child: Column(
                  children: [
                    Container(
                      alignment: Alignment.topLeft,
                      padding: const EdgeInsets.only(left: 10, top: 15),
                      child: const Text(
                        'Deal of the day',
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                    Image.network(
                      productDeal!.images![0],
                      height: 235,
                      fit: BoxFit.fitHeight,
                    ),
                    Container(
                      padding: const EdgeInsets.only(left: 15),
                      alignment: Alignment.topLeft,
                      child: const Text(
                        '\$100',
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                    Container(
                      alignment: Alignment.topLeft,
                      padding:
                          const EdgeInsets.only(left: 15, top: 5, right: 40),
                      child: const Text(
                        'Rivaan',
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: productDeal!.images!
                            .map<Widget>(
                              (e) => Image.network(
                                e,
                                fit: BoxFit.fitWidth,
                                width: 100,
                                height: 100,
                              ),
                            )
                            .toList(),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        vertical: 15,
                      ).copyWith(left: 15),
                      alignment: Alignment.topLeft,
                      child: Text(
                        'See all deals',
                        style: TextStyle(
                          color: Colors.cyan[800],
                        ),
                      ),
                    ),
                  ],
                ),
              );
  }
}
