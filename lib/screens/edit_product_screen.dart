import 'package:flutter/material.dart';

class EditProductScreen extends StatefulWidget {
  const EditProductScreen({super.key});
  static const routeName='/edit-product';
  @override
  State<EditProductScreen> createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {
  final _priceFocusNode=FocusNode();
  final _descriptionFocusNode=FocusNode();
  // this focus node can be assigned to any text feild to navigate to other tect feild 


@override
  // we need to dispose fous node
  void dispose(){
    _priceFocusNode.dispose();
    _descriptionFocusNode.dispose();
  }
  
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Product'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Form(
          child:ListView(
            children: <Widget>[
              TextFormField(
                 decoration: InputDecoration(
                  labelText:'Title', 
                 ),
                 textInputAction: TextInputAction.next,
                 // this will help us to navigate to next or focused input feild
                onFieldSubmitted: (_) {
                  FocusScope.of(context).requestFocus(_priceFocusNode);
                },
              ),
              TextFormField(
                 decoration: InputDecoration(
                  labelText:'Price', 
                 ),
                 keyboardType: TextInputType.number,
                 textInputAction: TextInputAction.next,
                  focusNode: _priceFocusNode,
                    onFieldSubmitted: (_) {
                  FocusScope.of(context).requestFocus(_descriptionFocusNode);
                },
              ),
              TextFormField(
                 decoration: InputDecoration(
                  labelText:'Description', 
                 ),
                 maxLines: 3,
                 keyboardType: TextInputType.multiline,
                 textInputAction: TextInputAction.next,
                 focusNode: _descriptionFocusNode,
              ),
            ],
          )
            
        ),
      ),
    );
  }
}