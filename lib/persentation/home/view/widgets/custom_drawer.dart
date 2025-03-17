import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mini_app/core/constants.dart';
import 'package:mini_app/generated/l10n.dart';
import 'package:mini_app/persentation/cart_view/view_model/cart_view_model.dart';
import 'package:mini_app/persentation/edit_profile/view/profile_edit_screen.dart';
import 'package:mini_app/persentation/home/view/home_view.dart';
import 'package:mini_app/persentation/auth/view/login_view.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CustomDrawer extends StatefulWidget {
  const CustomDrawer({
    super.key,
    required this.widget,
  });

  final HomeScreen widget;

  @override
  State<CustomDrawer> createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  String? profileImagePath;

  @override
  void initState() {
    super.initState();
    _loadProfileImage();
  }

  // Load saved profile image path from SharedPreferences
  Future<void> _loadProfileImage() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      profileImagePath = prefs.getString('profile_image_path');
    });
  }

  // Clear profile image path and reset to default
  Future<void> _clearProfileImage() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('profile_image_path');
    setState(() {
      profileImagePath = null; // Reset profile image
    });
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          UserAccountsDrawerHeader(
            currentAccountPicture: CircleAvatar(
              backgroundImage: profileImagePath != null && profileImagePath!.isNotEmpty
                  ? FileImage(File(profileImagePath!)) // Load local image
                  : NetworkImage(
                      widget.widget.profileImage?.isNotEmpty == true
                          ? widget.widget.profileImage!
                          : Constants().default_image,
                    ) as ImageProvider,
            ),
            accountName: Text('${widget.widget.firstName} ${widget.widget.lastName!}'),
            accountEmail: Text(widget.widget.email!),
          ),
          ListTile(
            leading: const Icon(Icons.edit),
            title: Text(S.current.edit_profile),
            onTap: () async {
              await _clearProfileImage(); // Clear image before editing
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const ProfileEditScreen()),
              ).then((_) => _loadProfileImage()); // Reload image after editing
            },
          ),
          Consumer<CartViewModel>(
            builder: (context, localeProvider, child) {
              return ListTile(
                leading: const Icon(Icons.language),
                title: Text(localeProvider.locale.languageCode == 'ar'
                    ? S.current.english
                    : S.current.arabic),
                trailing: Switch(
                  value: localeProvider.locale.languageCode == 'ar',
                  onChanged: (value) {
                    localeProvider.toggleLocale();
                  },
                ),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.logout),
            title: Text(S.current.logout),
            onTap: () async {
              await _clearProfileImage(); // Clear image on logout
              await FirebaseAuth.instance.signOut();
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (_) => const LoginView()),
                (Route<dynamic> route) => false,
              );
            },
          ),
        ],
      ),
    );
  }
}
