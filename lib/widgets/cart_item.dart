import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/cart.dart';

class CartItem extends StatelessWidget {
  final String id;
  // this we want to show we can take as much item as much we want
  final String productId;
  final double price;
  final int quantity;
  final String title;

  CartItem(
    this.id,
    this.productId,
    this.price,
    this.quantity,
    this.title,
  );

  @override
  Widget build(BuildContext context) {
    // dissmissible will help us to remove things fron ui
    return Dismissible(
      // key helps to remove if any issue occur basically somth work of dismissible is done
      key: ValueKey(id),
      // back groud colour to be shown whle deleting
      background: Container(
        color: Theme.of(context).colorScheme.error,
        // this will help user how that things are deleting
        child: Icon(
          Icons.delete,
          color: Colors.white,
          size: 40,
        ),
        alignment: Alignment.centerRight,
        padding: EdgeInsets.only(right: 20),
        margin: EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 4,
        ),
      ),
      // stops both side removal
      direction: DismissDirection.endToStart,
      // logically removing products here we use direction because we can assign diff task to different direction
      onDismissed: (direction) {
        // listen is off because we dont use this if we add anything
        Provider.of<Cart>(context, listen: false).removeItem(productId);
      },
      child: Card(
        margin: EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 4,
        ),
        child: Padding(
          padding: EdgeInsets.all(8),
          child: ListTile(
            leading: CircleAvatar(
              child: Padding(
                padding: EdgeInsets.all(5),
                // we need to use fitted box so that it dont overflow the money 
                child: FittedBox(
                  child: Text('\$$price'),
                ),
              ),
            ),
            title: Text(title),
            // string interpolation
            subtitle: Text('Total: \$${(price * quantity)}'),
            // no of item to be bought
            trailing: Text('$quantity x'),
          ),
        ),
      ),
    );
  }
}
