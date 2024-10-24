import 'package:flutter/material.dart';

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
              MaterialPageRoute(builder: (context) => const SettingsPage()),
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
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: const Center(child: Text('Settings Page')),
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
