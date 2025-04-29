import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_it/screens/addProduct_screen.dart';
import 'package:shop_it/screens/viewProduct_scrren.dart';
import '../providers/product_provider.dart';
import '../models/product.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    // Fetch products when the screen loads
    Future.delayed(Duration.zero, () {
      Provider.of<ProductProvider>(context, listen: false).fetchProducts();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff6f6f6),
      appBar: appBar(),
      body: Consumer<ProductProvider>(
        builder: (ctx, productProvider, _) {
          if (productProvider.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          // for any errors
          if (productProvider.error.isNotEmpty) {
            return Center(child: Text(productProvider.error));
          }

          if (productProvider.products.isEmpty) {
            return const Center(child: Text('No products found'));
          }

          // ListView for products
          return Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'All Products',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                Expanded(
                  child: ListView.builder(
                    itemCount: productProvider.products.length,
                    itemBuilder: (ctx, index) {
                      final product = productProvider.products[index];
                      return ProductItem(product: product);
                    },
                  ),
                ),
              ],
            ),
          );
        },
      ),
      floatingActionButton: FloatingButton(context),
    );
  }

  MaterialButton FloatingButton(BuildContext context) {
    return MaterialButton(
      onPressed: () async {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => AddProducts()),
        );
      },
      color: Color.fromARGB(255, 114, 150, 47),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 12.0),
      textColor: Colors.white,
      child: Text('+ Add Product', style: TextStyle(fontSize: 16.0)),
    );
  }

  AppBar appBar() {
    return AppBar(
      automaticallyImplyLeading: false, //hiding back nav in Home Screen
      backgroundColor: const Color(0xfff6f6f6),
      title: Row(
        children: [
          Text(
            'Shop',
            style: TextStyle(
              fontSize: 21,
              fontWeight: FontWeight.w600,
              color: Color(0xff101010),
            ),
          ),
          Text(
            'it',
            style: TextStyle(
              fontSize: 21,
              fontWeight: FontWeight.w600,
              color: Color.fromARGB(255, 148, 194, 62),
            ),
          ),
        ],
      ),
    );
  }
}

// A simple product list item
class ProductItem extends StatefulWidget {
  final Product product;

  const ProductItem({super.key, required this.product});

  @override
  State<ProductItem> createState() => _ProductItemState();
}

class _ProductItemState extends State<ProductItem> {
  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      margin: EdgeInsets.symmetric(vertical: 8),
      child: MaterialButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ViewproductScrren(product: widget.product),
            ),
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Product Image
              SizedBox(
                width: 80,
                height: 80,
                child: Image.network(widget.product.image, fit: BoxFit.contain),
              ),
              const SizedBox(width: 12),
              // Product Details
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.product.title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      widget.product.category,
                      style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                    ),
                    SizedBox(height: 4),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '₹${widget.product.price.toStringAsFixed(2)}',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 148, 194, 62),
                          ),
                        ),
                        Row(
                          children: [
                            Icon(Icons.star, color: Colors.amber, size: 14),
                            SizedBox(width: 2),
                            Text(
                              '${widget.product.ratings}',
                              style: TextStyle(fontSize: 12),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
