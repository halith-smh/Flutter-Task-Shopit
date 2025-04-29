import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_it/providers/product_provider.dart';
import 'package:shop_it/screens/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => ProductProvider())],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(fontFamily: 'Poppins'),
        title: 'Shop it',
        home: HomeScreen(),
      ),
    );
  }
}
