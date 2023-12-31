import 'package:flutter/material.dart';
import 'package:shopapp/providers/cart.dart';
import 'package:shopapp/providers/orders.dart';
import 'package:shopapp/screens/cart_screen.dart';
import 'package:shopapp/screens/edit_product_screen.dart';
import 'package:shopapp/screens/orders_screen.dart';
import 'package:shopapp/screens/users_products_screen.dart';
import '../screens/product_view_screen.dart';
import '../screens/product_detail_screen.dart';
import './providers/products_provider.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        //different notifier for diff data
        ChangeNotifierProvider(
          create: (context) => Products(),
        ),
        ChangeNotifierProvider.value(
          value: Cart(),
        ),
        ChangeNotifierProvider.value(value: Orders()),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSwatch()
              .copyWith(primary: Colors.green, secondary: Colors.pink),
          fontFamily: 'Lato',
          textTheme: const TextTheme(titleLarge: TextStyle(color: Colors.white)),
        ),
        home: const ProductOverviewScreen(),
        routes: {
          ProductDetailScreen.routeName: (context) => const ProductDetailScreen(),
          CartScreen.routeName: (context) => const CartScreen(),
          OrdersScreen.routeName:(context) => const OrdersScreen(),
          UserProductsScreen.routeName:(context) =>  UserProductsScreen(),
         EditProductScreen.routeName:(context) =>  EditProductScreen(),
        },
      ),
    );
  }
}
