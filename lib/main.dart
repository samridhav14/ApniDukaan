import 'package:flutter/material.dart';
import '../screens/product_view_screen.dart';
import '../screens/product_detail_screen.dart'; 

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
      colorScheme:ColorScheme.fromSwatch().copyWith(primary: Colors.green,secondary: Colors.pink),
      fontFamily: 'Lato',
      ),
      home: ProductOverviewScreen(),
      routes: {
         ProductDetainScreen.routeName:(context) => ProductDetainScreen(),
      },
    );
  }
}


