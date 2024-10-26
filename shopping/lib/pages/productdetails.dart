import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shopping/model/model.dart';
import 'package:shopping/repository/firestore.dart';

class ProductDetailsPage extends StatelessWidget {
  final Product product;

  ProductDetailsPage({super.key, required this.product});
  final ProductService productService =
      ProductService(); // Initialize ProductService

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(product.productName)),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Left side: Product image
                        Expanded(
                          flex: 1,
                          child: CachedNetworkImage(
                            imageUrl: product.imageUrl,
                            placeholder: (context, url) => const Center(
                              child: CircularProgressIndicator(),
                            ),
                            errorWidget: (context, url, error) => const Center(
                              child: Icon(Icons.error),
                            ),
                            height: 200,
                            fit: BoxFit.cover,
                          ),
                        ),
                        const SizedBox(width: 16.0),
                        // Right side: Product details
                        Expanded(
                          flex: 2,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                product.productName,
                                style: const TextStyle(
                                    fontSize: 24, fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                '\$${product.price} ',
                                style: const TextStyle(
                                    fontSize: 20, color: Colors.green),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                'Discount: ${product.off}',
                                style: const TextStyle(
                                    fontSize: 16, color: Colors.redAccent),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                'Rating: ${product.rating}',
                                style: const TextStyle(fontSize: 16),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                ' \$${product.vanishRate.toStringAsFixed(2)}',
                                style: const TextStyle(
                                  fontSize: 16,
                                  decoration: TextDecoration.lineThrough,
                                  color: Colors.grey,
                                ),
                              ),
                              const SizedBox(height: 16),
                              Text(
                                'Description: ${product.description}',
                                textAlign: TextAlign.justify,
                              ),
                              const SizedBox(height: 16),
                              Text(
                                'Remarks: ${product.remarks}',
                                textAlign: TextAlign.justify,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () async {
                    try {
                      await productService.addCart(product);
                      if (context.mounted) {
                        Navigator.pop(context);
                      }
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          backgroundColor: Colors.green,
                          content: Text('Added to Cart ${product.productName}'),
                        ),
                      );
                    } catch (e) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          backgroundColor: Colors.red,
                          content: Text('Error: Could not complete Add Cart'),
                        ),
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 24, vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    elevation: 5,
                  ),
                  child: const Text(
                    'Add to Cart',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
                // "Buy Now" Button
                ElevatedButton(
                  onPressed: () async {
                    try {
                      await productService.addOrders(product);
                      // After adding to orders, pop the current screen
                      if (context.mounted) {
                        Navigator.pop(context); // Return to the previous screen
                      }
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          backgroundColor: Colors.green,
                          content: Text('Buying ${product.productName}'),
                        ),
                      );
                    } catch (e) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          backgroundColor: Colors.red,
                          content: Text('Error: Could not complete purchase'),
                        ),
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 24, vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    elevation: 5,
                  ),
                  child: const Text(
                    'Buy Now',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
