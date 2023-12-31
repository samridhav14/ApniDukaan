import 'package:flutter/material.dart';

class CartItem {
  final String id;
  final String title;
  final int quantity;
  final double price;
  CartItem({
    required this.id,
    required this.title,
    required this.quantity,
    required this.price,
  });
}

class Cart with ChangeNotifier {
   Map<String, CartItem> _items={};
  Map<String, CartItem> get items {
    return {..._items};
  }
int get itemCount{
   return _items.length;
}
double get totalAmount{
  var total=0.0;
  // summing total
  _items.forEach((key, cartItem) {
      total+=(cartItem.price*cartItem.quantity);
   });
  return total;
}
void removeItem(String productId){
   _items.remove(productId);
   notifyListeners();
}
// if we place order
void clear(){
  _items={};
  notifyListeners();
}
// for undo things
void removeSingleItem(String productId){
    if(!_items.containsKey(productId)) return;
    if(_items[productId]!.quantity>1){
         _items.update(productId, (value) => CartItem(id: value.id, title: value.title, quantity: value.quantity-1, price: value.price));
    }
    else {
      _items.remove(productId);
    }
    notifyListeners();
}
// to add a new ietem in cart
  void addItem(String productId, double price, String title) {
    // if it already exist increase the quantity count
    if (_items.containsKey(productId)) {
      _items.update(
          productId,
          (value) => CartItem(
              id: value.id,
              title: value.title,
              quantity: value.quantity + 1,
              price: value.price));
    } 
    // adding new one
    else {
      _items.putIfAbsent(
          productId,
          () => CartItem(
              id: DateTime.now().toString(),
              title: title,
              quantity: 1,
              price: price));
    }
  }
  @override
  notifyListeners(); 
}
