

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

  const CartItem(
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
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 20),
        margin: const EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 4,
        ),
        // this will help user how that things are deleting
        child: const Icon(
          Icons.delete,
          color: Colors.white,
          size: 40,
        ),
      ),
      // stops both side removal
      direction: DismissDirection.endToStart,
      confirmDismiss: (direction){
           return showDialog(context: context, builder: (ctx)=>
              AlertDialog(
                title: const Text('Are you Sure?'),
                content: const Text('Do you want to remove the item from cart '),
                actions: [
                  TextButton(onPressed: () {
                      // we dont want to dissmiss
                      Navigator.of(context).pop();
                    }, child: const Text('NO'),),
                  TextButton(onPressed: () { 
                    // this will return true to delete
                     Navigator.of(context).pop(true);
                   }, child: const Text('YES'),),
                ],
              )
            );
      },
      // logically removing products here we use direction because we can assign diff task to different direction
      onDismissed: (direction) {
        // listen is off because we dont use this if we add anything
        Provider.of<Cart>(context, listen: false).removeItem(productId);
      },
      child: Card(
        margin: const EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 4,
        ),
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: ListTile(
            leading: CircleAvatar(
              child: Padding(
                padding: const EdgeInsets.all(5),
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
