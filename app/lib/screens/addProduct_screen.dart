import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_it/providers/product_provider.dart';
import 'package:shop_it/screens/home_screen.dart';

class AddProducts extends StatefulWidget {
  const AddProducts({super.key});

  @override
  State<AddProducts> createState() => _AddProductsState();
}

class _AddProductsState extends State<AddProducts> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descContorller = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController catgController = TextEditingController();
  final TextEditingController imgController = TextEditingController();

  bool _isSubmitting = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfff6f6f6),
      appBar: appBar(),
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            margin: EdgeInsets.symmetric(vertical: 32.0),
            child: Column(
              children: [
                buildTextField('Enter Product Title', titleController, false),
                sizedBox(),
                buildTextField(
                  'Enter Product Description',
                  descContorller,
                  false,
                ),
                sizedBox(),
                buildTextField('Enter Product Price', priceController, true),
                sizedBox(),
                buildTextField('Enter Product Category', catgController, false),
                sizedBox(),
                buildTextField('Enter Product Image URL', imgController, false),
                sizedBox(),
                _isSubmitting
                    ? CircularProgressIndicator()
                    : MaterialButton(
                      onPressed: () async {
                        setState(() {
                          _isSubmitting = true;
                        });

                        final data = {
                          'title': titleController.text,
                          'price': double.tryParse(priceController.text) ?? 0.0,
                          'description': descContorller.text,
                          'category': catgController.text,
                          'image': imgController.text,
                        };

                        try {
                          await Provider.of<ProductProvider>(
                            context,
                            listen: false,
                          ).addProducts(data: data);
                          // await ProductProvider().addProducts(data: data);
                          if (context.mounted) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('Product Added Successfully ✅'),
                              ),
                            );

                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (_) => HomeScreen()),
                            );
                          }
                        } catch (e) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Failed to add product')),
                          );
                        }

                        if (mounted) {
                          setState(() {
                            _isSubmitting = false;
                          });
                        }
                      },
                      color: Color.fromARGB(255, 114, 150, 47),
                      textColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      padding: EdgeInsets.symmetric(
                        vertical: 10.0,
                        horizontal: 14.0,
                      ),
                      child: Text(
                        'Add Product',
                        style: TextStyle(fontSize: 16.0),
                      ),
                    ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildTextField(String label, TextEditingController controller, isNum) {
    return SizedBox(
      width: 310,
      child: TextField(
        keyboardType:
            isNum
                ? TextInputType.numberWithOptions(decimal: true)
                : TextInputType.text,
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(),
        ),
      ),
    );
  }

  SizedBox sizedBox() => SizedBox(width: 35, height: 35);

  AppBar appBar() {
    return AppBar(
      backgroundColor: Color(0xfff6f6f6),
      title: Text(
        'Add Products',
        style: TextStyle(
          fontSize: 21,
          fontWeight: FontWeight.w500,
          color: Color(0xff101010),
        ),
      ),
    );
  }
}
