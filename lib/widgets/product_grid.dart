import 'package:flutter/material.dart';
import 'package:shopapp/providers/products_provider.dart';
import '../widgets/product_item.dart';
import 'package:provider/provider.dart';

class ProductsGrid extends StatelessWidget {
    final bool showFavs;

  const ProductsGrid(this.showFavs, {super.key});
  @override
  Widget build(BuildContext context) {
    final productsdata = Provider.of<Products>(context);
    final products = showFavs ? productsdata.favoriteItems : productsdata.items;
    return GridView.builder(
      padding: const EdgeInsets.all(10.0),
      itemCount: products.length,
      // we will pass id,title,image url to print our product and we will do it in a seprate widget for better code redability
     // we will use .value approach if a object is already there and we reuse its value where as in create we will prefer for new obj 
      itemBuilder: (ctx, i) => ChangeNotifierProvider.value(
       value: products[i],
        child: const ProductItem(
          // loadedProducts[i].id,
          // loadedProducts[i].title,
          // loadedProducts[i].imageUrl,
        ),
      ),
      // grid delegate allow us grid should be structured
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        // we want 2 column in grid
        crossAxisCount: 2,
        // we want more height less width
        childAspectRatio: 3 / 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
    );
  }
}
