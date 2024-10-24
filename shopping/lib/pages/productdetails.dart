import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shopping/model/model.dart';

class ProductDetailsPage extends StatelessWidget {
  final Product product;

  const ProductDetailsPage({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(product.productName)),
      body: SingleChildScrollView(
        // Make the body scrollable
        child: Column(
          crossAxisAlignment:
              CrossAxisAlignment.center, // Aligns the column to the start
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CachedNetworkImage(
              imageUrl: product.imageUrl ?? '',
              placeholder: (context, url) =>
                  Center(child: CircularProgressIndicator()),
              errorWidget: (context, url, error) =>
                  Center(child: Icon(Icons.error)),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0), // Adds padding around text
              child: Text(product.productName, style: TextStyle(fontSize: 24)),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child:
                  Text('${product.price} USD', style: TextStyle(fontSize: 20)),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(product.description),
            ),
            // Add more product details here
          ],
        ),
      ),
    );
  }
}
