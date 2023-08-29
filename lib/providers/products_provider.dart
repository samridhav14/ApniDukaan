import 'package:flutter/material.dart';
import 'dart:convert';
import 'product.dart';
import 'package:http/http.dart' as http;

class Products with ChangeNotifier {
  final List<Product> _items = [
    Product(
      id: 'p1',
      title: 'Red Shirt',
      description: 'A red shirt - it is pretty red!',
      price: 29.99,
      imageUrl:
          'https://cdn.pixabay.com/photo/2016/10/02/22/17/red-t-shirt-1710578_1280.jpg',
    ),
    Product(
      id: 'p2',
      title: 'Trousers',
      description: 'A nice pair of trousers.',
      price: 59.99,
      imageUrl:
          'https://upload.wikimedia.org/wikipedia/commons/thumb/e/e8/Trousers%2C_dress_%28AM_1960.022-8%29.jpg/512px-Trousers%2C_dress_%28AM_1960.022-8%29.jpg',
    ),
    Product(
      id: 'p3',
      title: 'Yellow Scarf',
      description: 'Warm and cozy - exactly what you need for the winter.',
      price: 19.99,
      imageUrl:
          'https://live.staticflickr.com/4043/4438260868_cc79b3369d_z.jpg',
    ),
    Product(
      id: 'p4',
      title: 'A Pan',
      description: 'Prepare any meal you want.',
      price: 49.99,
      imageUrl:
          'https://upload.wikimedia.org/wikipedia/commons/thumb/1/14/Cast-Iron-Pan.jpg/1024px-Cast-Iron-Pan.jpg',
    ),
  ];
  // here we are using getter so that our item file which is private its copy cn be accessed by somewhere else

  List<Product> get items {
    // if (_showFavoritesOnly) {
    //   return _items.where((prodItem) => prodItem.isFavorite).toList();
    // }
    return [..._items];
  }

  List<Product> get favoriteItems {
    return _items.where((prodItem) => prodItem.isFavorite).toList();
  }

// to return products with specific id we define it here so that our code looks clean
  Product findById(String id) {
    return _items.firstWhere((prod) => prod.id == id);
  }

  // void showFavoritesOnly() {
  //   _showFavoritesOnly = true;
  //   notifyListeners();
  // }

  // void showAll() {
  //   _showFavoritesOnly = false;
  //   notifyListeners();
  // }
  // we are adding data by this specific member func because we need to notify all the listners about the change
 Future<void> addProduct(Product product) {
    const url =
        'https://shop-app-e47df-default-rtdb.asia-southeast1.firebasedatabase.app/products.json';
   return http
        .post(Uri.parse(url),
            body: json.encode({
              'title': product.title,
              'price': product.price,
              'description': product.description,
              'isFavorite': product.isFavorite,
            })) //then will execute when sending request is completed and we cad show changes to ui and local storage
        .then((value) {
      final newProduct = Product(
          // value is the response sent by fire base it is unique we can use it as id
          id: jsonDecode(value.body)['name'],
          title: product.title,
          description: product.description,
          price: product.price,
          imageUrl: product.imageUrl);
      _items.add(newProduct);
      // if we want to add it a specific position
      // _items.insert(intdex,newproduct);
      notifyListeners();
    
    });
    
  }

  void editProduct(Product product) {
    late Product editedProduct;
    for (int i = 0; i < _items.length; i++) {
      if (_items[i].id == product.id) {
        editedProduct = _items[i];
      }
    }
    editedProduct.title = product.title;
    editedProduct.description = product.description;
    editedProduct.imageUrl = product.imageUrl;
    notifyListeners();
  }

  void deleteProduct(String id) {
    _items.removeWhere((prod) => prod.id == id);
    notifyListeners();
  }
}

// var _showFavoritesOnly = false;
