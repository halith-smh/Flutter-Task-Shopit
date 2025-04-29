// Correct version using Product model

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_it/providers/product_provider.dart';
import 'package:shop_it/screens/editProduct_screen.dart';
import 'package:shop_it/screens/home_screen.dart';
import '../models/product.dart'; // Make sure this import is correct

class ViewproductScrren extends StatefulWidget {
  final Product product;

  const ViewproductScrren({super.key, required this.product});

  @override
  State<ViewproductScrren> createState() => _ViewproductScrrenState();
}

class _ViewproductScrrenState extends State<ViewproductScrren> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: appBar(),
      body: body(context),
      // floatingActionButton: M
    );
  }

  Padding body(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(widget.product.title, style: TextStyle(fontSize: 18)),
          SizedBox(height: 8),
          // Product Image
          Center(
            child: SizedBox(
              width: 150,
              height: 150,
              child: Image.network(widget.product.image, fit: BoxFit.contain),
            ),
          ),
          SizedBox(height: 12),
          Text("Category: ${widget.product.category}"),
          SizedBox(height: 8),
          Text("Price: ₹${widget.product.price.toStringAsFixed(2)}"),
          SizedBox(height: 8),
          Text("Rating: ${widget.product.ratings} ⭐"),
          SizedBox(height: 8),
          Text("Description: ${widget.product.description}"),
          SizedBox(height: 25),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              MaterialButton(
                onPressed: () async {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder:
                          (context) =>
                              EditproductScreen(productInfo: widget.product),
                    ),
                  );
                },
                color: Color.fromARGB(255, 114, 150, 47),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 12.0),
                textColor: Colors.white,
                child: Text('Edit', style: TextStyle(fontSize: 16.0)),
              ),
              SizedBox(width: 28),
              MaterialButton(
                onPressed: () async {
                  try {
                    await Provider.of<ProductProvider>(
                      context,
                      listen: false,
                    ).deleteProducts(productId: widget.product.id);
                    if (context.mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Product deleted Successfully ✅'),
                        ),
                      );
                    }
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => HomeScreen()),
                    );
                  } catch (e) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Failed to add product')),
                    );
                    print(e);
                  }
                },
                color: Color.fromARGB(255, 198, 25, 25),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 12.0),
                textColor: Colors.white,
                child: Text('Delete', style: TextStyle(fontSize: 16.0)),
              ),
            ],
          ),
        ],
      ),
    );
  }

  AppBar appBar() {
    return AppBar(
      backgroundColor: Color(0xfff6f6f6),
      title: Text(
        'View Product',
        style: TextStyle(
          fontSize: 21,
          fontWeight: FontWeight.w500,
          color: Color(0xff101010),
        ),
      ),
    );
  }
}
