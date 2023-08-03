import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
// we can also use as here 
import '../providers/cart.dart' show Cart;
import '../widgets/cart_item.dart';

class CartScreen extends StatelessWidget {
  // to go to cart screen we use routename
  static const routeName = '/cart';

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Cart'),
      ),
      body: Column(
        children: <Widget>[
          Card(
            margin: EdgeInsets.all(15),
            child: Padding(
              padding: EdgeInsets.all(8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    'Total',
                    style: TextStyle(fontSize: 20),
                  ),
                  Spacer(),// it take all the spaceit can take
                  // similar to badge element with rounded corner
                  Chip(
                    label: Text(
                      '\$${cart.totalAmount}',
                      style: TextStyle(
                        color: Theme.of(context).textTheme.titleLarge?.color,
                      ),
                    ),
                    backgroundColor: Theme.of(context).colorScheme.primary,
                  ),
                  // FlatButton(
                  //   child: Text('ORDER NOW'),
                  //   onPressed: () {},
                  //   textColor: Theme.of(context).primaryColor,
                  // )
                  // use text button because flat button is depriciated
                  TextButton(
                    onPressed: () {},
                   child: Text('ORDER NOW'),
                   style: TextButton.styleFrom(
                    textStyle: TextStyle(
                      color: Theme.of(context).colorScheme.primary,
                    )
                   ),
                   )
                ],
              ),
            ),
          ),
          SizedBox(height: 10),
          Expanded(
            child: ListView.builder(
              
              itemCount: cart.items.length,
              itemBuilder: (ctx, i){
                  final key=cart.items.keys.elementAt(i);
                return CartItem(
              
                // we have extacted value otherwise null error will be there
                cart.items[key]!.id,
                key,
                cart.items[key]!.price,
                cart.items[key]!.quantity,
                cart.items[key]!.title,
              );
              }
            ),
          )
        ],
      ),
    );
  }
}
