import 'package:flutter/material.dart';
import '../widgets/product_grid.dart';
import '../providers/products_provider.dart';

enum FilterOptions {
  Favorites,
  All,
}
class ProductOverviewScreen extends StatefulWidget {
  @override
  State<ProductOverviewScreen> createState() => _ProductOverviewScreenState();
}

class _ProductOverviewScreenState extends State<ProductOverviewScreen> {
   var _showOnlyFavorites = false;
  @override
  Widget build(BuildContext context) {
    return 
    
    Scaffold(
      appBar: AppBar(title:const Text('ApniDukaan'),
       actions: <Widget>[
          PopupMenuButton(
            onSelected: (FilterOptions selectedValue) {
              setState(() {
                if (selectedValue == FilterOptions.Favorites) {
                  _showOnlyFavorites = true;
                } else {
                  _showOnlyFavorites = false;
                }
              });
            },
            icon: Icon(
              Icons.more_vert,
            ),
            itemBuilder: (_) => [
                  PopupMenuItem(
                    child: Text('Only Favorites'),
                    value: FilterOptions.Favorites,
                  ),
                  PopupMenuItem(
                    child: Text('Show All'),
                    value: FilterOptions.All,
                  ),
                ],
          ),
        ],
      ),
      body:ProductsGrid(_showOnlyFavorites),
    );
  }
}

