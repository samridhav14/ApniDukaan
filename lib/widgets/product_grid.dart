import 'package:flutter/material.dart';
import 'package:shopapp/providers/products_provider.dart';
import '../widgets/product_item.dart';
import 'package:provider/provider.dart';

class ProductsGrid extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final productsdata = Provider.of<Products>(context);
    final loadedProducts =productsdata.items;
    return GridView.builder(
      padding:const  EdgeInsets.all(10.0),
      itemCount: loadedProducts.length,
      // we will pass id,title,image url to print our product and we will do it in a seprate widget for better code redability
       itemBuilder: (ctx,i)=>ProductItem(loadedProducts[i].id,loadedProducts[i].title,loadedProducts[i].imageUrl),
      // grid delegate allow us grid should be structured
      gridDelegate:const SliverGridDelegateWithFixedCrossAxisCount(
        // we want 2 column in grid
        crossAxisCount: 2,
        // we want more height less width
        childAspectRatio: 3/2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ) , 
      );
  }
}