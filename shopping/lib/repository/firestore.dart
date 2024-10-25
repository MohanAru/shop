import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../model/model.dart';

class ProductService {
  final CollectionReference productCollection =
      FirebaseFirestore.instance.collection('products');
  final CollectionReference ordercCollection =
      FirebaseFirestore.instance.collection("orders");
  final CollectionReference cartCollection =
      FirebaseFirestore.instance.collection("cart");

  Future<void> addProduct(Product product) async {
    print("Adding product to Firestore");
    try {
      DocumentReference docRef = await productCollection.add(product.toMap());

      product.id = docRef.id;

      await productCollection.doc(docRef.id).update(product.toMap());

      print("Product added with ID: ${product.id}");
    } catch (e) {
      print('Error adding product: $e');
    }
  }

  Future<void> addOrders(Product product) async {
    print("Adding order to Firestore");
    try {
      DocumentReference docRef = await ordercCollection.add(product.toMap());

      product.id = docRef.id;

      await ordercCollection.doc(docRef.id).update(product.toMap());

      print("Order added with ID: ${product.id}");
    } catch (e) {
      print('Error adding order: $e');
    }
  }

  Future<void> addCart(Product product) async {
    print("Adding product to Cart");
    try {
      QuerySnapshot querySnapshot = await cartCollection
          .where('productname', isEqualTo: product.productName)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        print("Product is already in the cart");
        return;
      }

      DocumentReference docRef = await cartCollection.add(product.toMap());

      product.id = docRef.id;

      // Update the cart product with the docRef.id in Firestore
      await cartCollection.doc(docRef.id).update(product.toMap());

      print("Product added to cart with ID: ${product.id}");
    } catch (e) {
      print('Error adding product to cart: $e');
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

  // Retrieve all orders from Firestore
  Future<List<Product>> fetchOrders() async {
    try {
      QuerySnapshot querySnapshot = await ordercCollection.get();
      return querySnapshot.docs
          .map((doc) => Product.fromMap(doc.data() as Map<String, dynamic>))
          .toList();
    } catch (e) {
      print('Error fetching orders: $e');
      return [];
    }
  }

  // Remove a product from Firestore by doc.id
  Future<void> removeCart(Product product) async {
    print("Removing product from Cart with ID: ${product.id}");
    try {
      if (product.id != null && product.id!.isNotEmpty) {
        // Delete the product using its document ID
        await cartCollection.doc(product.id).delete();
        print("Product removed from cart with ID: ${product.id}");
      } else {
        print("Error: Product ID is null or empty");
      }
    } catch (e) {
      print('Error removing product from cart: $e');
    }
  }

  // Retrieve all products in the cart from Firestore
  Future<List<Product>> fetchCart() async {
    try {
      QuerySnapshot querySnapshot = await cartCollection.get();
      return querySnapshot.docs
          .map((doc) => Product.fromMap(doc.data() as Map<String, dynamic>)
            ..id = doc.id) // Assign document ID to the product
          .toList();
    } catch (e) {
      print('Error fetching products from cart: $e');
      return [];
    }
  }
}
