import 'package:flutter/material.dart';

class ProductDetailsPage extends StatelessWidget {
  final String productName;

  const ProductDetailsPage({super.key, required this.productName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context, true);
            },
            icon: const Icon(Icons.keyboard_arrow_left_rounded)),
        title: Text(productName),
      ),
      body: Center(
        child: Text('Details of $productName'),
      ),
    );
  }
}
