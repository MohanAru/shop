import 'package:cloud_firestore/cloud_firestore.dart';

import '../model/model.dart';

class ProductService {
  final CollectionReference productCollection =
      FirebaseFirestore.instance.collection('products');

  // Add a product to Firestore
  Future<void> addProduct(Product product) async {
    print("adding firestoree");
    print("product.toMap() ${product.toMap()}");
    try {
      await productCollection.add(product.toMap());
      print("product.toMap() ${product.toMap()}");
    } catch (e) {
      print('Error adding product: $e');
    }
  }

  // Retrieve all products from Firestore
  Future<List<Product>> fetchProducts() async {
    try {
      QuerySnapshot querySnapshot = await productCollection.get();
      return querySnapshot.docs
          .map((doc) => Product.fromMap(doc.data() as Map<String, dynamic>))
          .toList();
    } catch (e) {
      print('Error fetching products: $e');
      return [];
    }
  }
}
