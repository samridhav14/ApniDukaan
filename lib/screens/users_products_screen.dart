import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopapp/screens/edit_product_screen.dart';
import '../providers/products_provider.dart';
import '../widgets/app_drawer.dart';
import '../widgets/user_product_item.dart';

class UserProductsScreen extends StatelessWidget {
  static const routeName = '/user-products';

  @override
  Widget build(BuildContext context) {
    final productsData = Provider.of<Products>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Products'),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
          Navigator.of(context).pushNamed(EditProductScreen.routeName); 
            },
          ),
        ],
      ),
      drawer:const AppDrawer(),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: ListView.builder(
          // theoritically we can have infinite product
          itemCount: productsData.items.length,
          itemBuilder: (_, i) => Column(
                children: [
                  // to edit or delete already existing item
                  UserProductItem(
                    productsData.items[i].title,
                    productsData.items[i].imageUrl,
                    productsData.items[i].id!,
                  ),
                  const Divider(),
                ],
              ),
        ),
      ),
    );
  }
}
