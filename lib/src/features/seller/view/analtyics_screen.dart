import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';
import 'package:i_shop/src/features/account/widgets/top_buttons.dart';

import 'package:i_shop/src/features/seller/models/sales.dart';
import 'package:i_shop/src/features/seller/services/seller_services.dart';
import 'package:i_shop/src/features/seller/widgets/category_products_chart.dart';
import 'package:i_shop/src/widgets/loader.dart';
// import 'package:charts_flutter/flutter.dart';

class AnalyticsScreen extends StatefulWidget {
  const AnalyticsScreen({Key? key}) : super(key: key);

  @override
  State<AnalyticsScreen> createState() => _AnalyticsScreenState();
}

class _AnalyticsScreenState extends State<AnalyticsScreen> {
  final AdminServices adminServices = AdminServices();
  int? totalSales;
  List<Sales>? earnings;

  @override
  void initState() {
    super.initState();
    getEarnings();
  }

  getEarnings() async {
    var earningData = await adminServices.getEarnings(context);
    totalSales = earningData['totalEarnings'];
    earnings = earningData['sales'];
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    //
    return Scaffold(
       appBar:
          AppBar(title: const Text("Seller"), backgroundColor: Colors.green),
      body: SafeArea(
        child: Column(
          children: [
            const TopButtons(),
            const SizedBox(
              height: 20,
            ),
            earnings == null || totalSales == null
                ? const Loader()
                : Column(
                    children: [
                      Text(
                        '\$$totalSales',
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        height: 250,
                        child: CategoryProductsChart(seriesList: [
                          charts.Series(
                            id: 'Sales',
                            data: earnings!,
                            domainFn: (Sales sales, _) => sales.label,
                            measureFn: (Sales sales, _) => sales.earning,
                          ),
                        ]),
                      )
                    ],
                  )
          ],
        ),
      ),
    );
  }
}
