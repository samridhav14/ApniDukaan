import 'package:flutter/material.dart';

class ProductDetainScreen extends StatelessWidget {
  // final String title;
  //  ProductDetainScreen({required this.title});
static const routeName='/product-detail';

  @override
  Widget build(BuildContext context) {
 final product_id= ModalRoute.of(context)!.settings.arguments as String; 
    return Scaffold(
      appBar: AppBar(
        title: Text('title'),
      ),
    ); 
  }
}