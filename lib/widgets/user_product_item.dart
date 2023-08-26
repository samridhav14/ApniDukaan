import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/products_provider.dart';
import '../screens/edit_product_screen.dart';

class UserProductItem extends StatelessWidget {
  final String title;
  final String imageUrl;
   final String id;
  UserProductItem(this.title, this.imageUrl, this.id);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(title),
      leading: CircleAvatar(
        // here we have used a provider we cant use fitter and all on this it just fetch the image
        backgroundImage: NetworkImage(imageUrl),
      ),
      trailing: Container(
        // we need to fix the width
        width: 100,
        child: Row(
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.edit),
              onPressed: () {
                Navigator.of(context).pushNamed(EditProductScreen.routeName, arguments: id);
              },
              color: Theme.of(context).primaryColor,
            ),
            IconButton(
              icon: Icon(Icons.delete),
              onPressed: () {
                Provider.of<Products>(context , listen: false).deleteProduct(id);
              },
              color: Theme.of(context).colorScheme.error,
            ),
          ],
        ),
      ),
    );
  }
}
