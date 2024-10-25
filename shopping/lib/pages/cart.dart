import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shopping/repository/firestore.dart';
import '../model/model.dart';
import 'productdetails.dart'; // Your product model

class CartScreen extends StatefulWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  final ProductService _productService = ProductService();
  List<Product> _cartProducts = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchCartItems();
  }

  // Fetch cart items from Firestore
  Future<void> _fetchCartItems() async {
    setState(() {
      _isLoading = true;
    });
    List<Product> cartItems = await _productService.fetchCart();
    setState(() {
      _cartProducts = cartItems;
      _isLoading = false;
    });
  }

  // Remove a product from the cart
  Future<void> _removeFromCart(Product product) async {
    await _productService.removeCart(product);
    // Fetch the updated cart list after removal
    _fetchCartItems();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Cart'),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _cartProducts.isEmpty
              ? const Center(child: Text('No items in the cart.'))
              : ListView.builder(
                  itemCount: _cartProducts.length,
                  itemBuilder: (context, index) {
                    final product = _cartProducts[index];

                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                ProductDetailsPage(product: product),
                          ),
                        );
                      },
                      child: ListTile(
                        leading: SizedBox(
                          width: 100,
                          height: 100,
                          child: CachedNetworkImage(
                            fit: BoxFit.cover,
                            imageUrl: product.imageUrl ?? '',
                            placeholder: (context, url) => Center(
                                child: const CircularProgressIndicator()),
                            errorWidget: (context, url, error) =>
                                const Icon(Icons.error),
                            // height: 50,
                          ),
                        ),
                        title: Text(product.productName),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                                "Price: \$${product.price.toStringAsFixed(2)}"),
                            Text(
                              " \$ ${product.vanishRate}",
                              style: TextStyle(
                                decoration: TextDecoration.lineThrough,
                              ),
                            ),
                            Text("Rating: ${product.rating} stars"),
                          ],
                        ),
                        trailing: IconButton(
                          icon: const Icon(Icons.remove_shopping_cart),
                          onPressed: () {
                            _removeFromCart(product);
                          },
                        ),
                      ),
                    );
                  },
                ),
    );
  }
}
