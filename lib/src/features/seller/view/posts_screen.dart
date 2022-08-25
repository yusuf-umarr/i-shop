import 'package:flutter/material.dart';
import 'package:i_shop/src/features/account/model/product_model.dart';
import 'package:i_shop/src/features/account/widgets/single_product.dart';
import 'package:i_shop/src/features/seller/services/seller_services.dart';
import 'package:i_shop/src/features/seller/view/add_product_screen.dart';
import 'package:i_shop/src/features/seller/view_model/seller_view_model.dart';
import 'package:provider/provider.dart';

class PostsScreen extends StatefulWidget {
  const PostsScreen({Key? key}) : super(key: key);

  @override
  State<PostsScreen> createState() => _PostsScreenState();
}

class _PostsScreenState extends State<PostsScreen> {
  List<Product>? products;
  List<ProductModel>? productList;
  final AdminServices adminServices = AdminServices();

  void deleteProduct(ProductModel product, int index) {
    adminServices.deleteProduct(
      context: context,
      product: product,
      onSuccess: () {
        products!.removeAt(index);
        setState(() {});
      },
    );
  }

  void navigateToAddProduct() {
    Navigator.pushNamed(context, AddProductScreen.routeName);
  }

  @override
  Widget build(BuildContext context) {
    SellerViewModel sellerViewModel =
        context.watch<SellerViewModel>(); //productListModel

    return Scaffold(
      appBar:
          AppBar(title: const Text("Seller"), backgroundColor: Colors.green),
      body: sellerViewModel.productListModel.isEmpty
          ? const Center(child: Text("No Product avilable"))
          : GridView.builder(
              itemCount: sellerViewModel.productListModel.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, //no of item to display in row
              ),
              itemBuilder: (context, index) {
                ProductModel productData =
                    sellerViewModel.productListModel[index];
                return Column(
                  children: [
                    SizedBox(
                      height: 130,
                      child: SingleProduct(
                        image: productData.images![0],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Expanded(
                          child: Text(
                            productData.name!,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                          ),
                        ),
                        IconButton(
                          onPressed: () => deleteProduct(productData, index),
                          icon: const Icon(
                            Icons.delete_outline,
                          ),
                        ),
                      ],
                    ),
                  ],
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: navigateToAddProduct,
        tooltip: 'Add a Product',
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
