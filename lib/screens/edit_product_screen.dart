import 'package:flutter/material.dart';
import '../providers/product.dart';

class EditProductScreen extends StatefulWidget {
  const EditProductScreen({super.key});
  static const routeName = '/edit-product';
  @override
  State<EditProductScreen> createState() => _EditProductScreenState();
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
    id: '',
    title: '',
    price: 0,
    description: '',
    imageUrl: '',
  );
  @override
  // to update ui as we loose focus from it
  void initState() {
    _imageUrlFocusNode.addListener(_updateImageUrl);
    super.initState();
  }

  // if we loose focus and link is there we will update
  void _updateImageUrl() {
    if (!_imageUrlFocusNode.hasFocus) {
      setState(() {});
    }
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

  void _saveForm() {
    _form.currentState!.save();
    print(_editedProduct.title);
    print(_editedProduct.description);
    print(_editedProduct.price);
    print(_editedProduct.imageUrl);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Product'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.save),
            onPressed: _saveForm,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Form(
          
            key: _form,
            child: ListView(
              children: <Widget>[
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Title',
                  ),
                  textInputAction: TextInputAction.next,
                  // this will help us to navigate to next or focused input feild
                  onFieldSubmitted: (_) {
                    FocusScope.of(context).requestFocus(_priceFocusNode);
                  },
                  onSaved: (newValue) {
                    _editedProduct= Product(
                      title:newValue!,
                      price:_editedProduct.price ,
                      id: _editedProduct.id,
                      description: _editedProduct.description,
                      imageUrl: _editedProduct.imageUrl,
                      isFavorite:false, 
                    );
                  },
                  validator: ,
                ),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Price',
                  ),
                  keyboardType: TextInputType.number,
                  textInputAction: TextInputAction.next,
                  focusNode: _priceFocusNode,
                  onFieldSubmitted: (_) {
                    FocusScope.of(context).requestFocus(_descriptionFocusNode);
                  },
                    onSaved: (newValue) {
                    _editedProduct= Product(
                      title:_editedProduct.title,
                      price:double.parse(newValue!),
                      id: _editedProduct.id,
                      description: _editedProduct.description,
                      imageUrl: _editedProduct.imageUrl,
                      isFavorite:false, 
                    );
                    }
                ),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Description',
                  ),
                  maxLines: 3,
                  keyboardType: TextInputType.multiline,
                  textInputAction: TextInputAction.next,
                  focusNode: _descriptionFocusNode,
                     onSaved: (newValue) {
                    _editedProduct= Product(
                      title:_editedProduct.title,
                      price:_editedProduct.price,
                      id: _editedProduct.id,
                      description: newValue!,
                      imageUrl: _editedProduct.imageUrl,
                      isFavorite:false, 
                    );
                    }
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
                          border: Border.all(width: 1, color: Colors.grey),
                        ),
                        child: _imageUrlController.text.isEmpty
                            ? Text('Enter a Url')
                            : FittedBox(
                                child: Image.network(_imageUrlController.text),
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
                          _saveForm;
                        },
                             onSaved: (newValue) {
                    _editedProduct= Product(
                      title:_editedProduct.title,
                      price:_editedProduct.price,
                      id: _editedProduct.id,
                      description: _editedProduct.description,
                      imageUrl: newValue!,
                      isFavorite:false, 
                    );
                    }
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
