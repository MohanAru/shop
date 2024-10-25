import 'package:flutter/material.dart';
import 'package:shopping/model/model.dart';
import 'package:shopping/repository/firestore.dart';

import '../pages/addproduct.dart';

// 1.Custom Widget for PopupMenu
class MoreOptionsMenu extends StatelessWidget {
  const MoreOptionsMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: PopupMenuButton<int>(
        icon: const Icon(Icons.more_vert), // More options icon
        onSelected: (value) {
          if (value == 1) {
            // Navigate to Profile Page
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const ProfilePage()),
            );
          } else if (value == 2) {
            // Navigate to Settings Page
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => SettingsPage()),
            );
          } else if (value == 3) {
            // Log out action
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const LogoutPage()),
            );
          }
        },
        itemBuilder: (context) => [
          const PopupMenuItem(
            value: 1,
            child: Text("Add Products"),
          ),
          const PopupMenuItem(
            value: 2,
            child: Text("Settings"),
          ),
          const PopupMenuItem(
            value: 3,
            child: Text("Logout"),
          ),
        ],
      ),
    );
  }
}

// 2.Placeholder for SettingsPage
class SettingsPage extends StatelessWidget {
  SettingsPage({super.key});
  final ProductService productService =
      ProductService(); // Initialize ProductService

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Orders'),
      ),
      body: FutureBuilder<List<Product>>(
        future: productService.fetchOrders(), // Call fetchOrders method
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No orders found.'));
          }

          final orders = snapshot.data!;

          return ListView.builder(
            itemCount: orders.length,
            itemBuilder: (context, index) {
              final order = orders[index];
              return Card(
                margin: const EdgeInsets.all(8),
                child: ListTile(
                  leading: Image.network(
                    order.imageUrl,
                    fit: BoxFit.cover,
                    width: 60,
                    height: 60,
                    errorBuilder: (context, error, stackTrace) =>
                        const Icon(Icons.error),
                  ),
                  title: Text(order.productName),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Price: \$${order.price.toStringAsFixed(2)}'),
                      Text(
                          'Quantity: ${order.vanishRate}'), // You can add more fields here
                    ],
                  ),
                  trailing: Text('\$${order.price.toStringAsFixed(2)}'),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

// 3.Placeholder for LogoutPage
class LogoutPage extends StatelessWidget {
  const LogoutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Logout')),
      body: const Center(child: Text('Logout Page')),
    );
  }
}
