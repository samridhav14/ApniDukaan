import 'package:flutter/material.dart';
import 'dart:convert';
import 'product.dart';
import 'package:http/http.dart' as http;

class Products with ChangeNotifier {
  List<Product> _items = [
    // Product(
    //   id: 'p1',
    //   title: 'Red Shirt',
    //   description: 'A red shirt - it is pretty red!',
    //   price: 29.99,
    //   imageUrl:
    //       'https://cdn.pixabay.com/photo/2016/10/02/22/17/red-t-shirt-1710578_1280.jpg',
    // ),
    // Product(
    //   id: 'p2',
    //   title: 'Trousers',
    //   description: 'A nice pair of trousers.',
    //   price: 59.99,
    //   imageUrl:
    //       'https://upload.wikimedia.org/wikipedia/commons/thumb/e/e8/Trousers%2C_dress_%28AM_1960.022-8%29.jpg/512px-Trousers%2C_dress_%28AM_1960.022-8%29.jpg',
    // ),
    // Product(
    //   id: 'p3',
    //   title: 'Yellow Scarf',
    //   description: 'Warm and cozy - exactly what you need for the winter.',
    //   price: 19.99,
    //   imageUrl:
    //       'https://live.staticflickr.com/4043/4438260868_cc79b3369d_z.jpg',
    // ),
    // Product(
    //   id: 'p4',
    //   title: 'A Pan',
    //   description: 'Prepare any meal you want.',
    //   price: 49.99,
    //   imageUrl:
    //       'https://upload.wikimedia.org/wikipedia/commons/thumb/1/14/Cast-Iron-Pan.jpg/1024px-Cast-Iron-Pan.jpg',
    // ),
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
 Future<void> addProduct(Product product) async {
    const url =
        'https://shop-app-e47df-default-rtdb.asia-southeast1.firebasedatabase.app/products.json';
         try {
      final response = await http.post(
        Uri.parse(url),
        body: json.encode({
          'title': product.title,
          'description': product.description,
          'imageUrl': product.imageUrl,
          'price': product.price,
          'isFavorite': product.isFavorite,
        }),
      );
      final newProduct = Product(
        title: product.title,
        description: product.description,
        price: product.price,
        imageUrl: product.imageUrl,
        id: json.decode(response.body)['name'],
      );
      _items.add(newProduct);
      // _items.insert(0, newProduct); // at the start of the list
      notifyListeners();
    } catch (error) {
      print(error);
      throw error;
    }
    // http
    //     .post(Uri.parse(url),
    //         body: json.encode({
    //           'title': product.title,
    //           'price': product.price,
    //           'description': product.description,
    //           'isFavorite': product.isFavorite,
    //         })) //then will execute when sending request is completed and we cad show changes to ui and local storage
    //     .then((value) {
    //   final newProduct = Product(
    //       // value is the response sent by fire base it is unique we can use it as id
    //       id: jsonDecode(value.body)['name'],
    //       title: product.title,
    //       description: product.description,
    //       price: product.price,
    //       imageUrl: product.imageUrl);
    //   _items.add(newProduct);
    //   // if we want to add it a specific position
    //   // _items.insert(intdex,newproduct);
    //   notifyListeners();
    
    // }).catchError((onError){
    //       print(onError); 
    //      throw onError;
    // });
    
  }
Future<void> fetchAndSetProducts() async{
    const url =
        'https://shop-app-e47df-default-rtdb.asia-southeast1.firebasedatabase.app/products.json';
        try{
       final response = await http.get(Uri.parse(url));
     final extractedData=json.decode(response.body) as Map<String,dynamic>;
       final List<Product> loadedProducts = [];
      extractedData.forEach((prodId, prodData) { 
          loadedProducts.add(Product(
          id: prodId,
          title: prodData['title'],
          description: prodData['description'],
          price: prodData['price'],
          isFavorite: prodData['isFavorite'],
          imageUrl: prodData['imageUrl'],
        ));
      });
      _items = loadedProducts;
      print(_items.length);
      notifyListeners();
        }
        catch(error){
            throw (error);
        }
}

 Future<void> editProduct(String id, Product newProduct) async {
     final prodIndex = _items.indexWhere((prod) => prod.id == id);
    if (prodIndex >= 0) {
      final url = 'https://flutter-update.firebaseio.com/products/$id.json';
      await http.patch(Uri.parse(url),
          body: json.encode({
            'title': newProduct.title,
            'description': newProduct.description,
            'imageUrl': newProduct.imageUrl,
            'price': newProduct.price
          }));
      _items[prodIndex] = newProduct;
      notifyListeners();
    } else {
      print('...');
    }
  }

  void deleteProduct(String id) {
          final url = 'https://flutter-update.firebaseio.com/products/$id.json';
      final existingProductIndex= _items.indexWhere((element) => element.id==id);
      Product? existingProduct=_items[existingProductIndex];
    _items.removeAt(existingProductIndex);
    // if we fail add back;
    http.delete(Uri.parse(url)).then((value){
      if(value.statusCode>=400){
        //
      }
      existingProduct=null;
    }).catchError((_){
      _items.insert(existingProductIndex, existingProduct!);
    });
    notifyListeners();
  }
}

// var _showFavoritesOnly = false;
