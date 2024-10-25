import 'package:cloud_firestore/cloud_firestore.dart';

import '../model/model.dart';

class ProductService {
  final CollectionReference productCollection =
      FirebaseFirestore.instance.collection('products');
  final CollectionReference ordercCollection =
      FirebaseFirestore.instance.collection("orders");

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

  // Add a order to Firestore
  Future<void> addOrders(Product product) async {
    print("adding firestoree");
    print("ordercCollection: ${product.toMap()}");
    try {
      await ordercCollection.add(product.toMap());
    } catch (e) {
      print('Error adding product: $e');
    }
  }

  // Retrieve all products from Firestore
  Future<List<Product>> fetchProducts() async {
    try {
      QuerySnapshot querySnapshot = await productCollection.get();
      print("querySnapshot : ${querySnapshot.docs[0].data()}");
      return querySnapshot.docs
          .map((doc) => Product.fromMap(doc.data() as Map<String, dynamic>))
          .toList();
    } catch (e) {
      print('Error fetching products: $e');
      return [];
    }
  }

  // Retrieve all ordercCollection from Firestore
  Future<List<Product>> fetchOrders() async {
    try {
      QuerySnapshot querySnapshot = await ordercCollection.get();
      print("querySnapshot : ${querySnapshot.docs[0].data()}");
      return querySnapshot.docs
          .map((doc) => Product.fromMap(doc.data() as Map<String, dynamic>))
          .toList();
    } catch (e) {
      print('Error fetching products: $e');
      return [];
    }
  }
}
