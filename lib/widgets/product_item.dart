 import 'package:flutter/material.dart';

class ProductItem extends StatelessWidget {
  final String id;
  final String title;
  final String imageUrl;

  ProductItem(this.id, this.title, this.imageUrl);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: GridTile(
        // to show the image of product
          child: Image.network(
            imageUrl,
            fit: BoxFit.cover,
          ),
          // it will create a strip to show the title and other icons
        footer: GridTileBar(
          backgroundColor: Colors.black54,
         // starting we will have fav icon which we will implement to make screens fav
          leading: IconButton(
            icon: Icon(Icons.favorite),
            onPressed: () {},
          ),
          title: Text(
            title,
            textAlign: TextAlign.center,
          ),
          trailing: IconButton(
            icon: Icon(
              Icons.shopping_cart,
            ),
            onPressed: () {},
          ),
        ),
      ),
    );
  }
}
