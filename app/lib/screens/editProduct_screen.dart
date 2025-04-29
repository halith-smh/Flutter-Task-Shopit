import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_it/models/product.dart';
import 'package:shop_it/providers/product_provider.dart';
import 'package:shop_it/screens/home_screen.dart';

class EditproductScreen extends StatefulWidget {
  final Product productInfo;
  const EditproductScreen({super.key, required this.productInfo});

  @override
  State<EditproductScreen> createState() => _EditproductScreenState();
}

class _EditproductScreenState extends State<EditproductScreen> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descContorller = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController catgController = TextEditingController();
  final TextEditingController imgController = TextEditingController();
  final TextEditingController ratingsController = TextEditingController();

  @override
  void initState() {
    super.initState();
    titleController.text = widget.productInfo.title ?? '';
    descContorller.text = widget.productInfo.description ?? '';
    priceController.text = widget.productInfo.price?.toString() ?? '';
    catgController.text = widget.productInfo.category ?? '';
    imgController.text = widget.productInfo.image ?? '';
    ratingsController.text = widget.productInfo.ratings?.toString() ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: appBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              SizedBox(height: 25.0),
              SizedBox(
                child: TextFormField(
                  controller: titleController,
                  decoration: InputDecoration(
                    labelText: 'Product Title',
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              SizedBox(height: 25.0),
              TextFormField(
                controller: priceController,
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                decoration: InputDecoration(
                  labelText: 'Product Price',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 25.0),
              TextFormField(
                controller: descContorller,
                decoration: InputDecoration(
                  labelText: 'Product Description',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 25.0),
              TextFormField(
                controller: catgController,
                decoration: InputDecoration(
                  labelText: 'Product Category',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 25.0),
              TextFormField(
                controller: ratingsController,
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                decoration: InputDecoration(
                  labelText: 'Ratings',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 25.0),
              TextFormField(
                controller: imgController,
                decoration: InputDecoration(
                  labelText: 'Prodcut Img URL',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 35.0),
              ElevatedButton(
                onPressed: () async {
                  final data = {
                    'title': titleController.text,
                    'price': double.tryParse(priceController.text) ?? 0.0,
                    'description': descContorller.text,
                    'category': catgController.text,
                    'image': imgController.text,
                    'ratings': double.parse(ratingsController.text),
                  };

                  try {
                    await Provider.of<ProductProvider>(
                      context,
                      listen: false,
                    ).editProducts(
                      data: data,
                      productId: widget.productInfo.id,
                    );
                    if (context.mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Product Updated Successfully ✅'),
                        ),
                      );
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => HomeScreen()),
                      );
                    }
                  } catch (e) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Failed to add product')),
                    );
                  }

                  // print(data);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color.fromARGB(255, 114, 150, 47),
                  foregroundColor: Colors.white,
                ),
                child: Text('Save Changes'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Container body() => Container(child: Text('${widget.product_info.title}'));

  // Container body() => Container(child: Text(),);
  AppBar appBar() {
    return AppBar(
      backgroundColor: Color(0xfff6f6f6),
      title: Text(
        'Edit Product',
        style: TextStyle(
          fontSize: 21,
          fontWeight: FontWeight.w500,
          color: Color(0xff101010),
        ),
      ),
    );
  }
}
