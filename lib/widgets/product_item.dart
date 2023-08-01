import 'package:flutter/material.dart';
import '../screens/product_detail_screen.dart';

class ProductItem extends StatelessWidget {
  final String id;
  final String title;
  final String imageUrl;

  ProductItem(this.id, this.title, this.imageUrl);

  @override
  Widget build(BuildContext context) {
    // here we use clipppreact so that we can use circular borders
    return ClipRRect(
      // setting up border radius for border
      borderRadius: BorderRadius.circular(10),
      child: GridTile(
        // to show the image of product
        footer: GridTileBar(
          backgroundColor: Colors.black87,
          // starting we will have fav icon which we will implement to make screens fav
          leading: IconButton(
            icon: Icon(Icons.favorite),
            onPressed: () {},
            color: Theme.of(context).colorScheme.secondary,
          ),
          title: Text(
            title,
            textAlign: TextAlign.center,
          ),
          trailing: IconButton(
            icon: Icon(
              Icons.shopping_cart,
            ),
            color: Theme.of(context).colorScheme.secondary,
            onPressed: () {},
          ),
        ),
        // as we know image is not directly tappeble we use gesture detector to do this
        child: GestureDetector(
          onTap: () {
            // there are two problems for a bigger app it wont be a good idea 
            //because there will too many navigator and we need to find each of them manually to make an change and 
            //the othe problem is that if we need some data which is not present in the page from we are passing then we need to first get that data from somwhere and app will be too laggy we need a central state management thing  
            // Navigator.of(context).push(
            //   MaterialPageRoute(
            //       builder: (ctx) => ProductDetainScreen(
            //             title: title,
            //           )),
            //);
            // we are only sending id so that we canfetch all data wherever we want
            Navigator.of(context).pushNamed(ProductDetailScreen.routeName ,arguments: id);
          },
          child: Image.network(
            // to show the image of product
            imageUrl,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
