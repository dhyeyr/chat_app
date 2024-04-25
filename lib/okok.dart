

import 'package:flutter/material.dart';

class SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          _buildSliverAppBar(),
          // Add more slivers for settings content
          _buildSettingsContent(),
        ],
      ),
    );
  }

  Widget _buildSliverAppBar() {
    return SliverAppBar(
      expandedHeight: 200.0,
      flexibleSpace: FlexibleSpaceBar(
        title: Text('Settings'),
        background: Image.network(
          'https://images.unsplash.com/photo-1621155346337-1d19476ba7d6?q=80&w=2070&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
          fit: BoxFit.cover,
        ),
      ),
      floating: true,
      pinned: true,
      // snap: true,
      bottom: PreferredSize(preferredSize: Size(20, 20), child: Text("helo")),
      // Animation settings
      // Add more settings for custom animations
    );
  }

  Widget _buildSettingsContent() {
    return SliverList(
      delegate: SliverChildListDelegate([
        ListTile(
          leading: Icon(Icons.account_circle),
          title: Text('Account'),
          onTap: () {
            // Navigate to account settings
          },
        ),
        ListTile(
          leading: Icon(Icons.notifications),
          title: Text('Notifications'),
          onTap: () {
            // Navigate to notification settings
          },
        ), ListTile(
          leading: Icon(Icons.account_circle),
          title: Text('Account'),
          onTap: () {
            // Navigate to account settings
          },
        ),
        ListTile(
          leading: Icon(Icons.notifications),
          title: Text('Notifications'),
          onTap: () {
            // Navigate to notification settings
          },
        ), ListTile(
          leading: Icon(Icons.account_circle),
          title: Text('Account'),
          onTap: () {
            // Navigate to account settings
          },
        ),
        ListTile(
          leading: Icon(Icons.notifications),
          title: Text('Notifications'),
          onTap: () {
            // Navigate to notification settings
          },
        ), ListTile(
          leading: Icon(Icons.account_circle),
          title: Text('Account'),
          onTap: () {
            // Navigate to account settings
          },
        ),
        ListTile(
          leading: Icon(Icons.notifications),
          title: Text('Notifications'),
          onTap: () {
            // Navigate to notification settings
          },
        ), ListTile(
          leading: Icon(Icons.account_circle),
          title: Text('Account'),
          onTap: () {
            // Navigate to account settings
          },
        ),
        ListTile(
          leading: Icon(Icons.notifications),
          title: Text('Notifications'),
          onTap: () {
            // Navigate to notification settings
          },
        ), ListTile(
          leading: Icon(Icons.account_circle),
          title: Text('Account'),
          onTap: () {
            // Navigate to account settings
          },
        ),
        ListTile(
          leading: Icon(Icons.notifications),
          title: Text('Notifications'),
          onTap: () {
            // Navigate to notification settings
          },
        ), ListTile(
          leading: Icon(Icons.account_circle),
          title: Text('Account'),
          onTap: () {
            // Navigate to account settings
          },
        ),
        ListTile(
          leading: Icon(Icons.notifications),
          title: Text('Notifications'),
          onTap: () {
            // Navigate to notification settings
          },
        ), ListTile(
          leading: Icon(Icons.account_circle),
          title: Text('Account'),
          onTap: () {
            // Navigate to account settings
          },
        ),
        ListTile(
          leading: Icon(Icons.notifications),
          title: Text('Notifications'),
          onTap: () {
            // Navigate to notification settings
          },
        ), ListTile(
          leading: Icon(Icons.account_circle),
          title: Text('Account'),
          onTap: () {
            // Navigate to account settings
          },
        ),
        ListTile(
          leading: Icon(Icons.notifications),
          title: Text('Notifications'),
          onTap: () {
            // Navigate to notification settings
          },
        ), ListTile(
          leading: Icon(Icons.account_circle),
          title: Text('Account'),
          onTap: () {
            // Navigate to account settings
          },
        ),
        ListTile(
          leading: Icon(Icons.notifications),
          title: Text('Notifications'),
          onTap: () {
            // Navigate to notification settings
          },
        ), ListTile(
          leading: Icon(Icons.account_circle),
          title: Text('Account'),
          onTap: () {
            // Navigate to account settings
          },
        ),
        ListTile(
          leading: Icon(Icons.notifications),
          title: Text('Notifications'),
          onTap: () {
            // Navigate to notification settings
          },
        ), ListTile(
          leading: Icon(Icons.account_circle),
          title: Text('Account'),
          onTap: () {
            // Navigate to account settings
          },
        ),
        ListTile(
          leading: Icon(Icons.notifications),
          title: Text('Notifications'),
          onTap: () {
            // Navigate to notification settings
          },
        ), ListTile(
          leading: Icon(Icons.account_circle),
          title: Text('Account'),
          onTap: () {
            // Navigate to account settings
          },
        ),
        ListTile(
          leading: Icon(Icons.notifications),
          title: Text('Notifications'),
          onTap: () {
            // Navigate to notification settings
          },
        ), ListTile(
          leading: Icon(Icons.account_circle),
          title: Text('Account'),
          onTap: () {
            // Navigate to account settings
          },
        ),
        ListTile(
          leading: Icon(Icons.notifications),
          title: Text('Notifications'),
          onTap: () {
            // Navigate to notification settings
          },
        ), ListTile(
          leading: Icon(Icons.account_circle),
          title: Text('Account'),
          onTap: () {
            // Navigate to account settings
          },
        ),
        ListTile(
          leading: Icon(Icons.notifications),
          title: Text('Notifications'),
          onTap: () {
            // Navigate to notification settings
          },
        ), ListTile(
          leading: Icon(Icons.account_circle),
          title: Text('Account'),
          onTap: () {
            // Navigate to account settings
          },
        ),
        ListTile(
          leading: Icon(Icons.notifications),
          title: Text('Notifications'),
          onTap: () {
            // Navigate to notification settings
          },
        ), ListTile(
          leading: Icon(Icons.account_circle),
          title: Text('Account'),
          onTap: () {
            // Navigate to account settings
          },
        ),
        ListTile(
          leading: Icon(Icons.notifications),
          title: Text('Notifications'),
          onTap: () {
            // Navigate to notification settings
          },
        ),
        // Add more ListTile widgets for other settings options
      ]),
    );
  }
}
