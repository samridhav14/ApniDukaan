import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/product.dart';
import '../providers/products_provider.dart';

class EditProductScreen extends StatefulWidget {
  static const routeName = '/edit-product';

  @override
  _EditProductScreenState createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {
  final _priceFocusNode = FocusNode();
  final _descriptionFocusNode = FocusNode();
  // this focus node can be assigned to any text feild to navigate to other tect feild

  final _imageUrlController =
      TextEditingController(); // this controller help us to create a prview of image
  final _imageUrlFocusNode = FocusNode();
  // global key
  final _form = GlobalKey<FormState>();
  // here i have removed key because we dont have a system as of now to give id as of now
  var _editedProduct = Product(
    id: null,
    title: '',
    price: 0,
    description: '',
    imageUrl: '',
  );

  var _initValues = {
    'title': '',
    'description': '',
    'price': '',
    'imageUrl': '',
  };
  var _isInit = true;
  var _isLoading = false;
  @override
  // to update ui as we loose focus from it
  void initState() {
    _imageUrlFocusNode.addListener(_updateImageUrl);
    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (_isInit) {
      var tempproductId = ModalRoute.of(context)!.settings.arguments;
      if (tempproductId != null) {
        final productId = tempproductId.toString();
        print(productId);
        _editedProduct =
            Provider.of<Products>(context, listen: false).findById(productId);
        _initValues = {
          'title': _editedProduct.title,
          'description': _editedProduct.description,
          'price': _editedProduct.price.toString(),
          // 'imageUrl': _editedProduct.imageUrl,
          'imageUrl': '',
        };
        _imageUrlController.text = _editedProduct.imageUrl;
      }
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  @override
  // we need to dispose fous node
  void dispose() {
    super.dispose();
    _imageUrlFocusNode.removeListener(_updateImageUrl);
    _priceFocusNode.dispose();
    _descriptionFocusNode.dispose();
    _imageUrlController.dispose();
    _imageUrlFocusNode.dispose();
  }

  // if we loose focus and link is there we will update
  void _updateImageUrl() {
    if (!_imageUrlFocusNode.hasFocus) {
      if ((!_imageUrlController.text.startsWith('http') &&
              !_imageUrlController.text.startsWith('https')) ||
          (!_imageUrlController.text.endsWith('.png') &&
              !_imageUrlController.text.endsWith('.jpeg') &&
              !_imageUrlController.text.endsWith('jpg'))) {
        return;
      }
      setState(() {});
    }
  }

  // _saveForm() {
  //   final isValid = _form.currentState!.validate();
  //   // this means form is not valid
  //   if (!isValid) {
  //     return;
  //   }
  //   _form.currentState!.save();
  //   // print(_editedProduct.title);
  //   // print(_editedProduct.description);
  //   // print(_editedProduct.price);
  //   // print(_editedProduct.imageUrl);
  //   // to add product in the item list
  //   setState(() {
  //     _isLoading = true;
  //   });
  //   if (_editedProduct.id != null) {
  //     Provider.of<Products>(context, listen: false).editProduct(_editedProduct);
  //     Navigator.of(context).pop();
  //   }
  //   //we are returning a future so that we can show show loading until it gets uploaded
  //   else {
  //     Provider.of<Products>(context, listen: false)
  //         .addProduct(_editedProduct)
  //         .catchError((onError) {
  //      return showDialog(
  //           context: context,
  //           builder: (ctx) =>  AlertDialog(
  //                 title:const Text('An error occurred'),
  //                 content: const Text('Something Went Wrong'),
  //                 actions: <Widget>[
  //                   TextButton(child: const Text('Okay'),onPressed: (){
  //                     Navigator.of(context).pop();
  //                   },)
  //                 ],
  //               ));
  //     }).then((_) {
  //       setState(() {
  //         _isLoading = false;
  //       });
  //       Navigator.of(context).pop();
  //     });
  //   }

  Future<void> _saveForm() async {
    final isValid = _form.currentState!.validate();
    if (!isValid) {
      return;
    }
    _form.currentState!.save();
    setState(() {
      _isLoading = true;
    });
    if (_editedProduct.id != null) {
    await  Provider.of<Products>(context, listen: false).editProduct(_editedProduct.id!,_editedProduct);
    
    } else {
      try {
        await Provider.of<Products>(context, listen: false)
            .addProduct(_editedProduct);
      } catch (error) {
        await showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
            title: const Text('An error occurred!'),
            content: const Text('Something went wrong.'),
            actions: <Widget>[
              TextButton(
                child: const Text('Okay'),
                onPressed: () {
                  Navigator.of(ctx).pop();
                },
              )
            ],
          ),
        );
       } 
       //finally {
      //   setState(() {
      //     _isLoading = false;
      //   });
      //   Navigator.of(context).pop();
      // }
    }
      setState(() {
        _isLoading = false;
      });
      Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Product'),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.save),
            onPressed: () {
              _saveForm();
            },
          ),
        ],
      ),
      body: _isLoading == true
          ? const Center(
              child:  CircularProgressIndicator(),
            )
          : Padding(
              padding: const EdgeInsets.all(15),
              child: Form(
                  key: _form,
                  child: ListView(
                    children: <Widget>[
                      TextFormField(
                        decoration: const InputDecoration(
                          labelText: 'Title',
                        ),
                        textInputAction: TextInputAction.next,
                        initialValue: _initValues['title'],
                        // this will help us to navigate to next or focused input feild
                        onFieldSubmitted: (_) {
                          FocusScope.of(context).requestFocus(_priceFocusNode);
                        },
                        onSaved: (newValue) {
                          _editedProduct = Product(
                            title: newValue!,
                            price: _editedProduct.price,
                            id: _editedProduct.id,
                            description: _editedProduct.description,
                            imageUrl: _editedProduct.imageUrl,
                            isFavorite: false,
                          );
                        },
                        // we will return a  text if input is wrong if everything is fine return null
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Please provide a value";
                          }
                          return null;
                        },
                      ),
                      TextFormField(
                        decoration: const InputDecoration(
                          labelText: 'Price',
                        ),
                        keyboardType: TextInputType.number,
                        textInputAction: TextInputAction.next,
                        focusNode: _priceFocusNode,
                        onFieldSubmitted: (_) {
                          FocusScope.of(context)
                              .requestFocus(_descriptionFocusNode);
                        },
                        initialValue: _initValues['price'],
                        onSaved: (newValue) {
                          _editedProduct = Product(
                            title: _editedProduct.title,
                            price: double.parse(newValue!),
                            id: _editedProduct.id,
                            description: _editedProduct.description,
                            imageUrl: _editedProduct.imageUrl,
                            isFavorite: false,
                          );
                        },
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Please provide a value";
                          }
                          if (double.tryParse(value) == null) {
                            return "Please provide a valid price";
                          }
                          if (double.parse(value) <= 0) {
                            return "Please provide a valid price greater then 0";
                          }
                          return null;
                        },
                      ),
                      TextFormField(
                        decoration:const InputDecoration(
                          labelText: 'Description',
                        ),
                        maxLines: 3,
                        keyboardType: TextInputType.multiline,
                        textInputAction: TextInputAction.next,
                        focusNode: _descriptionFocusNode,
                        onSaved: (newValue) {
                          _editedProduct = Product(
                            title: _editedProduct.title,
                            price: _editedProduct.price,
                            id: _editedProduct.id,
                            description: newValue!,
                            imageUrl: _editedProduct.imageUrl,
                            isFavorite: false,
                          );
                        },
                        initialValue: _initValues['description'],
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Please provide a description";
                          }
                          if (value.length < 10) {
                            return "Please provide a longer description";
                          }

                          return null;
                        },
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        // we are making this to show a preview of image also so that user can change it
                        children: [
                          Container(
                              width: 100,
                              height: 100,
                              margin: const EdgeInsetsDirectional.only(
                                top: 8,
                                start: 10,
                              ),
                              decoration: BoxDecoration(
                                border:
                                    Border.all(width: 1, color: Colors.grey),
                              ),
                              child: _imageUrlController.text.isEmpty
                                  ? const Text('Enter a Url')
                                  : FittedBox(
                                      child: Image.network(
                                          _imageUrlController.text),
                                      fit: BoxFit.cover,
                                    )),
                          // here we need to use expanded so that text feild dont try to take infinite width
                          Expanded(
                            child: TextFormField(
                              decoration: const InputDecoration(
                                labelText: 'ImageUrl',
                              ),
                              keyboardType: TextInputType.url,
                              textInputAction: TextInputAction.done,
                              controller: _imageUrlController,
                              focusNode: _imageUrlFocusNode,
                              // we cant directly give save form becasuse we need to use the string we get on submit
                              onFieldSubmitted: (_) {
                                _saveForm();
                              },
                              initialValue: _initValues['imageurl'],

                              onSaved: (newValue) {
                                _editedProduct = Product(
                                  title: _editedProduct.title,
                                  price: _editedProduct.price,
                                  id: _editedProduct.id,
                                  description: _editedProduct.description,
                                  imageUrl: newValue!,
                                  isFavorite: false,
                                );
                              },
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "Please provide an image url";
                                }
                                if (!value.startsWith('http') &&
                                    !value.startsWith('https')) {
                                  return "Please provide a valid url";
                                }
                                if (!value.endsWith('.png') &&
                                    !value.endsWith('.jpeg') &&
                                    !value.endsWith('jpg')) {
                                  return "Please provide a valid url";
                                }
                                return null;
                              },
                            ),
                          )
                        ],
                      )
                    ],
                  )),
            ),
    );
  }
}
