import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
// we can also use as here
import '../providers/cart.dart' show Cart;
import '../widgets/cart_item.dart';
import '../providers/orders.dart';

class CartScreen extends StatelessWidget {
  // to go to cart screen we use routename
  static const routeName = '/cart';

  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Cart'),
      ),
      body: Column(
        children: <Widget>[
          Card(
            margin: const EdgeInsets.all(15),
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  const Text(
                    'Total',
                    style: TextStyle(fontSize: 20),
                  ),
                  const Spacer(), // it take all the spaceit can take
                  // similar to badge element with rounded corner
                  Chip(
                    label: Text(
                      '\$${cart.totalAmount.toStringAsFixed(2)}',
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
                    onPressed: () {
                      //logic to add new prd 
                      Provider.of<Orders>(context, listen: false).addOrder(
                          cart.items.values.toList(), cart.totalAmount);
                      cart.clear();
                    },
                    style: TextButton.styleFrom(
                        textStyle: TextStyle(
                      color: Theme.of(context).colorScheme.primary,
                    )),
                    child: const Text('ORDER NOW'),
                  )
                ],
              ),
            ),
          ),
          const SizedBox(height: 10),
          Expanded(
            child: ListView.builder(
                itemCount: cart.items.length,
                itemBuilder: (ctx, i) {
                  final key = cart.items.keys.elementAt(i);
                  return CartItem(
                    // we have extacted value otherwise null error will be there
                    cart.items[key]!.id,
                    key,
                    cart.items[key]!.price,
                    cart.items[key]!.quantity,
                    cart.items[key]!.title,
                  );
                }),
          )
        ],
      ),
    );
  }
}
