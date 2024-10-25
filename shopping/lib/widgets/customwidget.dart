import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shopping/main.dart';
import 'package:shopping/model/model.dart';
import 'package:shopping/repository/firestore.dart';
import 'package:shopping/store/sharedprefernce.dart';

import '../pages/addproduct.dart';

// 1.Custom Widget for PopupMenu
class MoreOptionsMenu extends StatelessWidget {
  const MoreOptionsMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: PopupMenuButton<int>(
        color: Colors.white,
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
            _showLogoutDialog(context);
          }
        },
        itemBuilder: (context) => [
          const PopupMenuItem(
            value: 1,
            child: Text(
              "Add Products",
              style: TextStyle(color: Colors.grey),
            ),
          ),
          const PopupMenuItem(
            value: 2,
            child: Text(
              "Order Details",
              style: TextStyle(color: Colors.grey),
            ),
          ),
          const PopupMenuItem(
            value: 3,
            child: Text(
              "Logout",
              style: TextStyle(color: Colors.grey),
            ),
          ),
        ],
      ),
    );
  }

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(
            "Logout",
            style: TextStyle(color: Colors.red),
          ),
          content: const Text("Are you sure you want to logout?"),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                // Close the dialog
                Navigator.of(context).pop();
              },
              child: const Text("Cancel"),
            ),
            TextButton(
              onPressed: () async {
                // Clear the login state and navigate to the login page
                await SharedPrefService.clearLoginState();
                // Navigate to the login page (replace with your login page)
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginScreen()),
                  (route) => false, // Remove all routes
                );
              },
              child: const Text("OK"),
            ),
          ],
        );
      },
    );
  }
}

// 2.Placeholder for SettingsPage
class SettingsPage extends StatelessWidget {
  SettingsPage({super.key});
  final ProductService productService = ProductService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Orders'),
      ),
      body: FutureBuilder<List<Product>>(
        future: productService.fetchOrders(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No orders found.'));
          }

          final orders = snapshot.data!;
          getTotal() {
            var sum = 0.0;
            for (var element in snapshot.data!) {
              // print("Mohan : ${element.price}");
              sum += element.price;
            }
            return sum;
          }

          // print(getTotal());
          return Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: orders.length,
                  itemBuilder: (context, index) {
                    final order = orders[index];
                    return Card(
                      margin: const EdgeInsets.all(8),
                      child: ListTile(
                        leading: SizedBox(
                          width: 100,
                          height: 100,
                          child: CachedNetworkImage(
                            fit: BoxFit.cover,
                            imageUrl: order.imageUrl ?? '',
                            placeholder: (context, url) => const Center(
                                child: CircularProgressIndicator()),
                            errorWidget: (context, url, error) =>
                                const Icon(Icons.error),
                            // height: 50,
                          ),
                        ),
                        title: Text(
                          order.productName,
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  Icons.star,
                                  color: Colors.amber,
                                ),
                                Text('${order.rating.toStringAsFixed(1)}'),
                              ],
                            ),
                            Text(
                              'Vanish Rate: \$${order.vanishRate}',
                              style: TextStyle(
                                  decoration: TextDecoration.lineThrough),
                            ), // You can add more fields here
                          ],
                        ),
                        trailing: Text('\$${order.price.toStringAsFixed(2)}'),
                      ),
                    );
                  },
                ),
              ),
              Container(
                color: Colors.orange[300],
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      const Text(
                        "Purchase of this Month",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20.0,
                            color: Colors.blue),
                      ),
                      const Expanded(child: SizedBox()),
                      Text(
                        "\$ ${getTotal().toStringAsFixed(1)}   ",
                        style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.green),
                      )
                    ],
                  ),
                ),
              )
            ],
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
