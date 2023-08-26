
// this wiil define the model for our produnct what things it will have in it
import 'package:flutter/material.dart';

class Product with ChangeNotifier{
    String? id;
   String title;
   String description;
   double price;
   String imageUrl;
  bool isFavorite;
  Product(
      {
       required this.id,
      required this.title,
      required this.description,
      required this.price,
      required this.imageUrl,
      this.isFavorite=false});

  get items => null;


    void toggle(){
    isFavorite=!isFavorite;
    notifyListeners();
 }
}
 
