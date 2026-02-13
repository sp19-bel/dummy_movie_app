import 'package:flutter/material.dart';
import 'package:test_app/src/core/config/theme/app_colors.dart';

class MoreScreen extends StatelessWidget {
  const MoreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('More'),
        centerTitle: true,
      ),
      body: ListView(
        children: const [
          ListTile(
            leading: Icon(Icons.settings_outlined, color: AppColors.textGrey),
            title: Text('Settings'),
            trailing: Icon(Icons.chevron_right),
          ),
          Divider(height: 1),
          ListTile(
            leading: Icon(Icons.help_outline, color: AppColors.textGrey),
            title: Text('Help & Support'),
            trailing: Icon(Icons.chevron_right),
          ),
          Divider(height: 1),
          ListTile(
            leading: Icon(Icons.info_outline, color: AppColors.textGrey),
            title: Text('About'),
            trailing: Icon(Icons.chevron_right),
          ),
          Divider(height: 1),
          ListTile(
            leading: Icon(Icons.privacy_tip_outlined, color: AppColors.textGrey),
            title: Text('Privacy Policy'),
            trailing: Icon(Icons.chevron_right),
          ),
        ],
      ),
    );
  }
}
