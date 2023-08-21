import 'package:flutter/material.dart';
import 'package:shopapp/screens/users_products_screen.dart';
import '../screens/orders_screen.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});


  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
         children: <Widget>[
          AppBar(
            title: const Text("Options"),
            // it will not add a back button
            automaticallyImplyLeading: false,
          ),
          const Divider(),
         ListTile(
          leading: const Icon(Icons.shop),
          title: const Text('Shop'),
          onTap: (){
            Navigator.of(context).pushReplacementNamed('/');
          },
         ),
          const Divider(),
         ListTile(
          leading: const Icon(Icons.payment),
          title: const Text('Orders'),
          onTap: (){
            Navigator.of(context).pushReplacementNamed(OrdersScreen.routeName);
          },
         ),
          const Divider(),
         ListTile(
          leading: const Icon(Icons.edit),
          title: const Text('ManageProducts'),
          onTap: (){
            Navigator.of(context).pushReplacementNamed(UserProductsScreen.routeName);
          },
         )
         ],
      ),
    );
  }
}