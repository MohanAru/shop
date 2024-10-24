// 1.Placeholder for ProfilePage
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import '../model/model.dart';
import '../repository/firestore.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final _formKey = GlobalKey<FormState>();

  // Controllers for input fields
  final TextEditingController _productNameController = TextEditingController();

  final TextEditingController _imageUrlController = TextEditingController();

  final TextEditingController _vanishRateController = TextEditingController();

  final TextEditingController _priceController = TextEditingController();

  final TextEditingController _offController = TextEditingController();

  final TextEditingController _descriptionController = TextEditingController();

  final TextEditingController _remarksController = TextEditingController();

  double _rating = 3.0;
  // Initial rating value
  @override
  void dispose() {
    // Dispose controllers when not needed
    _productNameController.dispose();
    _imageUrlController.dispose();
    _vanishRateController.dispose();
    _priceController.dispose();
    _offController.dispose();
    _descriptionController.dispose();
    _remarksController.dispose();
    super.dispose();
  }

  void _addProduct() async {
    if (_formKey.currentState!.validate()) {
      // Create the product instance from input fields
      final product = Product(
        productName: _productNameController.text,
        imageUrl: _imageUrlController.text,
        vanishRate: double.tryParse(_vanishRateController.text) ?? 0.0,
        price: double.tryParse(_priceController.text) ?? 0.0,
        off: _offController.text,
        rating: _rating, // Ensure _rating is of type double
        description: _descriptionController.text,
        remarks: _remarksController.text,
      );

      // Call addProduct method to save the product
      await ProductService().addProduct(product);

      // After saving, you can clear the form or navigate away
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Product added successfully!')),
      );
      _formKey.currentState!.reset(); // Reset the form
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Product'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              // Product Name
              TextFormField(
                controller: _productNameController,
                decoration: const InputDecoration(
                  labelText: 'Product Name',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(15.0)),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the product name';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // Image URL
              TextFormField(
                controller: _imageUrlController,
                decoration: const InputDecoration(
                  labelText: 'Image URL',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the image URL';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // Vanish Rate
              TextFormField(
                controller: _vanishRateController,
                decoration: const InputDecoration(
                  labelText: 'Vanish Rate',
                ),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the vanish rate';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // Price
              TextFormField(
                controller: _priceController,
                decoration: const InputDecoration(
                  labelText: 'Price',
                ),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the price';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // Discount
              TextFormField(
                controller: _offController,
                decoration: const InputDecoration(
                  labelText: 'Discount',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the discount';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // Rating
              const Text('Rating'),
              RatingBar.builder(
                initialRating: _rating,
                minRating: 1,
                direction: Axis.horizontal,
                allowHalfRating: true,
                itemCount: 5,
                itemBuilder: (context, _) => const Icon(
                  Icons.star,
                  color: Colors.amber,
                ),
                onRatingUpdate: (rating) {
                  setState(() {
                    _rating = rating;
                  });
                },
              ),
              const SizedBox(height: 16),

              // Description
              TextFormField(
                controller: _descriptionController,
                decoration: const InputDecoration(
                  labelText: 'Description',
                ),
                maxLines: 3,
              ),
              const SizedBox(height: 16),

              // Remarks
              TextFormField(
                controller: _remarksController,
                decoration: const InputDecoration(
                  labelText: 'Remarks',
                ),
                maxLines: 3,
              ),
              const SizedBox(height: 32),

              // Submit Button
              ElevatedButton(
                onPressed: _addProduct,
                child: const Text('Add Product'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
