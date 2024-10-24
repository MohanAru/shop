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
      body: Column(
        children: [
          CachedNetworkImage(
            imageUrl: product.imageUrl ?? '',
            placeholder: (context, url) => CircularProgressIndicator(),
            errorWidget: (context, url, error) => Icon(Icons.error),
          ),
          Text(product.productName, style: TextStyle(fontSize: 24)),
          Text('${product.price} USD'),
          Text(product.description),
          // Add more product details here
        ],
      ),
    );
  }
}
